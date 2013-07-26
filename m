From: csd@broadcom.com (Christian Daudt)
Date: Fri, 26 Jul 2013 10:17:33 -0700
Subject: [PATCH v2 1/5] ARM: Broadcom: Unconditionally build
 arch/arm/mach-bcm
In-Reply-To: <20130726171153.GN29916@titan.lakedaemon.net>
References: <20130726145639.116237136@gmail.com>
 <20130726151223.045835540@gmail.com>
 <20130726152918.GL29916@titan.lakedaemon.net>
 <51F29BFE.8000202@broadcom.com>
 <20130726171153.GN29916@titan.lakedaemon.net>
Message-ID: <51F2AF2D.1000300@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13-07-26 10:11 AM, Jason Cooper wrote:
> Christian,
>
> On Fri, Jul 26, 2013 at 08:55:42AM -0700, Christian Daudt wrote:
>> [resend in plain text]
>> On 13-07-26 08:29 AM, Jason Cooper wrote:
>>> On Fri, Jul 26, 2013 at 04:56:40PM +0200, Domenico Andreoli wrote:
>>>> From: Domenico Andreoli<domenico.andreoli@linux.com>
>>>>
>>>> arch/arm/mach-bcm contains a plurality of Broadcom SoCs, each configured
>>>> separately. As a matter of flexibility and maintenance, it needs to be
>>>> always included in the build.
>>> So if I'm building mach-kirkwood, I _have_ to build Broadcom?  What is
>>> the *specific* problem you're encountering that this solves?
>>   No it won't, as the Makefile inside mach-bcm will only pull in
>> files based on ARCH_ settings. This move is so that a number
>> different Broadcom SoCs can co-exist inside the mach-bcm directory.
>
> Why wouldn't this work?
>
> ---->8-------
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index ba412e0..97b6aff 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -366,6 +366,12 @@ config ARCH_AT91
>   	  This enables support for systems based on Atmel
>   	  AT91RM9200 and AT91SAM9* processors.
>   
> +config ARCH_BCM
> +	bool "Broadcom family SoCs"
> +	help
> +	  This enables support for systems based on the Broadcom
> +	  bcm4760 and bcm281XX series SoCs.
> +
>   config ARCH_CLPS711X
>   	bool "Cirrus Logic CLPS711x/EP721x/EP731x-based"
>   	select ARCH_REQUIRE_GPIOLIB
> diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
> index f112895..4b1f9db 100644
> --- a/arch/arm/mach-bcm/Kconfig
> +++ b/arch/arm/mach-bcm/Kconfig
> @@ -1,5 +1,9 @@
> -config ARCH_BCM
> -	bool "Broadcom SoC" if ARCH_MULTI_V7
> +if ARCH_BCM
> +
> +menu "Broadcom SoC Implementations"
> +
> +config MACH_BCM281XX
> +	bool "BCM281XX SoCs" if ARCH_MULTI_V7
>   	depends on MMU
>   	select ARCH_REQUIRE_GPIOLIB
>   	select ARM_ERRATA_754322
> @@ -17,3 +21,7 @@ config ARCH_BCM
>   	  It currently supports the 'BCM281XX' family, which includes
>   	  BCM11130, BCM11140, BCM11351, BCM28145 and
>   	  BCM28155 variants.
> +
> +endmenu
> +
> +endif
> diff --git a/arch/arm/mach-bcm/Makefile b/arch/arm/mach-bcm/Makefile
> index 6adb6aec..e3f8f27 100644
> --- a/arch/arm/mach-bcm/Makefile
> +++ b/arch/arm/mach-bcm/Makefile
> @@ -10,6 +10,6 @@
>   # of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>   # GNU General Public License for more details.
>   
> -obj-$(CONFIG_ARCH_BCM)		:= board_bcm.o bcm_kona_smc.o bcm_kona_smc_asm.o
> +obj-$(CONFIG_MACH_BCM281XX)	:= board_bcm.o bcm_kona_smc.o bcm_kona_smc_asm.o
>   plus_sec := $(call as-instr,.arch_extension sec,+sec)
>   AFLAGS_bcm_kona_smc_asm.o	:=-Wa,-march=armv7-a$(plus_sec)
>
Because ARCH_BCM is meant to be used for a number of SoC families. We've 
started upstreaming one (the BCM281XX) but have 2 more internally that 
we're working towards upstreaming. And in the future our plan is to keep 
the Broadcom Mobile SoCs all building under this single ARCH_BCM 
configuration as multiplatform code building a single zImage for them.
The intent of mach-bcm on the other hand is to aggregate future SoC 
chips beyond ARCH_BCM (which is mobile SoC focused) to include other 
Broadcom ARM based SoCs. And there are 2 in the wings at the moment 
making their way into mainline as patches. The idea here being that with 
the new multiplatform code, the mach- dirs contain so little code that 
it makes sense to aggregate a bunch of SoCs from the same company in 
there (and we are the guinea pig on this one).

  Thanks,
    csd
