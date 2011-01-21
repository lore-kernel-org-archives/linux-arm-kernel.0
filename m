From: skannan@codeaurora.org (Saravana Kannan)
Date: Thu, 20 Jan 2011 23:16:04 -0800
Subject: Locking in the clk API
In-Reply-To: <20110120190822.GK6335@n2100.arm.linux.org.uk>
References: <201101111016.42819.jeremy.kerr@canonical.com>	<20110111091607.GI12552@n2100.arm.linux.org.uk>	<201101111744.59712.jeremy.kerr@canonical.com>	<20110111103929.GN24920@pengutronix.de>	<AANLkTinHL9X_bqMPR=W8Va01O4xngUnpGCkCiE3xEdiQ@mail.gmail.com>	<4D386ABF.9060908@fluff.org>
	<20110120190822.GK6335@n2100.arm.linux.org.uk>
Message-ID: <4D3932B4.8010904@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/20/2011 11:08 AM, Russell King - ARM Linux wrote:
> On Thu, Jan 20, 2011 at 05:02:55PM +0000, Ben Dooks wrote:
>> If you want to make it so that each low-power mode has to work
>> out what PLLs need to be disabled and then re-enabled makes me
>> want to be sick. Hiding this stuff behind specific implementations
>> is a recipe for disaster.
>
> Why should systems which don't suffer from such problems be prevented
> from gaining power saving from turning off their clocks when devices
> are not being used (eg, the console serial port.)
>
> One solution to your root PLL issue would be to have a separate set of
> enable/disable API calls which get called at setup/release time (or
> whatever you'd like to call it) which can only be called from non-atomic
> context.  Maybe clk_prepare() and clk_unprepare().  These functions
> should perform whatever is necessary to ensure that the clock source
> is available for use atomically when clk_enable() is called.
>
> So, in your case, clk_prepare() ensures that the root PLL is enabled,
> clk_unprepare() allows it to be turned off.
>
> In the case of a console driver, clk_prepare() can be called when we
> know the port will be used as a console.  clk_enable() is then called
> before writing out the string, and clk_disable() after we've completely
> sent the last character.
>
> This allows the best of both worlds.  We now have a clk_enable() which
> can be used to turn the clocks off through the clock tree up to the first
> non-atomic clock, and we also have a way to deal with those which need
> to sleep.  So not only do "sleeping clock" implementations become possible
> but these "sleeping clock" implementations also get the opportunity to
> shutdown some of their clock tree with minimal latency for doing so.

This suggestion looked promising till I realized that clk_set_rate() 
will still be atomic. clk_set_rate() will need to enable/disable the 
PLLs depending on which PLLs the rates are derived from. So, the locking 
in clk_prepare/unprepare() still has to be atomic since the "slow stuff" 
is shared with clk_set_rate().

IMO, the most workable/flexible suggestion I have seen so far is:
- Having a way to explicitly ask for an atomic clock from clk_get(). 
That way the driver can decide to fail early during probe or decide to 
enable/disable in open/close or if it gets atomic clocks to 
enable/disable in atomic context.
- Atomic and sleep-able variants of clk_enable/disable/set_rate. I 
personally prefer the existing APIs to be sleep-able and introduce new 
atomic variants, but it's not worth the time arguing over that.

Taking one step at a time, do we all at least agree having two variants 
of enable/disable/set_rate?

Thanks,
Saravana

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
