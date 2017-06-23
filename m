From: dianders@chromium.org (Doug Anderson)
Date: Thu, 22 Jun 2017 21:26:19 -0700
Subject: [PATCH v2 4/4] arm64: dts: rockchip: use cs-gpios for cros_ec_spi
In-Reply-To: <594C905E.1040208@rock-chips.com>
References: <1497331543-8565-1-git-send-email-jeffy.chen@rock-chips.com>
 <1497331543-8565-4-git-send-email-jeffy.chen@rock-chips.com>
 <20170613175043.GC9026@google.com>
 <20170613182225.smahsf3jzvbc7w7z@sirena.org.uk>
 <20170620004739.GA67314@google.com>
 <CAD=FV=UKe5M-M=gXwdjp25vpR0CHtk1APRF0_b4PXQrGOc40+A@mail.gmail.com>
 <594C905E.1040208@rock-chips.com>
Message-ID: <CAD=FV=VWjbGpY4nj2L0_6xaYY2_tp0pJ5q=BgppL9GWefBUGog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jun 22, 2017 at 8:51 PM, jeffy <jeffy.chen@rock-chips.com> wrote:
> Hi doug,
>
> Thanx for your comments.
>
>
> On 06/23/2017 06:47 AM, Doug Anderson wrote:
>>
>> Hi,
>>
>> On Mon, Jun 19, 2017 at 5:47 PM, Brian Norris <briannorris@chromium.org>
>> wrote:
>>>
>>> Hi Mark,
>>>
>>> Forgot to follow up here:
>>>
>>> On Tue, Jun 13, 2017 at 07:22:25PM +0100, Mark Brown wrote:
>>>>
>>>> On Tue, Jun 13, 2017 at 10:50:44AM -0700, Brian Norris wrote:
>>>>>
>>>>> On Tue, Jun 13, 2017 at 01:25:43PM +0800, Jeffy Chen wrote:
>>>>>>
>>>>>> The cros_ec requires CS line to be active after last message. But the
>>>>>> CS
>>>>>> would be toggled when powering off/on rockchip spi, which breaks ec
>>>>>> xfer.
>>>>>> Use GPIO CS to prevent that.
>>>>
>>>>
>>>>> I suppose this change is fine. (At least, I don't have a good reason
>>>>> not
>>>>> to do this.)
>>>>
>>>>
>>>>> But I still wonder whether this is something that the SPI core can be
>>>>> expected to handle. drivers/mfd/cros_ec_spi.c already sets the
>>>>> appropriate trans->cs_change bits, to ensure CS remains active in
>>>>> between certain messages (all under spi_bus_lock()). But you're
>>>>> suggesting that your bus controller may deassert CS if you runtime
>>>>> suspend the device (e.g., in between messages).
>>>>
>>>>
>>>>> So, is your controller just peculiar? Or should the SPI core avoid
>>>>> autosuspending the bus controller when it's been instructed to keep CS
>>>>> active? Any thoughts Mark?
>>>>
>>>>
>>>> This sounds like the controller being unusual - though frankly the
>>>> ChromeOS chip select usage is also odd so it's fairly rare for something
>>>> like this to come up.  I'd not expect a runtime suspend to loose the pin
>>>> state, though possibly through use of pinctrl rather than the
>>>> controller.
>>>
>>>
>>> I haven't personally verified this behavior (it probably wouldn't be too
>>> hard to rig up a test driver to hold CS low while allowing the
>>> controller to autosuspend? spidev can do this?), but Rockchip folks seem
>>> to have concluded this.
>>>
>>> I suppose I'm fine with relying on cs-gpios as a workaround.
>>
>>
>> I'm similarly hesitant to rely on cs-gpios as a workaround, though I
>> won't directly stand in its way...  ...it seems like it would be
>> slightly better to actually add a runtime_suspend() callback and
>> adjust the pinmux dynamically (that would allow us to use the hardware
>> chip select control if we ever enable that in the driver), but I'm not
>> sure all the extra work to do that is worth it.
>>
>> It feels a little bit to me like the workaround here doesn't belong in
>> the board's device tree file, though.  This is a quirk of the SoC's
>> SPI controller whenever it's runtime suspended.  Any board using this
>> SPI could possibly be affected, right?
>
> hmm, so i should add cs_gpio to all rockchip boards right?

