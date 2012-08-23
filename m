From: will.deacon@arm.com (Will Deacon)
Date: Thu, 23 Aug 2012 11:43:56 +0100
Subject: [PATCH] ARM: fix cpu_relax() in case of doing dmb
In-Reply-To: <1345647138-8815-1-git-send-email-shawn.guo@linaro.org>
References: <1345647138-8815-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120823104356.GA13622@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 22, 2012 at 03:52:18PM +0100, Shawn Guo wrote:
> diff --git a/arch/arm/include/asm/processor.h b/arch/arm/include/asm/processor.h
> index 99afa74..7cc67ce 100644
> --- a/arch/arm/include/asm/processor.h
> +++ b/arch/arm/include/asm/processor.h
> @@ -80,7 +80,14 @@ extern void release_thread(struct task_struct *);
>  unsigned long get_wchan(struct task_struct *p);
>  
>  #if __LINUX_ARM_ARCH__ == 6 || defined(CONFIG_ARM_ERRATA_754327)
> -#define cpu_relax()			smp_mb()
> +#define cpu_relax()		do {					\
> +					asm("nop");			\
> +					asm("nop");			\
> +					asm("nop");			\
> +					asm("nop");			\
> +					asm("nop");			\

Can you use nop() instead of the explicit asm? Also, I think we should try
and use some methodology on deciding the number of nops to insert. Without
having a full handle on the problem at the moment, it would seem that we
need at least NR_CPUS worth (since the number of spinning secondaries is
NR_CPUS-1 and they may execute their barriers in lock-step).

Will
