From: computersforpeace@gmail.com (Brian Norris)
Date: Thu, 21 Aug 2014 22:09:07 -0700
Subject: [PATCH] ARM: bcm: Don't build brcmstb SMP code when building for
 V6
In-Reply-To: <1408673194-16228-1-git-send-email-broonie@kernel.org>
References: <1408673194-16228-1-git-send-email-broonie@kernel.org>
Message-ID: <20140822050907.GC3246@norris-Latitude-E6410>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ Russell

On Thu, Aug 21, 2014 at 09:06:34PM -0500, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
> 
> The brcmstb SMP code contains isb() and dsb() which are not supported when

The problem is not with isb() and dsb() (which have different
definitions when v6 is enabled), but with v7_exit_coherency_flush().

> building for -march=armv6 as happens when building allmodconfig. Since I
> have not been able to identify a way to override the compiler architecture
> selection per file add a Kconfig dependency to ensure this code is not
> built if V6 support is enabled.

I already proposed this solution to override the compiler architecture,
in the same pattern as other similar code in the same directory.

  http://article.gmane.org/gmane.linux.drivers.devicetree/84517

My using 'CFLAGS_<obj> += <flags>', you can compile in v7.

> There is doubtless a better solution.

I think mine is better? Not sure. Comments are welcome.

But anyway, this file *should* be dropped for 3.17 (resolving the
current problem at hand), if somebody will eventually pick up this
patch:

  http://article.gmane.org/gmane.linux.kernel/1767679

Hello, anybody? Should Matt be picking this up, or for post-rc1, do
Arnd/Olof take these patches directly?

> Signed-off-by: Mark Brown <broonie@linaro.org>
> ---
>  arch/arm/mach-bcm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
> index fc93800..372132d 100644
> --- a/arch/arm/mach-bcm/Kconfig
> +++ b/arch/arm/mach-bcm/Kconfig
> @@ -102,6 +102,7 @@ config ARCH_BCM_5301X
>  config ARCH_BRCMSTB
>  	bool "Broadcom BCM7XXX based boards" if ARCH_MULTI_V7
>  	depends on MMU
> +	depends on !CPU_V6
>  	select ARM_GIC
>  	select MIGHT_HAVE_PCI
>  	select HAVE_SMP

Regards,
Brian
