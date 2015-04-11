From: pebolle@tiscali.nl (Paul Bolle)
Date: Sat, 11 Apr 2015 12:17:57 +0200
Subject: [PATCH v3 3/5] PCI: st: Provide support for the sti PCIe
 controller
In-Reply-To: <1428657168-12495-4-git-send-email-gabriel.fernandez@linaro.org>
References: <1428657168-12495-1-git-send-email-gabriel.fernandez@linaro.org>
 <1428657168-12495-4-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <1428747477.17822.90.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Something I didn't spot in my first look at this patch.

On Fri, 2015-04-10 at 11:12 +0200, Gabriel FERNANDEZ wrote:
> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig
>  
> +config PCI_ST
> +	bool "ST PCIe controller"
> +	depends on ARCH_STI || (ARM && COMPILE_TEST)
> +	select PCIE_DW
> +	help
> +	  Enable PCIe controller support on ST Socs. This controller is based
> +	  on Designware hardware and therefore the driver re-uses the
> +	  Designware core functions to implement the driver.

You can't have ARCH_STI without ARM, so ARM will always be set if this
driver is enabled. Correct?

> --- /dev/null
> +++ b/drivers/pci/host/pci-st.c

> +	if (IS_ENABLED(CONFIG_ARM)) {
> +		/*
> +		 * We have to hook the abort handler so that we can intercept
> +		 * bus errors when doing config read/write that return UR,
> +		 * which is flagged up as a bus error
> +		 */
> +		hook_fault_code(16+6, st_pcie_abort_handler, SIGBUS, 0,
> +				"imprecise external abort");
> +	}

So, unless I'm missing something obvious here, IS_ENABLED(CONFIG_ARM)
will always evaluate to 1. Can't that test be dropped?


Paul Bolle