I think with the pinmux change I suggested below (which would be in
rk3399.dtsi) you wouldn't need the cs-gpios workaround anywhere.  If
someone _wanted_ to get cs-gpios to get more than one chip select or
to use a different GPIO as a chip select, they could.  ...but there
would be no need to use cs-gpios as a workaround.


>> Oh wait (!!!!)
>>
>>
>> Let's think about this.  Let me ask a question.  When you runtime
>> suspend the SPI part (and turn off the power domain) but don't
>> configure pins to be GPIO, what happens?  I'm assuming it's one of
>> three things:
>>
>> 1. The line is driven a certain direction (probably low).  This seems
>> unlikely.
>>
>> 2. The line is no longer driven by the SPI controller and thus the
>> pin's pulls take effect.  This seems _likely_.
>>
>> 3. The line is no longer driven by the SPI controller and somehow the
>> pulls stop taking effect.  This seems unlikely.
>>
>>
>> ...I'll assume that #2 is right (please correct if I'm wrong).
>> Thinking about that makes me think that we need to worry not just
>> about the chip select line but about the other SPI lines too, right?
>> AKA if the SPI controller stops driving the chip select line, it's
>> probably also not driving MISO, MOSI, or TXD.
>>
>> ...so looking at all the SPI lines, they all have pullup configured in
>> the "default" mode in rk3399.dtsi.
>>
>> ...and looking as "cros_ec_spi.c", I see that we appear to be using
>> MODE_0.
>>
>>
>> That means if you runtime suspend while the cros EC code was running
>> and none of your patches have landed, all lines will float high.
>>
>> 1. Chip select will be deasserted (this is the problem you're trying to
>> solve).
>>
>> 2. Data line and clock line will get pulled high.
>>
>> Using spi.h, MODE_0 means SPI_CPOL=0 and SPI_CPHA=0.  Using Wikipedia
>> (which is never wrong, of course), that means data is captured on the
>> clock's rising edge.  Thus we'll actually clock one bit of data here,
>> but at the same time that we try to turn off chip select.
>>
>>
>> ...now we look at your proposed solution and we'll leave chip select
>> on, but we'll still clock one bit of data (oops).  ...or, I guess, if
>> the EC itself has pulls configured we might be in some state where the
>> different pulls are fighting, but that still seems non-ideal.
>>
>> ---
>>
>> So how do we fix this?  IMHO:
>>
>> Add 4 new pinctrl states in rk3399.dtsi:
>>
>>    cs_low_clk_low, cs_low_clk_high, cs_high_clk_low, cs_high_clk_high
>>
>> These would each look something like this:
>>
>> spi5_cs_low_data_low: spi5-cs-low-data-low {
>>    rockchip,pins = <2 22 RK_FUNC_0 &pcfg_output_low>,
>>      <2 23 RK_FUNC_0 &pcfg_output_low>;
>> };
>>
>> Where "pcfg_output_low" would be moved from the existing location in
>> "rk3399-gru.dtsi" to the main "rk3399.dtsi" file.
>>
>>
>> ...now, you'd define runtime_suspend and runtime_resume functions
>> where you'd look at the current state of the chip select and output
>> and select one of these 4 pinmuxes so that things _don't_ change.
>>
>> If the pinmuxes didn't exist you'd simply deny PM Runtime Transitions.
>> That would nicely take care of the backward compatibility problem.
>> Old DTS files would work, they just wouldn't be able to Runtime PM
>> properly.
>
> so we should use runtime pinmuxes to fix this issue, and also support
> cs_gpio as an option right?

Right.  So in my opinion:

* Your patch to add "SPI_MASTER_GPIO_SS" would be fine to post and
land, but it wouldn't be needed for the runtime PM issue.  Thinking
about this and the GPIO chip selects, I wonder if the whole
SPI_MASTER_GPIO_SS concept is broken if you use one "GPIO" based chip
select and one native chip select.  I can try looking through the code
tomorrow if you're going to pursue this and haven't figured it out...

* If you want to improve the way that the SPI framework handles GPIO
chip selects (to handle errors better and request the GPIO better),
that would be fine.  ...but it also wouldn't be needed for the runtime
PM issue.

* There should be no need to add cs-gpios to existing boards if you're
using the pinmux solution.

* You'd want to add the pinmux configs to the main rk3399.dtsi file
and then add code to the rockchip SPI driver to select the right
pinmux (depending on the current state of the chip select and the
current polarity) at runtime suspend.  ...then go back to "default"
mode at runtime resume.


-Doug
