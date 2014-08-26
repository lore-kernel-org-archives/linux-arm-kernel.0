From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 26 Aug 2014 21:01:33 +0100
Subject: [PATCH] setup: Move unmask of async interrupts after possible
 earlycon setup
In-Reply-To: <1409079338-14001-1-git-send-email-jcm@redhat.com>
References: <1409079338-14001-1-git-send-email-jcm@redhat.com>
Message-ID: <CACxGe6s_s=oufaEaaN6Hgz9rUzuGDX-c0RG_-JtYSP598FOeCw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 26, 2014 at 7:55 PM, Jon Masters <jcm@redhat.com> wrote:
> The kernel wants to enable reporting of asynchronous interrupts (i.e.
> System Errors) as early as possible. But if this happens too early
> then a pending System Error on initial entry into the kernel will
> never be reported where a user can see it (instead it will remain
> in the kernel ring buffer and be visible only via hardware debug).
> Therefore, move the enabling of asynchronous interrupts to after
> parsing any possible earlycon parameters setting up earlycon.
>
> Signed-off-by: Jon Masters <jcm@redhat.com>

That sounds wrong. Why aren't early log messages getting flushed out
when the console shows up?

g.

> ---
>  arch/arm64/kernel/setup.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index f6f0ccf..f849b88 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -362,11 +362,6 @@ u64 __cpu_logical_map[NR_CPUS] = { [0 ... NR_CPUS-1] = INVALID_HWID };
>
>  void __init setup_arch(char **cmdline_p)
>  {
> -       /*
> -        * Unmask asynchronous aborts early to catch possible system errors.
> -        */
> -       local_async_enable();
> -
>         setup_processor();
>
>         setup_machine_fdt(__fdt_pointer);
> @@ -382,6 +377,12 @@ void __init setup_arch(char **cmdline_p)
>
>         parse_early_param();
>
> +       /*
> +        *  Unmask asynchronous aborts after bringing up possible earlycon.
> +        * (Report possible System Errors once we can report this occurred)
> +        */
> +       local_async_enable();
> +
>         efi_init();
>         arm64_memblock_init();
>
> --
> 1.8.3.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
