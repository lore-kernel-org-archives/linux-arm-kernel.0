From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 4 Feb 2014 16:45:09 -0800
Subject: [PATCH v2 3/5] arm: qcom: Split Qualcomm support into legacy
 and multiplatform
In-Reply-To: <1391553532-27001-4-git-send-email-galak@codeaurora.org>
References: <1391553532-27001-1-git-send-email-galak@codeaurora.org>
 <1391553532-27001-4-git-send-email-galak@codeaurora.org>
Message-ID: <20140205004509.GA12815@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/04, Kumar Gala wrote:
> Introduce a new mach-qcom that will support SoCs that intend to be
> multiplatform compatiable while keeping mach-msm to legacy SoC/board

s/compatiable/compatible/

> support that will not transition over to multiplatform.
> 
> As part of this, we move support for MSM8X60, MSM8960 and MSM8974 over
> to mach-qcom.
> 
> Signed-off-by: Kumar Gala <galak@codeaurora.org>

> diff --git a/arch/arm/mach-qcom/Kconfig b/arch/arm/mach-qcom/Kconfig
> new file mode 100644
> index 0000000..755b0db
> --- /dev/null
> +++ b/arch/arm/mach-qcom/Kconfig
> @@ -0,0 +1,33 @@
> +config ARCH_QCOM
> +	bool "Qualcomm Support" if ARCH_MULTI_V7
> +	select ARCH_REQUIRE_GPIOLIB
> +	select CLKSRC_OF
> +	select GENERIC_CLOCKEVENTS

I wonder why this isn't part of CONFIG_ARCH_MULTIPLATFORM.

> +	select ARM_GIC
> +	select HAVE_SMP
> +	select QCOM_SCM if SMP

Please sort this alphabetically.

> +	help
> +	  Support for Qualcomm's devicetree based systems.
> +
> +if ARCH_QCOM
> +
> diff --git a/arch/arm/mach-qcom/Makefile b/arch/arm/mach-qcom/Makefile
> new file mode 100644
> index 0000000..c0ba0ef
> --- /dev/null
> +++ b/arch/arm/mach-qcom/Makefile
> @@ -0,0 +1,5 @@
> +obj-y			:= board.o
> +obj-$(CONFIG_SMP)	+= smp.o

Everyone else on ARM calls it platsmp.c. Why differ?

> +obj-$(CONFIG_QCOM_SCM)	+= scm.o scm-boot.o
> +
> +CFLAGS_scm.o :=$(call as-instr,.arch_extension sec,-DREQUIRES_SEC=1)

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
