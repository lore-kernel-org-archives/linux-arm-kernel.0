From: navam@xilinx.com (Nava kishore Manne)
Date: Mon, 10 Sep 2018 04:47:05 +0000
Subject: [RFC PATCH v3 1/3] firmware: xilinx: Add reset API's
In-Reply-To: <1536143389.4084.4.camel@pengutronix.de>
References: <1536131342-28041-1-git-send-email-nava.manne@xilinx.com>
 <1536131342-28041-2-git-send-email-nava.manne@xilinx.com>
 <1536143389.4084.4.camel@pengutronix.de>
Message-ID: <BYAPR02MB4710E2CACAA82D43B7FA0A81C2050@BYAPR02MB4710.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp

Thanks for the quick response...
Please find my response inline.

> -----Original Message-----
> From: Philipp Zabel [mailto:p.zabel at pengutronix.de]
> Sent: Wednesday, September 5, 2018 4:00 PM
> To: Nava kishore Manne <navam@xilinx.com>; robh+dt at kernel.org;
> mark.rutland at arm.com; Michal Simek <michals@xilinx.com>; Rajan Vaja
> <RAJANV@xilinx.com>; Jolly Shah <JOLLYS@xilinx.com>;
> devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-
> kernel at vger.kernel.org
> Subject: Re: [RFC PATCH v3 1/3] firmware: xilinx: Add reset API's
> 
> Hi,
> 
> On Wed, 2018-09-05 at 12:39 +0530, Nava kishore Manne wrote:
> > This Patch Adds reset API's to support release, assert and status
> > functionalities by using firmware interface.
> >
> > Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> > ---
> > Changes for v3:
> > 		-None.
> > Changes for v2:
> > 		-New Patch.
> >
> >  drivers/firmware/xilinx/zynqmp.c     |  40 +++++++++++
> >  include/linux/firmware/xlnx-zynqmp.h | 136
> > +++++++++++++++++++++++++++++++++++
> >  2 files changed, 176 insertions(+)
> >
> > diff --git a/drivers/firmware/xilinx/zynqmp.c
> > b/drivers/firmware/xilinx/zynqmp.c
> > index 7ccedf0..639c72f 100644
> > --- a/drivers/firmware/xilinx/zynqmp.c
> > +++ b/drivers/firmware/xilinx/zynqmp.c
> > @@ -447,6 +447,44 @@ static int zynqmp_pm_clock_getparent(u32
> clock_id, u32 *parent_id)
> >  	return ret;
> >  }
> >
> > +/**
> > + * zynqmp_pm_reset_assert - Request setting of reset (1 - assert, 0 - release)
> > + * @reset:		Reset to be configured
> > + * @assert_flag:	Flag stating should reset be asserted (1) or
> > + *			released (0)
> > + *
> > + * Return: Returns status, either success or error+reason  */ static
> > +int zynqmp_pm_reset_assert(const enum zynqmp_pm_reset reset,
> > +				  const enum zynqmp_pm_reset_action
> assert_flag) {
> > +	return zynqmp_pm_invoke_fn(PM_RESET_ASSERT, reset, assert_flag,
> > +				   0, 0, NULL);
> > +}
> > +
> > +/**
> > + * zynqmp_pm_reset_get_status - Get status of the reset
> > + * @reset:      Reset whose status should be returned
> > + * @status:     Returned status
> > + *
> > + * Return: Returns status, either success or error+reason  */ static
> > +int zynqmp_pm_reset_get_status(const enum zynqmp_pm_reset reset,
> > +				      u32 *status)
> > +{
> > +	u32 ret_payload[PAYLOAD_ARG_CNT];
> > +	int ret;
> > +
> > +	if (!status)
> > +		return -EINVAL;
> > +
> > +	ret = zynqmp_pm_invoke_fn(PM_RESET_GET_STATUS, reset, 0,
> > +				  0, 0, ret_payload);
> > +	*status = ret_payload[1];
> 
> It doesn't really matter here, but in general I'd skip writing output arguments in
> case of error.
> For all I know, the result returned in ret_payload could be undefined.
> 

Will fix in the next version.

Regards,
Navakishore.
