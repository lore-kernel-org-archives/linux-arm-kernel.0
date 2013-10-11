From: robdclark@gmail.com (Rob Clark)
Date: Thu, 10 Oct 2013 20:10:58 -0400
Subject: [PATCH 2/5] DRM: Armada: Add Armada DRM driver
In-Reply-To: <20131010225331.GT25034@n2100.arm.linux.org.uk>
References: <20131006220728.GG12758@n2100.arm.linux.org.uk>
 <E1VSwVU-0000hu-09@rmk-PC.arm.linux.org.uk>
 <CAF6AEGsvBaX5+c1P=ups+k=d1F3r+JphgYOt5wb7pEM3mihOQw@mail.gmail.com>
 <20131010215951.GS25034@n2100.arm.linux.org.uk>
 <CAF6AEGvNyD8-_t2y69a5Gjey7Jg_LXVYNgpYW1rsFFyTkABg=Q@mail.gmail.com>
 <20131010225331.GT25034@n2100.arm.linux.org.uk>
Message-ID: <CAF6AEGvb-oeQqYF-XyZ1PjCaqojJ=DurLVGkZxUFwC_WveoTwg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 10, 2013 at 6:53 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Oct 10, 2013 at 06:23:26PM -0400, Rob Clark wrote:
>> On Thu, Oct 10, 2013 at 5:59 PM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > On Thu, Oct 10, 2013 at 05:25:15PM -0400, Rob Clark wrote:
>> >> probably this thread is applicable here too?
>> >>
>> >> https://lkml.org/lkml/2013/9/12/417
>> >>
>> >> (although.. we have at least a few  slightly differet variants on the
>> >> same errno -> VM_FAULT_x switch in different drivers.. maybe we should
>> >> do something better)
>> >
>> > Hmm.  It seems today's vm_insert_pfn() has the following error return
>> > values:
>> >
>> > -EFAULT - virtual address outside vma
>> > -EINVAL - track_pfn_insert() failure
>> > -ENOMEM - failed to get locked pte
>> > -EBUSY - entry already exists in pte
>> >
>> > So it seems my handling -EIO, -EAGAIN, -ERESTARTSYS and -EINTR are all
>> > redundant and can be removed.  I'm not sure if it makes sense for this
>> > to be generic - it looks like it's only Intel, gma500 and me who use
>> > this, and Intel handles more error codes (due to it calling other
>> > functions.)
>>
>> I just noticed msm and omapdrm are missing the -EBUSY case (have some
>> patches I need to send), which was why I mentioned this.  They do have
>> other error cases from other fxns, so maybe something generic/common
>> doesn't make sense..  but I realized i915 fixed the same issue a while
>> back, so somewhere common has the advantage of somehow not forgetting
>> to fix other drivers ;-)
>
> Here's the promised delta:

looks good.. I'll try to get to reviewing the rest of the series
tomorrow, or at least before the end of the weekend

Reviewed-by: Rob Clark <robdclark@gmail.com>

BR,
-R

>  drivers/gpu/drm/armada/armada_gem.c |    5 -----
>  1 files changed, 0 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/armada/armada_gem.c b/drivers/gpu/drm/armada/armada_gem.c
> index 02de7a4..1e74f70 100644
> --- a/drivers/gpu/drm/armada/armada_gem.c
> +++ b/drivers/gpu/drm/armada/armada_gem.c
> @@ -25,12 +25,7 @@ static int armada_gem_vm_fault(struct vm_area_struct *vma, struct vm_fault *vmf)
>         ret = vm_insert_pfn(vma, addr, pfn);
>
>         switch (ret) {
> -       case -EIO:
> -       case -EAGAIN:
> -               set_need_resched();
>         case 0:
> -       case -ERESTARTSYS:
> -       case -EINTR:
>         case -EBUSY:
>                 return VM_FAULT_NOPAGE;
>         case -ENOMEM:
>
