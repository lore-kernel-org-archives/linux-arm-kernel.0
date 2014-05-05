From: tony@atomide.com (Tony Lindgren)
Date: Mon, 5 May 2014 15:01:55 -0700
Subject: [RFC] [v2 Patch 2/6] ARM: TI: Describe the ti reset DT entries
In-Reply-To: <1399320567-3639-3-git-send-email-dmurphy@ti.com>
References: <1399320567-3639-1-git-send-email-dmurphy@ti.com>
 <1399320567-3639-3-git-send-email-dmurphy@ti.com>
Message-ID: <20140505220155.GI25949@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Dan Murphy <dmurphy@ti.com> [140505 13:10]:
> +
> +Required parent properties:
> +- compatible : Should be one of,
> +		"ti,omap4-prm" for OMAP4 PRM instances
> +		"ti,omap5-prm" for OMAP5 PRM instances
> +		"ti,dra7-prm" for DRA7xx PRM instances
> +		"ti,am4-prcm" for AM43xx PRCM instances
> +		"ti,am3-prcm" for AM33xx PRCM instances
> +
> +Required child reset property:
> +- compatible : Should be
> +		"resets" for All TI SoCs
> +
> +example:
> +		prm: prm at 4ae06000 {
> +			compatible = "ti,omap5-prm";
> +			reg = <0x4ae06000 0x3000>;
> +
> +			prm_resets: resets {
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				#reset-cells = <1>;
> +			};
> +		};

The reg entries you have in the example below has different format
compared to this?

> +Reset node declaration
> +==============================================
> +The reset node is declared in a parent child relationship.  The main parent
> +is the PRCM module which contains the base address.  The first child within
> +the reset parent declares the target modules reset name.  This is followed by
> +the control and status offsets.
> +
> +Within the first reset child node is a secondary child node which declares the
> +reset signal of interest.  Under this node the control and status bits
> +are declared.  These bits declare the bit mask for the target reset.
> +
> +
> +Required properties:
> +reg - This is the register offset from the PRCM parent.
> +	This must be declared as:
> +
> +	reg = <control register offset>,
> +		  <status register offset>;
> +
> +control-bit - This is the bit within the register which controls the reset
> +	of the target module.  This is declared as a bit mask for the register.
> +status-bit - This is the bit within the register which contains the status of
> +	the reset of the target module.
> +	This is declared as a bit mask for the register.
> +
> +example:
> +&prm_resets {
> +	dsp_rstctrl {
> +		reg = <0x1c00>,
> +			  <0x1c04>;

Shouldn't this be start and size instead of start and end here?

> +		dsp_reset: dsp_reset {
> +			control-bit = <0x01>;
> +			status-bit = <0x01>;
> +		};
> +	};
> +};

Are the control-bit and status-bit always the same? If so, you can
keep that knowlede private to the the driver.

And maybe you can have the bit offset in a reg property here to
avoid adding any custom properties? Something like:

	dsp_reset: reset at 1 {
		reg = 1;
	};

If reg is not suitable for that, it seems that some generic property
to describe the bit offset is needed by quite a few drivers
anyways, for things like clocks and regulators. 

> +Client Node Declaration
> +==============================================
> +This is the consumer of the parent node to declare what resets this
> +particular module is interested in.
> +
> +example:
> +	src: src at 55082000 {
> +		    resets = <&reset_src phandle>;
> +			reset-names = "<reset_name>";
> +	};
> +
> +Required Properties:
> +reset_src - This is the parent DT entry for the reset controller
> +phandle - This is the phandle of the specific reset to be used by the clien
> +	driver.
> +reset-names - This is the reset name of module that the device driver
> +	needs to be able to reset.  This value must correspond to a value within
> +	the reset controller array.
> +
> +example:
> +resets = <&prm_resets &dsp_mmu_reset>;
> +reset-names = "dsp_mmu_reset";

This part looks OK to me, not sure if we need the reset-names property
if we have one already why not.

Regards,

Tony
