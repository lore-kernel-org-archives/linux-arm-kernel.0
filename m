From: will.deacon@arm.com (Will Deacon)
Date: Tue, 22 Apr 2014 10:46:59 +0100
Subject: [PATCH] ARM64: disable DCACHE_WORD_ACCESS in big endian case
In-Reply-To: <1398119770-27817-1-git-send-email-victor.kamensky@linaro.org>
References: <1398119770-27817-1-git-send-email-victor.kamensky@linaro.org>
Message-ID: <20140422094659.GB6979@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 21, 2014 at 11:36:10PM +0100, Victor Kamensky wrote:
> If DCACHE_WORD_ACCESS is enabled big endian image failed to
> boot. commit 7bc13fd33adb9536bd73965cd46bbf7377df097c
> "arm64: dcache: select DCACHE_WORD_ACCESS for little-endian CPUs"
> enabled this setting for both big endian and little endian
> cpus. And code in commit itself seems to be endian agnostic,
> however other, i.e C, code that sits under DCACHE_WORD_ACCESS
> seems to be not endian agnostic, I could not figure out where
> though.
> 
> Solution is to enable DCACHE_WORD_ACCESS only if little
> endian mode is enabled (default).
> 
> Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>

NAK, this really should work for big-endian machines. If it doesn't, we
should figure out why and fix the problem.

As a start, can you share further details of the failure please?

Will

> ---
>  arch/arm64/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index e6e4d37..106ac4f 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -13,7 +13,7 @@ config ARM64
>  	select CLONE_BACKWARDS
>  	select COMMON_CLK
>  	select CPU_PM if (SUSPEND || CPU_IDLE)
> -	select DCACHE_WORD_ACCESS
> +	select DCACHE_WORD_ACCESS if !CPU_BIG_ENDIAN
>  	select GENERIC_CLOCKEVENTS
>  	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
>  	select GENERIC_CPU_AUTOPROBE
> -- 
> 1.8.1.4
> 
> 
