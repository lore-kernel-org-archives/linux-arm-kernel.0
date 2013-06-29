From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sat, 29 Jun 2013 20:55:34 +0200
Subject: armada_drm clock selection
In-Reply-To: <20130629184553.GB3353@n2100.arm.linux.org.uk>
References: <20130628201133.1D6D2FAAD5@dev.laptop.org>
 <20130628211848.GJ4283@n2100.arm.linux.org.uk>
 <CAMLZHHQZ+36g9EQhj+LOgQioj8T5VDwvUdNrkVLboT8tYi9gXQ@mail.gmail.com>
 <51CF0422.5020302@gmail.com> <20130629184553.GB3353@n2100.arm.linux.org.uk>
Message-ID: <51CF2DA6.7070303@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/29/2013 08:45 PM, Russell King - ARM Linux wrote:
> On Sat, Jun 29, 2013 at 05:58:26PM +0200, Sebastian Hesselbarth wrote:
>> On 06/29/2013 05:06 PM, Daniel Drake wrote:
>>> On Fri, Jun 28, 2013 at 3:18 PM, Russell King - ARM Linux
>>> <linux@arm.linux.org.uk>   wrote:
>>>> Sure... lets add some background info first: the big problem here is the
>>>> completely different register layouts for the clock register:
>>>>
>>>> On Armada 510:
>>>> 31:30 - select the clock input from 4 possible sources:
>>>>           0 - AXI, 1 - EXT0, 2 - PLL, 3 - EXT1
>>>> 29    - loads the divider values
>>>> 27:16 - (broken) fractional divider - you never want to use this
>>>> 15:0  - integer divider
>>
>> The reason why I called fractional divider broken is because it skips
>> clock cycles which renders the clock useless for continuous clocking
>> requirements. For smart panel SPI, it might work - but as soon as no
>> board with that pops up, I suggest not to go for it.
>
> I think you mean "let's ignore the fractional divider until we have a
> board which uses a smart panel".

Yes, thanks for clearing that out.

>>> With your clear explanations I think I can come up with an
>>> implementation that takes all these factors into account, offering
>>> access to a great deal of the available functionality. Should not be
>>> too difficult now that we have had this discussion, and I'd be happy
>>> to do so. But before I do that, a question popped up into my mind: is
>>> this complexity really worth it?
>>
>> Depends, with per-SoC callbacks we should be safe for every possible
>> requirement. With DT, the user always will have the option to add/remove
>> clocks passed by clocks/clock-names matching his requirements.
>
> That, I think, is why clock names have to be mandatory for this driver,
> so we know what each DT clock specified actually is.  We can't really
> go and just specify one or two clocks when they may just be the external
> clocks and have no way for the driver to know that.

True. We should define a set of valid names per SoC and determine the
required SCLK setting by that name.

>>> For OLPC, we only ever use LCD1 with divider 2 for our panel, which
>>> only has 1 resolution. I think we use the fast AXI clock for HDMI
>>> path, which has a separate SCLK register. For armada 510, it looks
>>> like you are quite happy with the EXT1 clock, and you mentioned that
>>> on the 16x most of the clocks are broken, which might mean there is
>>> again just one clock of preference?
>>
>> As soon as you are required to use EDID provided modes, you will have
>> to provide the exact clock rate. With broken fractional divider on Dove
>> above, you are stuck to integer division. And none of the internal
>> frequencies give you multiple of 74.25MHz which is what you want for TV
>> applications. So for Dove, you almost always want to use extclk, if
>> connected to an external pll.
>
> Ahem.  There is no such thing as an "exact clock rate".  Even the world's
> most accurate clock (caesium fountain) is only accurate to 1 part in 10^14!
> (I have in the past worked in an equipment calibration laboratory with
> their own Rubidium standard synchronized to a remote Caesium fountain
> standard at the UK NPL, so you'll excuse me for being a pedant when it
> comes to that!)
>
> All that's required here is a clock rate which is "good enough".  Getting
> it accurate to 4 significant digits is likely to be "good enough".

Being an engineer, "exact" and "good enough" are synonymes for me ;)

> The problem here is that the internal clocks are be 2GHz divided by an
> integer divider.  The closest to 74.25MHz from the Dove's internal clocks
> is with a divider of 27, which gives you 74.07MHz, which is off by about
> 2.4% - far from "good enough", especially when you consider the video/
> audio sync issues that would cause (you'd need about 1 additional audio
> sample per 50).

For video only and the monitor it should be sufficient but you are
right, for audio and video it is not "good enough".

>>> So, could we just specify per-CRTC clock preference in platform data,
>>> DT, or something like that? e.g. we could just specify which SCLK bits
>>> to set and clear, and which Linux-level struct clk is engaged as a
>>> result. It adds a little burden for the platform implementor, but it
>>> would avoid all of the complications that you have mentioned. Or do
>>> you have a preference for the added flexibility?
>>
>> I suggest not to do any sophisticated approach to determine the "best"
>> clock. Just set the SCLK source determined by the name of first clock
>> passed either by DT or platform_data. This gives everybody the
>> flexibility but keeps implementation overhead small.
>
> The problem this gives is we need to know what SCLK setting to use,
> and I don't think specifying raw register values in DT is a particularly
> good solution to that.

I think it is never good style to have raw register values in DT. But
different compatible strings for different SoCs plus clock names should
give us enough information to setup the clock.

Sebastian
