From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Fri, 23 Sep 2016 16:13:19 +0200
Subject: [PATCH v18 6/6] ARM: socfpga: fpga bridge driver support
In-Reply-To: <20160712193645.9098-7-atull@opensource.altera.com>
References: <20160712193645.9098-1-atull@opensource.altera.com>
 <20160712193645.9098-7-atull@opensource.altera.com>
Message-ID: <73ponug19k.fsf@unicorn.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi!

Alan Tull writes:

> Supports Altera SOCFPGA bridges:
>  * fpga2sdram
>  * fpga2hps
>  * hps2fpga
>  * lwhps2fpga
>
> Allows enabling/disabling the bridges through the FPGA
> Bridge Framework API functions.
>
> The fpga2sdram driver only supports enabling and disabling
> of the ports that been configured early on.  This is due to
> a hardware limitation where the read, write, and command
> ports on the fpga2sdram bridge can only be reconfigured
> while there are no transactions to the sdram, i.e. when
> running out of OCRAM before the kernel boots.
>
> Device tree property 'init-val' configures the driver to
> enable or disable the bridge during probe.  If the property
> does not exist, the driver will leave the bridge in its
> current state.
>
> Signed-off-by: Alan Tull <atull@opensource.altera.com>
> Signed-off-by: Matthew Gerlach <mgerlach@altera.com>
> Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>

(...)

> +static inline int _alt_fpga2sdram_enable_set(struct alt_fpga2sdram_data *priv,
> +					     bool enable)
> +{
> +	return regmap_update_bits(priv->sdrctl, ALT_SDR_CTL_FPGAPORTRST_OFST,
> +				  priv->mask, enable ? priv->mask : 0);
> +}

(...)

> +	/* Get f2s bridge configuration saved in handoff register */
> +	regmap_read(sysmgr, SYSMGR_ISWGRP_HANDOFF3, &priv->mask);
> +

Could you maybe add some documentation about this implicit information
shared between a bootloader and this driver?
I understand why you do this, but there must be a better way than
depending on something some bootloader wrote in some undocumented
register, no?
The documentation just says:

"These registers are used to store handoff infomation between the
preloader and the OS. These 8 registers can be used to store any
information. The contents of these registers have no impact on the
state of the HPS hardware"

If it is already agreed upon, that a bridge-enable property is okay,
why not add a port-enable property, too?

Regards,
Steffen Trumtrar

-- 
Pengutronix e.K.                           | Steffen Trumtrar            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
