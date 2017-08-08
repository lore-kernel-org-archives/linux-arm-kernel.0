From: 0x7f454c46@gmail.com (Dmitry Safonov)
Date: Tue, 8 Aug 2017 12:29:50 +0300
Subject: [PATCH] arm64/vdso: Support mremap() for vDSO
In-Reply-To: <20170802160401.GA16932@arm.com>
References: <20170726170737.21696-1-dsafonov@virtuozzo.com>
 <20170728164800.GD14170@arm.com>
 <CAJwJo6bCxRvKvwmwwH7UZW2fRZkqTTqfnp0j85Si454pDQUjVw@mail.gmail.com>
 <20170802160401.GA16932@arm.com>
Message-ID: <CAJwJo6bKgZnH+3RRGb_G1SN06hyx=g49OMrrZS8F3PoMa3t-sA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-08-02 19:04 GMT+03:00 Will Deacon <will.deacon@arm.com>:
> On Fri, Jul 28, 2017 at 10:06:20PM +0300, Dmitry Safonov wrote:
>> 2017-07-28 19:48 GMT+03:00 Will Deacon <will.deacon@arm.com>:
>> > On Wed, Jul 26, 2017 at 08:07:37PM +0300, Dmitry Safonov wrote:
>> >> vDSO VMA address is saved in mm_context for the purpose of using
>> >> restorer from vDSO page to return to userspace after signal handling.
>> >>
>> >> In Checkpoint Restore in Userspace (CRIU) project we place vDSO VMA
>> >> on restore back to the place where it was on the dump.
>> >> With the exception for x86 (where there is API to map vDSO with
>> >> arch_prctl()), we move vDSO inherited from CRIU task to restoree
>> >> position by mremap().
>> >>
>> >> CRIU does support arm64 architecture, but kernel doesn't update
>> >> context.vdso pointer after mremap(). Which results in translation
>> >> fault after signal handling on restored application:
>> >> https://github.com/xemul/criu/issues/288
>> >>
>> >> Make vDSO code track the VMA address by supplying .mremap() fops
>> >> the same way it's done for x86 and arm32 by:
>> >> commit b059a453b1cf ("x86/vdso: Add mremap hook to vm_special_mapping")
>> >> commit 280e87e98c09 ("ARM: 8683/1: ARM32: Support mremap() for sigpage/vDSO").
>> >>
>> >> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> >> Cc: Will Deacon <will.deacon@arm.com>
>> >> Cc: Russell King <rmk+kernel@armlinux.org.uk>
>> >> Cc: linux-arm-kernel at lists.infradead.org
>> >> Cc: Cyrill Gorcunov <gorcunov@openvz.org>
>> >> Cc: Pavel Emelyanov <xemul@virtuozzo.com>
>> >> Cc: Christopher Covington <cov@codeaurora.org>
>> >> Signed-off-by: Dmitry Safonov <dsafonov@virtuozzo.com>
>> >> ---
>> >>  arch/arm64/kernel/vdso.c | 15 +++++++++++++++
>> >>  1 file changed, 15 insertions(+)
>> >>
>> >> diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
>> >> index e8f759f764f2..2d419006ad43 100644
>> >> --- a/arch/arm64/kernel/vdso.c
>> >> +++ b/arch/arm64/kernel/vdso.c
>> >> @@ -110,12 +110,27 @@ int aarch32_setup_vectors_page(struct linux_binprm *bprm, int uses_interp)
>> >>  }
>> >>  #endif /* CONFIG_COMPAT */
>> >>
>> >> +static int vdso_mremap(const struct vm_special_mapping *sm,
>> >> +             struct vm_area_struct *new_vma)
>> >> +{
>> >> +     unsigned long new_size = new_vma->vm_end - new_vma->vm_start;
>> >> +     unsigned long vdso_size = vdso_end - vdso_start;
>> >
>> > You might be able to use vdso_pages here, but it depends on my question
>> > below.
>>
>> Yes, shifting with PAGE_SHIFT.
>> Is it just a preference?
>
> Yeah, just a minor thing, although thinking about it again, I don't know
> what you're trying to achieve with the size check anyway. Userspace is only
> going to hurt itself if it screws up the layout, so why police this?

Well, it's for keeping the same semantics as on x86.
The idea of restriction to partial mremap() is suggested by Andy
so that userspace won't be allowed to hurt itself and to simplify
kernel code on x86.

>
>> >
>> >> +
>> >> +     if (vdso_size != new_size)
>> >> +             return -EINVAL;
>> >> +
>> >> +     current->mm->context.vdso = (void *)new_vma->vm_start;
>> >> +
>> >> +     return 0;
>> >> +}
>> >> +
>> >>  static struct vm_special_mapping vdso_spec[2] __ro_after_init = {
>> >>       {
>> >>               .name   = "[vvar]",
>> >>       },
>> >>       {
>> >>               .name   = "[vdso]",
>> >> +             .mremap = vdso_mremap,
>> >
>> > Does this mean we move the vdso text, but not the data page? How does that
>> > work?
>>
>> Well, the kernel tracks only vdso pages - to find restorer addr after a signal.
>> In userspace one needs to move vvar and vdso vma pair accordingly,
>> with the same order and offset of course.
>
> Ah, I see. I misunderstood what the .mremap callback was actually doing.
> I guess there's also no issue with not being able to do this atomically,
> either, as long as you can avoid making syscalls via the vDSO until you've
> relocated both mappings.

Yes, also one should keep in mind that there might be some linker
work needed after mremap() of vdso. As some loaded libraries may
have been linked to vdso's vma addresses.

In CRIU we have `restorer' code which is PIE code, non-linked to
libc and calling raw syscalls rather than using vdso. And restoree
(the application being restored) is already linked to vdso's new position.

-- 
             Dmitry
