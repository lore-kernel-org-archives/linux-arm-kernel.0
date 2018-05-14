From: JOLLYS@xilinx.com (Jolly Shah)
Date: Mon, 14 May 2018 19:06:19 +0000
Subject: [PATCH v6 02/11] firmware: xilinx: Add Zynqmp firmware driver
In-Reply-To: <9cbfb3cd-daa3-f145-c6f2-f15f61d1bea0@arm.com>
References: <1523389127-14243-1-git-send-email-jollys@xilinx.com>
 <1523389127-14243-3-git-send-email-jollys@xilinx.com>
 <9cbfb3cd-daa3-f145-c6f2-f15f61d1bea0@arm.com>
Message-ID: <SN1PR02MB37580153B7BD4C229AA0AAEFB89C0@SN1PR02MB3758.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sudeep,

> -----Original Message-----
> From: Sudeep Holla [mailto:sudeep.holla at arm.com]
> Sent: Thursday, May 10, 2018 7:05 AM
> To: Jolly Shah <JOLLYS@xilinx.com>; ard.biesheuvel at linaro.org;
> mingo at kernel.org; gregkh at linuxfoundation.org; matt at codeblueprint.co.uk;
> hkallweit1 at gmail.com; keescook at chromium.org;
> dmitry.torokhov at gmail.com; mturquette at baylibre.com;
> sboyd at codeaurora.org; michal.simek at xilinx.com; robh+dt at kernel.org;
> mark.rutland at arm.com; linux-clk at vger.kernel.org
> Cc: Sudeep Holla <sudeep.holla@arm.com>; Rajan Vaja <RAJANV@xilinx.com>;
> linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org;
> devicetree at vger.kernel.org; Jolly Shah <JOLLYS@xilinx.com>
> Subject: Re: [PATCH v6 02/11] firmware: xilinx: Add Zynqmp firmware driver
> 
> 
> 
> On 10/04/18 20:38, Jolly Shah wrote:
> > From: Rajan Vaja <rajanv@xilinx.com>
> >
> > This patch is adding communication layer with firmware.
> > Firmware driver provides an interface to firmware APIs.
> > Interface APIs can be used by any driver to communicate to
> > PMUFW(Platform Management Unit). All requests go through ATF.
> >
> > Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
> > Signed-off-by: Jolly Shah <jollys@xilinx.com>
> > ---
> 
> [...]
> 
> > +
> > +/**
> > + * get_set_conduit_method() - Choose SMC or HVC based communication
> > + * @np:		Pointer to the device_node structure
> > + *
> > + * Use SMC or HVC-based functions to communicate with EL2/EL3.
> > + *
> > + * Return: Returns 0 on success or error code  */ static int
> > +get_set_conduit_method(struct device_node *np) {
> > +	const char *method;
> > +
> > +	if (of_property_read_string(np, "method", &method)) {
> > +		pr_warn("%s missing \"method\" property\n", __func__);
> > +		return -ENXIO;
> > +	}
> > +
> > +	if (!strcmp("hvc", method)) {
> > +		do_fw_call = do_fw_call_hvc;
> > +	} else if (!strcmp("smc", method)) {
> > +		do_fw_call = do_fw_call_smc;
> > +	} else {
> > +		pr_warn("%s Invalid \"method\" property: %s\n",
> > +			__func__, method);
> > +		return -EINVAL;
> > +	}
> > +
> 
> Mark R did some cleanup around SMCCC conduits[1]. It makes sense to base this
> on top that. But if you manage to push this for v4.18, then you may need to wait
> for that to be merged and clean it up after v4.18
> 
> --
> Regards,
> Sudeep

Mark R did change for SMCCC enums and we are not using any SMCCC enums so we don't have any dependency on that.

Thanks,
Jolly Shah

> 
> [1] https://www.spinics.net/lists/arm-kernel/msg650305.html
