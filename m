From: cd2436@columbia.edu (Christoffer Dall)
Date: Sun, 18 Apr 2010 23:16:10 +0200
Subject: [Android-virt] cache problems with mmap'ed data structure in KVM
In-Reply-To: <v2nfb412d761004151219va46cd840v5b2b67f022536b70@mail.gmail.com>
References: <q2p7d08b87d1004140829m9fc9bc6vab970f7c2e45aa0c@mail.gmail.com>
	<v2nfb412d761004151219va46cd840v5b2b67f022536b70@mail.gmail.com>
Message-ID: <g2z7d08b87d1004181416yb819bc4ax433663f97f24be0e@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 15, 2010 at 9:19 PM, Hollis Blanchard <hollis@penguinppc.org> wrote:
> On Wed, Apr 14, 2010 at 8:29 AM, Christoffer Dall <cd2436@columbia.edu> wrote:
>> When booting a guest on an arm1136 physical cpu using my KVM
>> implementation (https://wiki.ncl.cs.columbia.edu/wiki/index.php/AndroidVirt:MainPage),
>> I get some distorted output in QEMU, which performs device emulation
>> for the kernel and thereby emulates a pl011 serial device.
>>
>> QEMU shares a data structure with the kernel by mmap'ing a file
>> descriptor like this:
>> ?env->kvm_run = mmap(NULL, mmap_size, PROT_READ | PROT_WRITE,
>> MAP_SHARED, env->kvm_fd, 0);
>>
>> The problem arises when the kernel writes to this data structure using
>> the kernel virtual addresses. The data does not seem to be
>> synchronized to the user space application reads.
>
> It sounds like you've already figured out the VIVT caching problems.

I'm currently working with an ARM1136EJ-S processor with VIPT caching,
but yes, same aliasing issues arise.

>
>> I'm guessing that I need to initiate a cache writeback on the kernel
>> side and a re-read on the user space side, but I'm unsure what the
>> right way to go about it is.
>
> The simplest might be to map this structure uncached on both sides
> (kernel and user).
>
> As an alternative, you might be able to use flush_user_range() and
> flush_kern_dcache_area() (see arch/arm/include/asm/cacheflush.h). That
> wouldn't really work with host SMP, but then again with host SMP you
> probably will have different cache design that will avoid the problem
> to begin with.

I tried the functions you also mention here, but I couldn't get them
to flush the user space mapping and I think they require that I know
the user space VA (or corresponding vma), which would then have to be
copied somewhere from the mmap functions in kvm_main.c

However, I changed the kvm_vcpu_fault(...) function to do:

page->mapping = vma->fm_file->f_mapping;
__SetPageUptodate(page);

which in turn allowed me to call flush_dcache_page(virt_to_page(run));
in kvm_arch_vcpu_ioctl_run(...) and it seems to work as intented. The
comments on flush_dcache_page seem to suggest that this is in fact the
intention with this function, but if this is the "right" and most
efficient way, I'm not sure.

In any case, thanks for keeping me on track!
