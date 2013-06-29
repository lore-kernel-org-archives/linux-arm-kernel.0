From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sat, 29 Jun 2013 17:58:26 +0200
Subject: armada_drm clock selection
In-Reply-To: <CAMLZHHQZ+36g9EQhj+LOgQioj8T5VDwvUdNrkVLboT8tYi9gXQ@mail.gmail.com>
References: <20130628201133.1D6D2FAAD5@dev.laptop.org>
 <20130628211848.GJ4283@n2100.arm.linux.org.uk>
 <CAMLZHHQZ+36g9EQhj+LOgQioj8T5VDwvUdNrkVLboT8tYi9gXQ@mail.gmail.com>
Message-ID: <51CF0422.5020302@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/29/2013 05:06 PM, Daniel Drake wrote:
> On Fri, Jun 28, 2013 at 3:18 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk>  wrote:
>> Sure... lets add some background info first: the big problem here is the
>> completely different register layouts for the clock register:
>>
>> On Armada 510:
>> 31:30 - select the clock input from 4 possible sources:
>>          0 - AXI, 1 - EXT0, 2 - PLL, 3 - EXT1
>> 29    - loads the divider values
>> 27:16 - (broken) fractional divider - you never want to use this
>> 15:0  - integer divider

The reason why I called fractional divider broken is because it skips
clock cycles which renders the clock useless for continuous clocking
requirements. For smart panel SPI, it might work - but as soon as no
board with that pops up, I suggest not to go for it.

>> Armada 16x:
>> 31:28 - select clock input from 4 possible sources using bit patterns.
>>          0 - AHB, 1 - PCLK, 2 - AXI, 3 - PLL
>> 27:16 - (broken) fractional divider
>> 15:0  - integer divider
>>
>>  From drivers/video/mmp driver (MMP2/MMP3, aka Armada 610?):
>> 31    - clock select
>> 28    - disable bit
>> 27:16 - fractional divider
>> 15:12 - apparantly not used
>> 11:8  - DSI divider
>> 7:0   - integer divider
>
> MMP2 (Armada 610) and MMP3 (PXA2128, no Armada name) is even a bit
> more complex than that.
> On MMP2 the selectable clocks are written in bits 31:30 and are:
> 0 - AXI, 1 - LCD1, 2 - LCD2, 3 - HDMI
>
> On MMP3 the selectable clocks are written in bits 31:29 and are:
> 0 - AXI or LVDS (depending on bit 12)
> 1 - LCD1
> 2 - LCD2
> 3 - HDMI
> 7 - DSI
>
> When clock 0 is selected, bit 12 comes into effect for the final say
> on the clock selection. 0 = AXI, 1 = LVDS
>
> As you note, handling all this stuff is not trivial. And I also
> understand the complications that we do not want to change some
> clocks, if they are in use by another CRTC or are shared with other
> parts of the system.
>
> With your clear explanations I think I can come up with an
> implementation that takes all these factors into account, offering
> access to a great deal of the available functionality. Should not be
> too difficult now that we have had this discussion, and I'd be happy
> to do so. But before I do that, a question popped up into my mind: is
> this complexity really worth it?

Depends, with per-SoC callbacks we should be safe for every possible
requirement. With DT, the user always will have the option to add/remove
clocks passed by clocks/clock-names matching his requirements.

> For OLPC, we only ever use LCD1 with divider 2 for our panel, which
> only has 1 resolution. I think we use the fast AXI clock for HDMI
> path, which has a separate SCLK register. For armada 510, it looks
> like you are quite happy with the EXT1 clock, and you mentioned that
> on the 16x most of the clocks are broken, which might mean there is
> again just one clock of preference?

As soon as you are required to use EDID provided modes, you will have
to provide the exact clock rate. With broken fractional divider on Dove
above, you are stuck to integer division. And none of the internal
frequencies give you multiple of 74.25MHz which is what you want for TV
applications. So for Dove, you almost always want to use extclk, if
connected to an external pll.

> So, could we just specify per-CRTC clock preference in platform data,
> DT, or something like that? e.g. we could just specify which SCLK bits
> to set and clear, and which Linux-level struct clk is engaged as a
> result. It adds a little burden for the platform implementor, but it
> would avoid all of the complications that you have mentioned. Or do
> you have a preference for the added flexibility?

I suggest not to do any sophisticated approach to determine the "best"
clock. Just set the SCLK source determined by the name of first clock
passed either by DT or platform_data. This gives everybody the
flexibility but keeps implementation overhead small.

Sebastian
