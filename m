From: JOLLYS@xilinx.com (Jolly Shah)
Date: Wed, 31 Jan 2018 19:46:20 +0000
Subject: [PATCH v3 2/4] drivers: firmware: xilinx: Add ZynqMP firmware
 driver
In-Reply-To: <CAKfKVtGGf8AexOTEvyyi7cmQ_Xopa3Fszf-jOuNSfBJpE2EzCg@mail.gmail.com>
References: <1516836074-4149-1-git-send-email-jollys@xilinx.com>
 <1516836074-4149-3-git-send-email-jollys@xilinx.com>
 <CAKfKVtGGf8AexOTEvyyi7cmQ_Xopa3Fszf-jOuNSfBJpE2EzCg@mail.gmail.com>
Message-ID: <DM2PR0201MB07676D107FA004D43F1FC49AB8FB0@DM2PR0201MB0767.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shubhrajyoti,
Thanks for the review,

> -----Original Message-----
> From: Shubhrajyoti Datta [mailto:shubhrajyoti.datta at gmail.com]
> Sent: Monday, January 29, 2018 9:06 PM
> To: Jolly Shah <JOLLYS@xilinx.com>
> Cc: ard.biesheuvel at linaro.org; mingo at kernel.org; Greg Kroah-Hartman
> <gregkh@linuxfoundation.org>; matt at codeblueprint.co.uk;
> sudeep.holla at arm.com; hkallweit1 at gmail.com; keescook at chromium.org;
> dmitry.torokhov at gmail.com; Michal Simek <michal.simek@xilinx.com>; Rob
> Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>; linux-
> arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org;
> devicetree at vger.kernel.org; Jolly Shah <JOLLYS@xilinx.com>; Rajan Vaja
> <RAJANV@xilinx.com>
> Subject: Re: [PATCH v3 2/4] drivers: firmware: xilinx: Add ZynqMP firmware
> driver
> 
> Hi,
> 
> Thanks for the patch.
> A few questions below.
> 
> 
> On Thu, Jan 25, 2018 at 4:51 AM, Jolly Shah <jolly.shah@xilinx.com> wrote:
> > This patch is adding communication layer with firmware.
> > Firmware driver provides an interface to firmware APIs.
> > Interface APIs can be used by any driver to communicate to
> > PMUFW(Platform Management Unit). All requests go through ATF.
> >
> > Signed-off-by: Jolly Shah <jollys@xilinx.com>
> > Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
> > ---
> <snip>
> >
> 
> > +/**
> > + * zynqmp_pm_clock_enable - Enable the clock for given id
> > + * @clock_id:  ID of the clock to be enabled
> 
> Does it enable all the parents also if they are disabled?
Current solution enables specified clock only. We are working on enhancing the solution to take care of other dependent clocks.

> 
> > + *
> > + * This function is used by master to enable the clock
> > + * including peripherals and PLL clocks.
> > + *
> > + * Return:     Returns status, either success or error+reason.
> > + */
> > +static int zynqmp_pm_clock_enable(u32 clock_id) {
> > +       return invoke_pm_fn(PM_CLOCK_ENABLE, clock_id, 0, 0, 0, NULL);
> > +}
> > +
> > +/**
> > + * zynqmp_pm_clock_disable - Disable the clock for given id
> > + * @clock_id:  ID of the clock to be disable
> > + *
> > + * This function is used by master to disable the clock
> > + * including peripherals and PLL clocks.
> > + *
> > + * Return:     Returns status, either success or error+reason.
> > + */
> > +static int zynqmp_pm_clock_disable(u32 clock_id) {
> > +       return invoke_pm_fn(PM_CLOCK_DISABLE, clock_id, 0, 0, 0,
> > +NULL); }
> > +
> > +/**
> > + * zynqmp_pm_clock_getstate - Get the clock state for given id
> > + * @clock_id:  ID of the clock to be queried
> > + * @state:     1/0 (Enabled/Disabled)
> > + *
> > + * This function is used by master to get the state of clock
> > + * including peripherals and PLL clocks.
> > + *
> > + * Return:     Returns status, either success or error+reason.
> > + */
> > +static int zynqmp_pm_clock_getstate(u32 clock_id, u32 *state) {
> > +       u32 ret_payload[PAYLOAD_ARG_CNT];
> > +       int ret;
> > +
> > +       ret = invoke_pm_fn(PM_CLOCK_GETSTATE, clock_id, 0, 0, 0,
> ret_payload);
> > +       *state = ret_payload[1];
> > +
> > +       return ret;
> > +}
> > +
> > +/**
> > + * zynqmp_pm_clock_setdivider - Set the clock divider for given id
> > + * @clock_id:  ID of the clock
> > + * @div_type:  TYPE_DIV1: div1
> > + *             TYPE_DIV2: div2
> div type didnt see in the signature.


Will be fixed in next version.

> 
> 
> 
> > + * @divider:   divider value.
> > + *
> > + * This function is used by master to set divider for any clock
> > + * to achieve desired rate.
> > + *
> > + * Return:     Returns status, either success or error+reason.
> > + */
> > +static int zynqmp_pm_clock_setdivider(u32 clock_id, u32 divider) {
> > +       return invoke_pm_fn(PM_CLOCK_SETDIVIDER, clock_id, divider, 0,
> > +0, NULL); }
> > +
> > +/**
> > + * zynqmp_pm_clock_getdivider - Get the clock divider for given id
> > + * @clock_id:  ID of the clock
> > + * @div_type:  TYPE_DIV1: div1
> > + *             TYPE_DIV2: div2
> didnt see this  below.
Will be fixed in next version.


> 
> > + * @divider:   divider value.
> > + *
> > + * This function is used by master to get divider values
> > + * for any clock.
> > + *
> > + * Return:     Returns status, either success or error+reason.
> > + */
> > +static int zynqmp_pm_clock_getdivider(u32 clock_id, u32 *divider) {
> > +       u32 ret_payload[PAYLOAD_ARG_CNT];
> > +       int ret;
> > +
> > +       ret = invoke_pm_fn(PM_CLOCK_GETDIVIDER, clock_id, 0, 0, 0,
> ret_payload);
> > +       *divider = ret_payload[1];
> > +
> > +       return ret;
> > +}
> > +
> > +/**
> > + * zynqmp_pm_clock_setrate - Set the clock rate for given id
> > + * @clock_id:  ID of the clock
> > + * @rate:      rate value in hz
> > + *
> > + * This function is used by master to set rate for any clock.
> > + *
> > + * Return:     Returns status, either success or error+reason.
> > + */
> So this can set rate only 4G max ?
Need to fix this to have u64 rate.

