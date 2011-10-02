From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 2 Oct 2011 21:47:30 +0100
Subject: [PATCH 5/6] ASoC: samsung: fix Kconfig dependencies
In-Reply-To: <1317587284-2776-6-git-send-email-arnd@arndb.de>
References: <1317587284-2776-1-git-send-email-arnd@arndb.de>
	<1317587284-2776-6-git-send-email-arnd@arndb.de>
Message-ID: <20111002204729.GC5811@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 02, 2011 at 10:28:03PM +0200, Arnd Bergmann wrote:

>  config SND_SAMSUNG_AC97
>  	tristate
> +	depends on SND_SOC_ALL_CODECS=n || SND_SOC_ALL_CODECS
>  	select SND_SOC_AC97_BUS

No, I'm not sure what the problem you're trying to fix here but this
looks pretty terrible.  SND_SOC_ALL_CODECS is a debugging tool for build
coverage, we shouldn't be restricting actual useful drivers based on it.
What is the intention of this change and why does it only apply to the
Samsung platform?  It all looks very magic.

>  config SND_SOC_SAMSUNG_SMDK_WM8994
>  	tristate "SoC I2S Audio support for WM8994 on SMDK"
>  	depends on SND_SOC_SAMSUNG && (MACH_SMDKV310 || MACH_SMDKC210)
> +	depends on MFD_WM8994
>  	select SND_SOC_WM8994

This is non-idiomatic - we always select the CODEC drivers rather than
depending on them for usability.

Please also split the two changes you're doing here into separate
patches.  I might've applied the wm8994 bit but it's squashed in with
the AC'97 change...
