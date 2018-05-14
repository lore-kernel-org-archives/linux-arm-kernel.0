From: JOLLYS@xilinx.com (Jolly Shah)
Date: Mon, 14 May 2018 19:11:56 +0000
Subject: [PATCH v6 03/11] firmware: xilinx: Add zynqmp IOCTL API for
 device control
In-Reply-To: <c351b9a3-5f26-7202-7171-0dcc7adef7c0@arm.com>
References: <1523389127-14243-1-git-send-email-jollys@xilinx.com>
 <1523389127-14243-4-git-send-email-jollys@xilinx.com>
 <c351b9a3-5f26-7202-7171-0dcc7adef7c0@arm.com>
Message-ID: <SN1PR02MB3758F635BA420721B0EB8A2FB89C0@SN1PR02MB3758.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sudeep,

> -----Original Message-----
> From: Sudeep Holla [mailto:sudeep.holla at arm.com]
> Sent: Thursday, May 10, 2018 7:09 AM
> To: Jolly Shah <JOLLYS@xilinx.com>; ard.biesheuvel at linaro.org;
> mingo at kernel.org; gregkh at linuxfoundation.org; matt at codeblueprint.co.uk;
> hkallweit1 at gmail.com; keescook at chromium.org;
> dmitry.torokhov at gmail.com; mturquette at baylibre.com;
> sboyd at codeaurora.org; michal.simek at xilinx.com; robh+dt at kernel.org;
> mark.rutland at arm.com; linux-clk at vger.kernel.org
> Cc: Sudeep Holla <sudeep.holla@arm.com>; Rajan Vaja <RAJANV@xilinx.com>;
> linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org;
> devicetree at vger.kernel.org; Jolly Shah <JOLLYS@xilinx.com>
> Subject: Re: [PATCH v6 03/11] firmware: xilinx: Add zynqmp IOCTL API for device
> control
> 
> 
> 
> On 10/04/18 20:38, Jolly Shah wrote:
> > From: Rajan Vaja <rajanv@xilinx.com>
> >
> > Add ZynqMP firmware IOCTL API to control and configure devices like
> > PLLs, SD, Gem, etc.
> >
> > Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
> > Signed-off-by: Jolly Shah <jollys@xilinx.com>
> > ---
> >  drivers/firmware/xilinx/zynqmp.c     | 20 ++++++++++++++++++++
> >  include/linux/firmware/xlnx-zynqmp.h |  2 ++
> >  2 files changed, 22 insertions(+)
> >
> > diff --git a/drivers/firmware/xilinx/zynqmp.c
> > b/drivers/firmware/xilinx/zynqmp.c
> > index 490561a..44b43fa 100644
> > --- a/drivers/firmware/xilinx/zynqmp.c
> > +++ b/drivers/firmware/xilinx/zynqmp.c
> > @@ -239,8 +239,28 @@ static int get_set_conduit_method(struct
> device_node *np)
> >  	return 0;
> >  }
> >
> > +/**
> > + * zynqmp_pm_ioctl() - PM IOCTL API for device control and configs
> > + * @node_id:	Node ID of the device
> > + * @ioctl_id:	ID of the requested IOCTL
> > + * @arg1:	Argument 1 to requested IOCTL call
> > + * @arg2:	Argument 2 to requested IOCTL call
> > + * @out:	Returned output value
> > + *
> > + * This function calls IOCTL to firmware for device control and configuration.
> > + *
> > + * Return: Returns status, either success or error+reason  */ static
> > +int zynqmp_pm_ioctl(u32 node_id, u32 ioctl_id, u32 arg1, u32 arg2,
> > +			   u32 *out)
> > +{
> > +	return zynqmp_pm_invoke_fn(PM_IOCTL, node_id, ioctl_id,
> > +				   arg1, arg2, out);
> > +}
> > +
> >  static const struct zynqmp_eemi_ops eemi_ops = {
> >  	.get_api_version = zynqmp_pm_get_api_version,
> > +	.ioctl = zynqmp_pm_ioctl,
> >  };
> >
> >  /**
> > diff --git a/include/linux/firmware/xlnx-zynqmp.h
> > b/include/linux/firmware/xlnx-zynqmp.h
> > index cb63bed..2eec6e7 100644
> > --- a/include/linux/firmware/xlnx-zynqmp.h
> > +++ b/include/linux/firmware/xlnx-zynqmp.h
> > @@ -34,6 +34,7 @@
> >
> >  enum pm_api_id {
> >  	PM_GET_API_VERSION = 1,
> > +	PM_IOCTL = 34,
> 
> I am not for this API. IIUC there are more fined grained well defined APIs(if I am
> not wrong from enum 2 upto 33). This is open ended API which allows user to do
> whatever setting it needs. And that defeats the purpose of other APIs.
> 
> I will look through the series for the usage of this to understand this better, but I
> am guessing how it can be (ab)used.
> 
> --
> Regards,
> Sudeep

There are well defined APIs for general clock controls. Ioctl is for some specific operations which may not apply to all platforms.
For clock driver, ioctl is used to get/set Pll fraction/integer mode and data. 

Thanks,
Jolly Shah
