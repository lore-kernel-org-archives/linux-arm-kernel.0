From: robdclark@gmail.com (Rob Clark)
Date: Thu, 10 Oct 2013 18:23:26 -0400
Subject: [PATCH 2/5] DRM: Armada: Add Armada DRM driver
In-Reply-To: <20131010215951.GS25034@n2100.arm.linux.org.uk>
References: <20131006220728.GG12758@n2100.arm.linux.org.uk>
 <E1VSwVU-0000hu-09@rmk-PC.arm.linux.org.uk>
 <CAF6AEGsvBaX5+c1P=ups+k=d1F3r+JphgYOt5wb7pEM3mihOQw@mail.gmail.com>
 <20131010215951.GS25034@n2100.arm.linux.org.uk>
Message-ID: <CAF6AEGvNyD8-_t2y69a5Gjey7Jg_LXVYNgpYW1rsFFyTkABg=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 10, 2013 at 5:59 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Oct 10, 2013 at 05:25:15PM -0400, Rob Clark wrote:
>> On Sun, Oct 6, 2013 at 6:08 PM, Russell King
>> <rmk+kernel@arm.linux.org.uk> wrote:
>> > +       /*
>> > +        * If we have an overlay plane associated with this CRTC, disable
>> > +        * it before the modeset to avoid its coordinates being outside
>> > +        * the new mode parameters.  DRM doesn't provide help with this.
>> > +        */
>>
>> Getting a bit off topic, but yeah.. I'd be in favor of "clarifying"
>> things by having crtc helpers disable planes on setcrtc (rather than
>> only doing this on fbdev/lastclose restore).  I
>> don't know of any userspace that this would cause problems for.  But
>> not really sure if it would be considered an interface break or just
>> "fixing a bug".. since we have different behavior on different
>> drivers, I'd lean towards the latter.
>
> The reasoning here is if the overlay plane is larger than the mode being
> set, we will end up having the hardware programmed in an inconsistent
> state - the overlay plane position/width/height can be outside of the
> active region, which is invalid for the hardware.  So, it's safer to
> disable the plane and wait for the next plane to be sent and have that
> validated against the new mode.

right.  I think disabling the planes is the correct behavior.  So
nothing to do here for armada.  I mostly just wanted to get some
opinions about making the crtc helpers do this automatically for us.

> It's not like you would be able to see the plane immediately, because
> most monitors blank while they retrain to the new mode settings.
>
>> > +static int armada_gem_vm_fault(struct vm_area_struct *vma, struct vm_fault *vmf)
>> > +{
>> > +       struct armada_gem_object *obj = drm_to_armada_gem(vma->vm_private_data);
>> > +       unsigned long addr = (unsigned long)vmf->virtual_address;
>> > +       unsigned long pfn = obj->phys_addr >> PAGE_SHIFT;
>> > +       int ret;
>> > +
>> > +       pfn += (addr - vma->vm_start) >> PAGE_SHIFT;
>> > +       ret = vm_insert_pfn(vma, addr, pfn);
>> > +
>> > +       switch (ret) {
>> > +       case -EIO:
>> > +       case -EAGAIN:
>> > +               set_need_resched();
>>
>> probably this thread is applicable here too?
>>
>> https://lkml.org/lkml/2013/9/12/417
>>
>> (although.. we have at least a few  slightly differet variants on the
>> same errno -> VM_FAULT_x switch in different drivers.. maybe we should
>> do something better)
>
> Hmm.  It seems today's vm_insert_pfn() has the following error return
> values:
>
> -EFAULT - virtual address outside vma
> -EINVAL - track_pfn_insert() failure
> -ENOMEM - failed to get locked pte
> -EBUSY - entry already exists in pte
>
> So it seems my handling -EIO, -EAGAIN, -ERESTARTSYS and -EINTR are all
> redundant and can be removed.  I'm not sure if it makes sense for this
> to be generic - it looks like it's only Intel, gma500 and me who use
> this, and Intel handles more error codes (due to it calling other
> functions.)

I just noticed msm and omapdrm are missing the -EBUSY case (have some
patches I need to send), which was why I mentioned this.  They do have
other error cases from other fxns, so maybe something generic/common
doesn't make sense..  but I realized i915 fixed the same issue a while
back, so somewhere common has the advantage of somehow not forgetting
to fix other drivers ;-)

> I'll respin dropping those four unnecessary error codes, and post the
> delta for this.
>
>> > +/* Prime support */
>> > +struct sg_table *
>> > +armada_gem_prime_map_dma_buf(struct dma_buf_attachment *attach,
>> > +       enum dma_data_direction dir)
>> > +{
>> > +       struct drm_gem_object *obj = attach->dmabuf->priv;
>> > +       struct armada_gem_object *dobj = drm_to_armada_gem(obj);
>> > +       struct scatterlist *sg;
>> > +       struct sg_table *sgt;
>> > +       int i, num;
>> > +
>> > +       sgt = kmalloc(sizeof(*sgt), GFP_KERNEL);
>> > +       if (!sgt)
>> > +               return NULL;
>> > +
>> > +       if (dobj->obj.filp) {
>> > +               struct address_space *mapping;
>> > +               gfp_t gfp;
>> > +               int count;
>> > +
>> > +               count = dobj->obj.size / PAGE_SIZE;
>> > +               if (sg_alloc_table(sgt, count, GFP_KERNEL))
>> > +                       goto free_sgt;
>> > +
>> > +               mapping = file_inode(dobj->obj.filp)->i_mapping;
>> > +               gfp = mapping_gfp_mask(mapping);
>> > +
>> > +               for_each_sg(sgt->sgl, sg, count, i) {
>> > +                       struct page *page;
>> > +
>> > +                       page = shmem_read_mapping_page_gfp(mapping, i, gfp);
>>
>> you could almost use drm_gem_get_pages().. although I guess you
>> otherwise have no need for the page[] array?
>
> Correct.  The page[] array would just be an additional unnecessary
> allocation, and therefore would be an additional unnecessary point of
> failure.
>
>> > +#define DRM_ARMADA_GEM_CREATE          0x00
>> > +#define DRM_ARMADA_GEM_MMAP            0x02
>> > +#define DRM_ARMADA_GEM_PWRITE          0x03
>> > +
>> > +#define ARMADA_IOCTL(dir, name, str) \
>> > +       DRM_##dir(DRM_COMMAND_BASE + DRM_ARMADA_##name, struct drm_armada_##str)
>> > +
>> > +struct drm_armada_gem_create {
>>
>> Any reason not to throw in a 'uint32_t flags' field?  At least then
>> you could indicate what sort of backing memory you want, and do things
>> like allocate linear scanout buffer w/ your gem_create rather than
>> having to use dumb_create.  Maybe not something you need now, but
>> seems like eventually you'll come up with some reason or another to
>> want to pass some flags into gem_create.
>
> I thought one of the points of the dumb_create stuff was so that there
> is a standard API for dumb scanout buffers across all DRM drivers.  It
> has that advantage, and as I understand it, a generic KMS driver for X
> is on the cards.

Yeah, xf86-video-modesetting currently uses dumb allocation.  So you
definitely want to continue to support the dumb buffer path.

I can't really think of any immediate need for 'flags'..  but seems
like sooner or later someone will come up with some need for it, so it
seemed like a convenient placeholder to have.

Well, technically you can get away w/ adding new fields to the end of
the ioctl struct, and drm_ioctl() will take care of zero'ing that out
for you with an old userspace.  So I guess you could just rely on that
if you ever need to add 'flags' or some other fields.

> Thanks for the review.

no prob

BR,
-R
