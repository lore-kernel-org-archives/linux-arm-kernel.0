From: JOLLYS@xilinx.com (Jolly Shah)
Date: Mon, 14 May 2018 19:18:44 +0000
Subject: [PATCH v6 09/11] firmware: xilinx: Add debugfs for clock control
 APIs
In-Reply-To: <5bcc47f7-3352-f0e6-29c5-78d5be96c1d1@arm.com>
References: <1523389127-14243-1-git-send-email-jollys@xilinx.com>
 <1523389127-14243-10-git-send-email-jollys@xilinx.com>
 <5bcc47f7-3352-f0e6-29c5-78d5be96c1d1@arm.com>
Message-ID: <SN1PR02MB3758191654612CFC261A38BEB89C0@SN1PR02MB3758.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sudeep,

> -----Original Message-----
> From: Sudeep Holla [mailto:sudeep.holla at arm.com]
> Sent: Thursday, May 10, 2018 7:31 AM
> To: Jolly Shah <JOLLYS@xilinx.com>; ard.biesheuvel at linaro.org;
> mingo at kernel.org; gregkh at linuxfoundation.org; matt at codeblueprint.co.uk;
> hkallweit1 at gmail.com; keescook at chromium.org;
> dmitry.torokhov at gmail.com; mturquette at baylibre.com;
> sboyd at codeaurora.org; michal.simek at xilinx.com; robh+dt at kernel.org;
> mark.rutland at arm.com; linux-clk at vger.kernel.org
> Cc: Sudeep Holla <sudeep.holla@arm.com>; Rajan Vaja <RAJANV@xilinx.com>;
> linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org;
> devicetree at vger.kernel.org; Jolly Shah <JOLLYS@xilinx.com>
> Subject: Re: [PATCH v6 09/11] firmware: xilinx: Add debugfs for clock control
> APIs
> 
> 
> 
> On 10/04/18 20:38, Jolly Shah wrote:
> > From: Rajan Vaja <rajanv@xilinx.com>
> >
> > Add debugfs file to control clocks using firmware APIs through debugfs
> > interface.
> >
> > Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
> > Signed-off-by: Jolly Shah <jollys@xilinx.com>
> > ---
> >  drivers/firmware/xilinx/zynqmp-debug.c | 48
> > ++++++++++++++++++++++++++++++++++
> >  1 file changed, 48 insertions(+)
> >
> > diff --git a/drivers/firmware/xilinx/zynqmp-debug.c
> > b/drivers/firmware/xilinx/zynqmp-debug.c
> > index 1cb69f7..837fcd1 100644
> > --- a/drivers/firmware/xilinx/zynqmp-debug.c
> > +++ b/drivers/firmware/xilinx/zynqmp-debug.c
> > @@ -34,6 +34,15 @@ static struct pm_api_info pm_api_list[] = {
> >  	PM_API(PM_GET_API_VERSION),
> >  	PM_API(PM_IOCTL),
> >  	PM_API(PM_QUERY_DATA),
> > +	PM_API(PM_CLOCK_ENABLE),
> > +	PM_API(PM_CLOCK_DISABLE),
> > +	PM_API(PM_CLOCK_GETSTATE),
> > +	PM_API(PM_CLOCK_SETDIVIDER),
> > +	PM_API(PM_CLOCK_GETDIVIDER),
> > +	PM_API(PM_CLOCK_SETRATE),
> > +	PM_API(PM_CLOCK_GETRATE),
> > +	PM_API(PM_CLOCK_SETPARENT),
> > +	PM_API(PM_CLOCK_GETPARENT),
> >  };
> >
> >  /**
> > @@ -87,6 +96,7 @@ static int process_api_request(u32 pm_id, u64
> *pm_api_arg, u32 *pm_api_ret)
> >  	const struct zynqmp_eemi_ops *eemi_ops =
> zynqmp_pm_get_eemi_ops();
> >  	u32 pm_api_version;
> >  	int ret;
> > +	u64 rate;
> >
> >  	if (!eemi_ops)
> >  		return -ENXIO;
> > @@ -132,6 +142,44 @@ static int process_api_request(u32 pm_id, u64
> *pm_api_arg, u32 *pm_api_ret)
> >  				pm_api_ret[2], pm_api_ret[3]);
> >  		break;
> >  	}
> > +	case PM_CLOCK_ENABLE:
> > +		ret = eemi_ops->clock_enable(pm_api_arg[0]);
> > +		break;
> 
> As I mentioned in earlier patch, I don't see the need for this debugfs interface.
> Clock lay has read-only interface in debugfs already. Also if you want to debug
> clocks, you can do so using the driver which uses these clocks. Do you really
> want to manage clocks in user-space ?
> The whole idea of EEMI kind of interface is to abstract and hide the fine details
> even from non-trusted rich OS like Linux kernel, but by providing this you are
> doing exactly opposite.
> 
> --
> Regards,
> Sudeep

No we don't want to manage clocks in user-space. This debugfs is meant for developer who wants to debug APIs behavior in case something doesn't work as expected. Debugfs should be off by default in production images.

Thanks,
Jolly Shah
