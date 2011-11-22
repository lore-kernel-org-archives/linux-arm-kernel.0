From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 22 Nov 2011 13:41:24 +0000
Subject: [PATCH v6 2/5] ARM: reset: implement soft_restart for jumping to
 a physical address
In-Reply-To: <1321466057-19721-3-git-send-email-will.deacon@arm.com>
References: <1321466057-19721-1-git-send-email-will.deacon@arm.com>
 <1321466057-19721-3-git-send-email-will.deacon@arm.com>
Message-ID: <CAHkRjk4e7EEVsoM9oPBa993FZubO5trXDmw6S3VAq4s4wLTwzg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 November 2011 17:54, Will Deacon <will.deacon@arm.com> wrote:
> Tools such as kexec and CPU hotplug require a way to reset the processor
> and branch to some code in physical space. This requires various bits of
> jiggery pokery with the caches and MMU which, when it goes wrong, tends
> to lock up the system.
>
> This patch fleshes out the soft_restart implementation so that it
> branches to the reset code using the identity mapping. This requires us
> to change to a temporary stack, held within the kernel image as a static
> array, to avoid conflicting with the new view of memory.
>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
> ?arch/arm/kernel/process.c | ? 51 ++++++++++++++++++++++++++++++++++----------
> ?1 files changed, 39 insertions(+), 12 deletions(-)
>
> diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
> index a92ca50..577d092 100644
> --- a/arch/arm/kernel/process.c
> +++ b/arch/arm/kernel/process.c
> @@ -92,29 +92,56 @@ static int __init hlt_setup(char *__unused)
> ?__setup("nohlt", nohlt_setup);
> ?__setup("hlt", hlt_setup);
>
> -void soft_restart(unsigned long addr)
> +extern void call_with_stack(void (*fn)(void *), void *arg, void *sp);
> +typedef void (*phys_reset_t)(unsigned long);
> +
> +/*
> + * A temporary stack to use for CPU reset. This is static so that we
> + * don't clobber it with the identity mapping. When running with this
> + * stack, any references to the current task *will not work* so you
> + * should really do as little as possible before jumping to your reset
> + * code.
> + */
> +#define SOFT_RESTART_STACK_WORDS ? ? ? 32
> +static u32 soft_restart_stack[SOFT_RESTART_STACK_WORDS];

Just for ABI stack alignment requirements, do we get the right
alignment of this array in memory?

> +static void __soft_restart(void *addr)
> ?{
> - ? ? ? /* Disable interrupts first */
> - ? ? ? local_irq_disable();
> - ? ? ? local_fiq_disable();
> + ? ? ? phys_reset_t phys_reset;
>
> - ? ? ? /*
> - ? ? ? ?* Tell the mm system that we are going to reboot -
> - ? ? ? ?* we may need it to insert some 1:1 mappings so that
> - ? ? ? ?* soft boot works.
> - ? ? ? ?*/
> + ? ? ? /* Take out a flat memory mapping. */
> ? ? ? ?setup_mm_for_reboot();
>
> - ? ? ? /* Clean and invalidate caches */
> + ? ? ? /* Clean and invalidate caches. */
> ? ? ? ?flush_cache_all();
>
> - ? ? ? /* Turn off caching */
> + ? ? ? /* Turn off caching. */
> ? ? ? ?cpu_proc_fin();

A few unnecessary comment changes :) (it's not clear in the Linux
coding style but many single-line comments don't have a full-stop.

> ? ? ? ?/* Push out any further dirty data, and ensure cache is empty */
> ? ? ? ?flush_cache_all();
>
> - ? ? ? cpu_reset(addr);
> + ? ? ? /* Switch to the identity mapping. */
> + ? ? ? phys_reset = (phys_reset_t)(unsigned long)virt_to_phys(cpu_reset);
> + ? ? ? phys_reset((unsigned long)addr);
> +
> + ? ? ? /* Should never get here. */
> + ? ? ? BUG();
> +}
> +
> +void soft_restart(unsigned long addr)
> +{
> + ? ? ? u32 *stack = soft_restart_stack + SOFT_RESTART_STACK_WORDS;

We could use ARRAY_SIZE() here and just avoid defining SOFT_RESTART_STACK_WORDS.

-- 
Catalin
