From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Thu, 23 Aug 2012 12:23:45 +0200
Subject: [PATCH] ARM: fix cpu_relax() in case of doing dmb
In-Reply-To: <1345647138-8815-1-git-send-email-shawn.guo@linaro.org>
References: <1345647138-8815-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <503604B1.7030207@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22.08.2012 16:52, Shawn Guo wrote:
> There is an issue reported on imx6q restart function.  The issue is only
> seen with the image building ARMv7 and ARMv6 together, where cpu_relax()
> is define to do dmb.  It's been root-caused by Russell as below.
> 
> Russell King - ARM Linux wrote:
>> I suspect having this dmb inside cpu_relax() is flooding the
>> interconnects with traffic, which then prevents other CPUs getting
>> a look-in (maybe there's no fairness when it comes to dmb's.
> 
> Fix the issue by insert a few NOPs into cpu_relax() where doing dmb.
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Tested on a i.MX6 SabreLite board together with the patch 'ARM: imx6q: 
remove imx_src_prepare_restart() call':

Tested-by: Dirk Behme <dirk.behme@de.bosch.com>

Thanks

Dirk

> ---
>  arch/arm/include/asm/processor.h |    9 ++++++++-
>  1 files changed, 8 insertions(+), 1 deletions(-)
> 
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
> +					smp_mb();			\
> +				} while (0)
>  #else
>  #define cpu_relax()			barrier()
>  #endif
