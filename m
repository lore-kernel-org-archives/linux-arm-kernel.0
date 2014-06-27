From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 27 Jun 2014 16:01:06 -0600
Subject: [PATCH v1 6/9] usb: xhci: Add NVIDIA Tegra XHCI host-controller
 driver
In-Reply-To: <CAL1qeaEb2aV16F+sXWZ=FtEFW2rcGHhqVJk7+OmU5AtjZiHBDQ@mail.gmail.com>
References: <1403072180-4944-1-git-send-email-abrestic@chromium.org>	<1403072180-4944-7-git-send-email-abrestic@chromium.org>	<53AB4F2D.2060208@wwwdotorg.org>	<CAL1qeaFhfYdW06Md10eGVYWBrRR+f1yykVYHNp5+9-t1C9joPQ@mail.gmail.com>	<53AC6152.5060908@wwwdotorg.org>
 <CAL1qeaEb2aV16F+sXWZ=FtEFW2rcGHhqVJk7+OmU5AtjZiHBDQ@mail.gmail.com>
Message-ID: <53ADE9A2.5020305@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/27/2014 03:19 PM, Andrew Bresticker wrote:
> On Thu, Jun 26, 2014 at 11:07 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> On 06/25/2014 06:06 PM, Andrew Bresticker wrote:
>>> On Wed, Jun 25, 2014 at 3:37 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>>>> On 06/18/2014 12:16 AM, Andrew Bresticker wrote:
>>>>> Add support for the on-chip XHCI host controller present on Tegra SoCs.
>>>>>
>>>>> The driver is currently very basic: it loads the controller with its
>>>>> firmware, starts the controller, and is able to service messages sent
>>>>> by the controller's firmware.  The hardware supports device mode as
>>>>> well as runtime power-gating, but support for these is not yet
>>>>> implemented here.
> 
>>>>> diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
> 
>>>>> +static int tegra_xhci_set_ss_clk(struct tegra_xhci_hcd *tegra,
>>>>> +                              unsigned long rate)
>>>>
>>>>> +     switch (rate) {
>>>>> +     case TEGRA_XHCI_SS_CLK_HIGH_SPEED:
>>>>> +             /* Reparent to PLLU_480M. Set div first to avoid overclocking */
>>>>> +             old_parent_rate = clk_get_rate(clk_get_parent(clk));
>>>>> +             new_parent_rate = clk_get_rate(tegra->pll_u_480m);
>>>>> +             div = new_parent_rate / rate;
>>>>> +             ret = clk_set_rate(clk, old_parent_rate / div);
>>>>> +             if (ret)
>>>>> +                     return ret;
>>>>> +             ret = clk_set_parent(clk, tegra->pll_u_480m);
>>>>> +             if (ret)
>>>>> +                     return ret;
>>>>
>>>> Don't you need to call clk_set_rate() again after reparenting, since the
>>>> divisor will be different, and the rounding too.
>>>
>>> Nope, the divider we set before remains in-tact after clk_set_parent().
>>
>> Oh I see, the clk_set_rate() call is setting up div so it's appropriate
>> after the new parent is selected.
>>
>> Wouldn't it be better to just stop the clock, assert reset, reparent the
>> clock, and then set the desired rate directly?
> 
> I'm not sure how that would be better than making it more obvious as
> to how we arrive at the final rate.  Keep in mind that the XHCI host
> is running at this point (we usually get the scale-up message as a
> USB3 device is being enumerated) and that disabling the clock and/or
> asserting reset to the SS partition clock may not be the best idea...

Oh, this happens while the device is running rather than when
initializing it? Applying reset is probably a bad idea then. Still,
perhaps stopping the clock for a short time is fine? What about:

clk_disable_unprepare(clk);
clk_set_parent(clk, tegra->pll_u_480m);
clk_set_rate(clk, rate);
clk_prepare_enable(clk);

That seems much more direct to me. The code above feels over-complex to me.

If the clock really can't be stopped, then I suppose the existing code
in the patch is fine. I'd like to see a final clk_get_rate(clk) call
added, and the value compared against the expected value, to make sure
no rounding/truncation of the divider happened though.
