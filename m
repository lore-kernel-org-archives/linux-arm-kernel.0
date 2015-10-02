From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri, 2 Oct 2015 14:22:58 +0300
Subject: [PATCH 01/11 RESEND] ARM: OMAP: DRA7: hwmod: Add data for McASP3
In-Reply-To: <alpine.DEB.2.02.1510020854390.11596@utopia.booyaka.com>
References: <1442326206-30192-1-git-send-email-peter.ujfalusi@ti.com>
 <alpine.DEB.2.02.1509270631440.7947@utopia.booyaka.com>
 <560BB434.6080308@ti.com>
 <alpine.DEB.2.02.1510020854390.11596@utopia.booyaka.com>
Message-ID: <560E6912.4030902@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paul,

On 10/02/2015 12:07 PM, Paul Walmsley wrote:
> Hello P?ter,
> 
> On Wed, 30 Sep 2015, Peter Ujfalusi wrote:
> 
>> On 09/27/2015 10:02 AM, Paul Walmsley wrote:
>>>>  /*
>>>> + * 'mcasp' class
>>>> + *
>>>> + */
>>>> +static struct omap_hwmod_class_sysconfig dra7xx_mcasp_sysc = {
>>>> +	.sysc_offs	= 0x0004,
>>>> +	.sysc_flags	= SYSC_HAS_SIDLEMODE,
>>>> +	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
>>>> +	.sysc_fields	= &omap_hwmod_sysc_type3,
>>>> +};
>>>> +
>>>> +static struct omap_hwmod_class dra7xx_mcasp_hwmod_class = {
>>>> +	.name	= "mcasp",
>>>> +	.sysc	= &dra7xx_mcasp_sysc,
>>>> +};
>>>> +
>>>> +/* mcasp3 */
>>>> +static struct omap_hwmod dra7xx_mcasp3_hwmod = {
>>>> +	.name		= "mcasp3",
>>>> +	.class		= &dra7xx_mcasp_hwmod_class,
>>>> +	.clkdm_name	= "l4per2_clkdm",
>>>> +	.main_clk	= "mcasp3_ahclkx_mux",
>>>
>>> I'd expect this clock to be something derived from mcasp3_aux_gfclk, 
>>> according to Table 24-408 "Clocks and Resets" of SPRUHZ6.  Could you 
>>> please doublecheck this?
>>
>> I can not explain this. If I change the main_clk to "mcasp3_aux_gfclk_mux"
>> then I can not access to McASP3 register at all.
>> I don't see anything popping out in the clock data, nor in other places.
> 
> OK thank you for testing that.  Maybe just add a brief comment along those 
> lines in the hwmod data, above the structure record declaration?

Now I more or less figured out the root of the issue. According to the
documentations the McASP in dra7xx family has following clocks:
ICLK - interface clock
GFCLK - functional clock
AHCLKX - Transmit high-frequency master clock
AHCLKR - Receive high-frequency master clock (on selected instances)

In order to access registers all of these clock lines must have valid clock
signal. No other SoC with McASP has this setup.
As for why things seams to work when mcasp3_ahclkx_mux is set as main_clk and
mcasp3_aux_gfclk_mux is not handled at all?
The mcasp3_aux_gfclk_mux by default is from PER_ABE_X1GFCLK we never change
this. On dra7/72 evm the AHCLKX is reparented to ATL2 clock.
When with pm_runtime we enable the device, the mcasp3_ahclkx_mux will be
enabled by the SW (and ATL as well) _and_ the mcasp3_aux_gfclk_mux path will
be enabled by HW w/o SW.
The reason why I have had crash when I switched the main_clk to
mcasp3_aux_gfclk_mux is that even the path for the mcasp3_ahclkx_mux is
enabled by the HW, the ATL itself was not enabled, so it was not generating
the needed clocks. Same goes backwards for the gfclk: if I reparent it to
let's say HDMI clock - which is not present, and handle the ahclkx clock I
have similar crash.
All in all: the McASP3 needs ICLK and both FCLK and AHCLKX to be running in
order to be able to access registers.

This current setup works fine, the only issue I see is that the refcounts for
the mcasp3_aux_gfclk_mux path is not reflecting the reality.

With Tero we looked at different angles of this and how to solve it w/o
considering it as a hack.
Either we go with the hwmod data with main_clk set to mcasp3_ahclkx_mux and
document it in a comment, or:
Add new flag HWMOD_OPT_CLKS_NEEDED to hwmods to use to tell that the optional
clocks are not really optional as they are needed to be enabled in order to
access to the IP. In omap_hwmod.c's _enable_clocks() and _disable_clocks() we
call _enable_optional_clocks()/_disable_optional_clocks() if the flag is set
for the hwmod and add the ahclkx_mux as optional clock for McASP3.

>>>> +	.user		= OCP_USER_MPU | OCP_USER_SDMA,
>>>> +};
>>>
>>> There's another struct omap_hwmod_ocp_if record missing: the high-speed 
>>> bus-master port that the McASP3 uses to DMA audio data.  This port should 
>>> most likely be clocked with "l3_iclk_div" per Table 24-408 "Clocks and 
>>> Resets".  This port is also where the registers described in Table 24-555 
>>> "MCASP_DAT Register Summary 3" L3_MAIN column are exposed.  You've got 
>>> that address map range blocked out in your DT data reg property, and 
>>> associated with this device, right? 0x46000000?
>>
>> Yes, the McASP3-dat port is not used ATM. This is over the L3 interconnect and
>> due to a feature we can not use it with sDMA (constant addressing is not
>> supported through L3 interconnect for DMAs).
>> We could use eDMA, but there are complications regarding to that.
>> At the moment we are using the sDMA through the L4 interconnect address space.
> 
> OK thanks for the explanation.  The hwmod code prevents links from being 
> registered if no initiator 'users' are listed, so sounds like we should 
> leave it out for now.  Could you add a brief comment, similar to your 
> paragraph above, in the data, in case others wonder about the L3 link?

Sure, I'll do that.

> 
> After those changes are made, feel free to add my ack.

I'll wait for your comment regarding to the multiple main_clk need for the
McASP3 before I'll send the next version.

> K?sz?n?m,

:D

> 
> - Paul
> 

-- 
P?ter
