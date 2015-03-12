From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 12 Mar 2015 19:51:16 +0000
Subject: [PATCH 08/22] ARM: %pF is only for function pointers
In-Reply-To: <1426130037-17956-8-git-send-email-scottwood@freescale.com>
References: <1426130037-17956-1-git-send-email-scottwood@freescale.com>
 <1426130037-17956-8-git-send-email-scottwood@freescale.com>
Message-ID: <20150312195116.GV8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 11, 2015 at 10:13:43PM -0500, Scott Wood wrote:
> Use %pS for actual addresses, otherwise you'll get bad output
> on arches like ppc64 where %pF expects a function descriptor.  Even on
> other architectures, refrain from setting a bad example that people
> copy.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> Cc: linux-arm-kernel at lists.infradead.org

Would've been nice to have been Cc'd on the patch, but luckily I saw it
amongst all the traffic anyway.  If the trivial folk want to take it:

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

Thanks.

> ---
>  arch/arm/mm/alignment.c   | 2 +-
>  arch/arm/nwfpe/fpmodule.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
> index 2c0c541..3419550 100644
> --- a/arch/arm/mm/alignment.c
> +++ b/arch/arm/mm/alignment.c
> @@ -132,7 +132,7 @@ static const char *usermode_action[] = {
>  static int alignment_proc_show(struct seq_file *m, void *v)
>  {
>  	seq_printf(m, "User:\t\t%lu\n", ai_user);
> -	seq_printf(m, "System:\t\t%lu (%pF)\n", ai_sys, ai_sys_last_pc);
> +	seq_printf(m, "System:\t\t%lu (%pS)\n", ai_sys, ai_sys_last_pc);
>  	seq_printf(m, "Skipped:\t%lu\n", ai_skipped);
>  	seq_printf(m, "Half:\t\t%lu\n", ai_half);
>  	seq_printf(m, "Word:\t\t%lu\n", ai_word);
> diff --git a/arch/arm/nwfpe/fpmodule.c b/arch/arm/nwfpe/fpmodule.c
> index ec717c1..2d2bfe2 100644
> --- a/arch/arm/nwfpe/fpmodule.c
> +++ b/arch/arm/nwfpe/fpmodule.c
> @@ -147,7 +147,7 @@ void float_raise(signed char flags)
>  #ifdef CONFIG_DEBUG_USER
>  	if (flags & debug)
>   		printk(KERN_DEBUG
> -		       "NWFPE: %s[%d] takes exception %08x at %pf from %08lx\n",
> +		       "NWFPE: %s[%d] takes exception %08x at %ps from %08lx\n",
>  		       current->comm, current->pid, flags,
>  		       __builtin_return_address(0), GET_USERREG()->ARM_pc);
>  #endif
> -- 
> 2.1.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
