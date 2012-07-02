From: kim.phillips@freescale.com (Kim Phillips)
Date: Mon, 2 Jul 2012 18:37:36 -0500
Subject: [PATCH] rtc: snvs: add Freescale rtc-snvs driver
In-Reply-To: <1341245355-21397-1-git-send-email-shawn.guo@linaro.org>
References: <1341245355-21397-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120702183736.e8e4136d4bf206b55c8653a5@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 3 Jul 2012 00:09:15 +0800
Shawn Guo <shawn.guo@linaro.org> wrote:

>  create mode 100644 Documentation/devicetree/bindings/rtc/snvs-rtc.txt
>  create mode 100644 drivers/rtc/rtc-snvs.c
> 
> diff --git a/Documentation/devicetree/bindings/rtc/snvs-rtc.txt b/Documentation/devicetree/bindings/rtc/snvs-rtc.txt
> new file mode 100644
> index 0000000..18e7c5c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/snvs-rtc.txt
> @@ -0,0 +1,19 @@
> +* Freescale Secure Non-Volatile Storage (SNVS) RTC
> +
> +Required properties:
> +- compatible: Should be "fsl,sec-v4.0-mon"
> +  See Documentation/devicetree/bindings/crypto/fsl-sec4.txt for details.
> +- reg: Physical base address of the controller and length of memory mapped
> +  region.
> +- interrupts: Two interrupt numbers to the cpu should be specified. First
> +  interrupt number is the consolidated interrupt in non TrustZone. The second
> +  interrupt number is the security interrupt in TrustZone. The number of cells
> +  representing a interrupt depends on the parent interrupt controller.
> +
> +Example:
> +
> +snvs at 020cc000 {
> +	compatible = "fsl,sec-v4.0-mon";
> +	reg = <0x020cc000 0x4000>;
> +	interrupts = <0 19 0x04 0 20 0x04>;
> +};

Instead of duplicating the binding documentation entry, can this be
merged in with crypto/fsl-sec4.txt?  Also, don't we need the rtc to
be a 'sub-device' of "fsl,sec-vX.Y-mon", and to have its own
compatible, e.g., "fsl,sec-v4.0-mon-rtc-lp"?

> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index 08cbdb9..511ddcb 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -1087,4 +1087,14 @@ config RTC_DRV_MXC
>  	   This driver can also be built as a module, if so, the module
>  	   will be called "rtc-mxc".
>  
> +config RTC_DRV_SNVS
> +	tristate "Freescale SNVS RTC support"
> +	depends on ARCH_MXC

should also depend on || FSL_SOC - it was mentioned in the
review of the last version of this patch that this h/w exists on
other, non-ARM based, SoCs.

Kim
