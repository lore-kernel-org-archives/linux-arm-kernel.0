From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 2 Oct 2011 17:03:28 +0100
Subject: [PATCH 16/26] ARM: pxa: CPU_PJ4 requires IWMMXT
In-Reply-To: <1317499438-14058-17-git-send-email-arnd@arndb.de>
References: <1317499438-14058-1-git-send-email-arnd@arndb.de>
	<1317499438-14058-17-git-send-email-arnd@arndb.de>
Message-ID: <20111002160328.GZ11710@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 01, 2011 at 10:03:48PM +0200, Arnd Bergmann wrote:
> The PJ4 based pxa95x cpus all have iwmmxt and there is no way to
> build that code conditionally, so better not ask the user
> in that configuration, in order to prevent broken builds.

This suggests we want IWMMXT=y if PJ4=y...

>  config IWMMXT
> -	bool "Enable iWMMXt support"
> +	bool "Enable iWMMXt support" if !CPU_PJ4
>  	depends on CPU_XSCALE || CPU_XSC3 || CPU_MOHAWK || CPU_PJ4
>  	default y if PXA27x || PXA3xx || PXA95x || ARCH_MMP
>  	help

This hides the option if CPU_PJ4 is enabled, but it will only be set
to 'y' if PXA27x || PXA3xx || PXA95x || ARCH_MMP are set.  Luckily,
ARCH_MMP will be - but is that really what's intended?  It's a little
obscure to work that out.