> 
> > +static int zynqmp_pm_clock_setrate(u32 clock_id, u32 rate) {
> > +       return invoke_pm_fn(PM_CLOCK_SETRATE, clock_id, rate, 0, 0,
> > +NULL); }
> > +
> > +/**
> > + * zynqmp_pm_clock_getrate - Get the clock rate for given id
> > + * @clock_id:  ID of the clock
> > + * @rate:      rate value in hz
> > + *
> > + * This function is used by master to get rate
> > + * for any clock.
> > + *
> > + * Return:     Returns status, either success or error+reason.
> > + */
> Same question here?
Need to fix this to have u64 rate.

> 
> > +static int zynqmp_pm_clock_getrate(u32 clock_id, u32 *rate) {
> > +       u32 ret_payload[PAYLOAD_ARG_CNT];
> > +       int ret;
> > +
> > +       ret = invoke_pm_fn(PM_CLOCK_GETRATE, clock_id, 0, 0, 0, ret_payload);
> > +       *rate = ret_payload[1];
> > +
> > +       return ret;
> > +}
> > +
> Also  what is the difference between set rate and set divider?
Set rate takes rate as input and dividers are calculated by FW. 
Set divider takes dividers as input and sets them directly.
With linux, it is recommended to use set divider only. Set rate API is mainly for baremetal case.


Thanks,
Jolly Shah
