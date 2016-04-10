From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sun, 10 Apr 2016 14:16:43 +0200
Subject: [PATCH v7 16/16] arm64: hibernate: Prevent resume from a
 different kernel version
In-Reply-To: <1459529620-22150-17-git-send-email-james.morse@arm.com>
References: <1459529620-22150-1-git-send-email-james.morse@arm.com>
 <1459529620-22150-17-git-send-email-james.morse@arm.com>
Message-ID: <CAKv+Gu-3iATexGcGCdqvvWsEya64iMpLKcDhSh-d70MfmV3ZwA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,

On 1 April 2016 at 18:53, James Morse <james.morse@arm.com> wrote:
> Resuming using a different kernel version is fragile, while there are
> sufficient details in the hibernate arch-header to perform the restore,
> changes in the boot process can have a long-lasting impact on the system.
> In particular, if the EFI stub causes more runtime services memory to be
> allocated,

Actually, the UEFI stub does not allocate any runtime service code or
data memory, that is all done by the firmware itself before even
invoking the kernel or the stub. The allocations performed by the stub
are for the command line, the UEFI memory map, the kernel image and
optionally an initrd, none if which have any significance to the
firmware itself, so allocating runtime services memory for them does
not make a lot of sense.

So I think that means that the UEFI memory map can simply be restored
from the hibernation image wherever it resided originally. The only
thing that does need to happen is validating that the memory map still
matches our expectations, by comparing the hibernated version to the
memory map supplied by the current boot. Note that this is completely
independent from firmware or kernel versions: anything that may
influence the behavior of the boot loader stage (such as having a USB
thumb drive plugged in) could result in a different memory map when
booting the same firmware version.





> the amount of memory left for linux is reduced. If we are
> lucky, this will cause restore to fail with the message:
>> PM: Image mismatch: memory size
> If we are unlucky, the system will explode sometime later when an EFI
> runtime services call is made.
>
> Prevent resuming with a different kernel build, by storing UTS_VERSION
> in the hibernate header. This also ensures the page size and va bits
> configuration remain the same.
>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  arch/arm64/kernel/hibernate.c | 35 +++++------------------------------
>  1 file changed, 5 insertions(+), 30 deletions(-)
>
> diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
> index 279c556ee24b..486315249f2a 100644
> --- a/arch/arm64/kernel/hibernate.c
> +++ b/arch/arm64/kernel/hibernate.c
> @@ -20,6 +20,7 @@
>  #include <linux/pm.h>
>  #include <linux/sched.h>
>  #include <linux/suspend.h>
> +#include <linux/utsname.h>
>  #include <linux/version.h>
>
>  #include <asm/barrier.h>
> @@ -42,8 +43,6 @@
>  #define pud_index(x)   0
>  #endif
>
> -#define TCR_IPS_BITS (0x7UL<<32)
> -
>  /*
>   * Hibernate core relies on this value being 0 on resume, and marks it
>   * __nosavedata assuming it will keep the resume kernel's '0' value. This
> @@ -54,17 +53,6 @@
>   */
>  extern int in_suspend;
>
> -/*
> - * This value is written to the hibernate arch header, and prevents resuming
> - * from a hibernate image produced by an incompatible kernel. If you change
> - * a value that isn't saved/restored by hibernate, you should change this value.
> - *
> - * For example, if the mair_el1 values used by the kernel are changed, you
> - * should prevent resuming from a kernel with incompatible attributes, as these
> - * aren't saved/restored.
> - */
> -#define HIBERNATE_VERSION      KERNEL_VERSION(4, 6, 0)
> -
>  /* Find a symbols alias in the linear map */
>  #define LMADDR(x)      phys_to_virt(virt_to_phys(x))
>
> @@ -81,8 +69,7 @@ extern char hibernate_el2_vectors[];
>  extern char el2_setup[];
>
>  struct arch_hibernate_hdr_invariants {
> -       unsigned long   version;
> -       unsigned long   tcr_el1;        /* page_size, va bit etc */
> +       char            uts_version[__NEW_UTS_LEN + 1];
>  };
>
>  /* These values need to be know across a hibernate/restore. */
> @@ -104,11 +91,8 @@ static struct arch_hibernate_hdr {
>
>  static inline void arch_hdr_invariants(struct arch_hibernate_hdr_invariants *i)
>  {
> -       i->version = HIBERNATE_VERSION;
> -       asm volatile("mrs       %0, tcr_el1" : "=r"(i->tcr_el1));
> -
> -       /* IPS bits vary on big/little systems, mask them out */
> -       i->tcr_el1 &= ~TCR_IPS_BITS;
> +       memset(i, 0, sizeof(*i));
> +       memcpy(i->uts_version, init_utsname()->version, sizeof(i->uts_version));
>  }
>
>  int pfn_is_nosave(unsigned long pfn)
> @@ -155,18 +139,9 @@ int arch_hibernation_header_restore(void *addr)
>         struct arch_hibernate_hdr_invariants invariants;
>         struct arch_hibernate_hdr *hdr = addr;
>
> -       /*
> -        * If this header is ancient, it may be smaller than we expect.
> -        * Test the version first.
> -        */
> -       if (hdr->invariants.version != HIBERNATE_VERSION) {
> -               pr_crit("Hibernate image not compatible with this kernel version!\n");
> -               return -EINVAL;
> -       }
> -
>         arch_hdr_invariants(&invariants);
>         if (memcmp(&hdr->invariants, &invariants, sizeof(invariants))) {
> -               pr_crit("Hibernate image not compatible with this kernel configuration!\n");
> +               pr_crit("Hibernate image not generated by this kernel!\n");
>                 return -EINVAL;
>         }
>
> --
> 2.8.0.rc3
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
