From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 2 Oct 2015 09:07:04 +0000 (UTC)
Subject: [PATCH 01/11 RESEND] ARM: OMAP: DRA7: hwmod: Add data for McASP3
In-Reply-To: <560BB434.6080308@ti.com>
References: <1442326206-30192-1-git-send-email-peter.ujfalusi@ti.com>
 <alpine.DEB.2.02.1509270631440.7947@utopia.booyaka.com>
 <560BB434.6080308@ti.com>
Message-ID: <alpine.DEB.2.02.1510020854390.11596@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello P?ter,

On Wed, 30 Sep 2015, Peter Ujfalusi wrote:

> On 09/27/2015 10:02 AM, Paul Walmsley wrote:
> >>  /*
> >> + * 'mcasp' class
> >> + *
> >> + */
> >> +static struct omap_hwmod_class_sysconfig dra7xx_mcasp_sysc = {
> >> +	.sysc_offs	= 0x0004,
> >> +	.sysc_flags	= SYSC_HAS_SIDLEMODE,
> >> +	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
> >> +	.sysc_fields	= &omap_hwmod_sysc_type3,
> >> +};
> >> +
> >> +static struct omap_hwmod_class dra7xx_mcasp_hwmod_class = {
> >> +	.name	= "mcasp",
> >> +	.sysc	= &dra7xx_mcasp_sysc,
> >> +};
> >> +
> >> +/* mcasp3 */
> >> +static struct omap_hwmod dra7xx_mcasp3_hwmod = {
> >> +	.name		= "mcasp3",
> >> +	.class		= &dra7xx_mcasp_hwmod_class,
> >> +	.clkdm_name	= "l4per2_clkdm",
> >> +	.main_clk	= "mcasp3_ahclkx_mux",
> > 
> > I'd expect this clock to be something derived from mcasp3_aux_gfclk, 
> > according to Table 24-408 "Clocks and Resets" of SPRUHZ6.  Could you 
> > please doublecheck this?
> 
> I can not explain this. If I change the main_clk to "mcasp3_aux_gfclk_mux"
> then I can not access to McASP3 register at all.
> I don't see anything popping out in the clock data, nor in other places.

OK thank you for testing that.  Maybe just add a brief comment along those 
lines in the hwmod data, above the structure record declaration?

> >> +	.flags		= HWMOD_SWSUP_SIDLE,
> 
> Not sure why this has been added, I can not find any pointers regarding to
> this and everything is working w/o this flag. Will remove it in v2.

OK thanks.  

> >> @@ -2566,6 +2598,14 @@ static struct omap_hwmod_ocp_if dra7xx_l3_main_1__hdmi = {
> >>  	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> >>  };
> >>  
> >> +/* l4_per2 -> mcasp3 */
> >> +static struct omap_hwmod_ocp_if dra7xx_l4_per2__mcasp3 = {
> >> +	.master		= &dra7xx_l4_per2_hwmod,
> >> +	.slave		= &dra7xx_mcasp3_hwmod,
> > 
> > So this is the low-speed control/register access port, where the MPU 
> > writes to the McASP3 config registers...
> > 
> >> +	.clk		= "l3_iclk_div",
> > 
> > ... and thus this interface clock doesn't look right for this port, since 
> > it's most likely generated from the L4PER2, where this port is connected.  
> > So it should probably be "l4_iclk_div".
> 
> There is no "l4_iclk_div" for dra7xx. Looking around the file all other script
> generated data uses "l3_iclk_div" for IPs under dra7xx_l4_per2_hwmod.
> 
> Tero: do you know the reason for this?

Sounds like from your followup E-mail that the clock name to use in the 
kernel is "l4_root_clk_div", which sounds fine to me.  (Haven't looked 
closely at the clock data, though.)

> >> +	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> >> +};
> > 
> > There's another struct omap_hwmod_ocp_if record missing: the high-speed 
> > bus-master port that the McASP3 uses to DMA audio data.  This port should 
> > most likely be clocked with "l3_iclk_div" per Table 24-408 "Clocks and 
> > Resets".  This port is also where the registers described in Table 24-555 
> > "MCASP_DAT Register Summary 3" L3_MAIN column are exposed.  You've got 
> > that address map range blocked out in your DT data reg property, and 
> > associated with this device, right? 0x46000000?
> 
> Yes, the McASP3-dat port is not used ATM. This is over the L3 interconnect and
> due to a feature we can not use it with sDMA (constant addressing is not
> supported through L3 interconnect for DMAs).
> We could use eDMA, but there are complications regarding to that.
> At the moment we are using the sDMA through the L4 interconnect address space.

OK thanks for the explanation.  The hwmod code prevents links from being 
registered if no initiator 'users' are listed, so sounds like we should 
leave it out for now.  Could you add a brief comment, similar to your 
paragraph above, in the data, in case others wonder about the L3 link?

After those changes are made, feel free to add my ack.


K?sz?n?m,

- Paul
