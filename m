From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 5 Mar 2012 09:48:23 +0100
Subject: [PATCH v5 4/4] clk: basic clock hardware types
In-Reply-To: <CAJOA=zNWN6L+-YEkNKoQnjnrrswNpCBmtnhKBm04HekWP46i5w@mail.gmail.com>
References: <1330763341-3437-1-git-send-email-mturquette@linaro.org>
 <1330763341-3437-5-git-send-email-mturquette@linaro.org>
 <20120304174229.GD11546@lunn.ch>
 <CAJOA=zNWN6L+-YEkNKoQnjnrrswNpCBmtnhKBm04HekWP46i5w@mail.gmail.com>
Message-ID: <20120305084823.GD24858@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 04, 2012 at 04:30:08PM -0800, Turquette, Mike wrote:
> On Sun, Mar 4, 2012 at 9:42 AM, Andrew Lunn <andrew@lunn.ch> wrote:
> > On Sat, Mar 03, 2012 at 12:29:01AM -0800, Mike Turquette wrote:
> >> Many platforms support simple gateable clocks, fixed-rate clocks,
> >> adjustable divider clocks and multi-parent multiplexer clocks.
> >>
> >> This patch introduces basic clock types for the above-mentioned hardware
> >> which share some common characteristics.
> >
> > Hi Mike
> >
> > These basic clocks don't allow the use of prepare/unprepare, from the
> > side of the clock provider. I think i need this.
> 
> This is an interesting point and might help us nail down exactly what
> we expect from clk_prepare/clk_unprepare.
> 
> >
> > The Orion Kirkwood SoC has clock gating for most of its on chip
> > peripherals, which the other older Orion devices don't have. The SATA
> > and PCIe also allows the PHY to be shut down, again which older Orion
> > devices don't have. The current code links the clock and the PHY
> > together, shutting both down are the same time. So i would like to
> > perform the PHY shutdown in the unprepare() function of the clk
> > driver.
> 
> Do you feel it is The Right Thing to enable/disable the phy from
> clk_prepare/clk_unprepare?  

Humm, not sure yet. I don't know all the different possibilities,
which is why i tried to describe my use case, rather than just assume
i need prepare/unprepare.

I also realized i did not explain my use case properly. 

At boot, uboot is turning on various clocks and SATA/PCIe PHYs etc, in
order to get the device booted. Linux takes over, and the
Orion/kirkwood board files, ask the kirkwood or generic Orion code to
create platform_data structures for the different devices that the
board uses. The kirkwood code keeps a bitmap of devices for which it
creates platform data for which there is a gated clock. Then in a
lateinit call, it turns on clocks which are needed, and also turns off
clocks which are no longer needed, because the board did not ask for a
driver binding for that device. If it turns off a SATA or PCIe clock,
it also turns off the PHY associated with it.

So we are talking about turning off hardware for which there is no
driver. This seems to exclude pm_runtime_get(_sync), which is about
hardware with drivers.

We touched on this subject a couple of months ago, at least with
respect to clocks. You said that is what the flag CLK_IGNORE_UNUSED
will be used for. In a lateinit call, you plan to iterate over all
clocks and turn off any which don't have CLK_IGNORE_UNUSED and have
not been enabled. I assume you will call both disable() and
unprepare(), and if i've can put code into the unprepare to turn the
PHY off, all is good.

> > Is allowing to pass prepare/unprepare functions to basic clocks
> > something you want to support? If i prepare a patch would you consider
> > it?
> 
> My original instinct was "no".  The simple gate clock was always
> supposed to be "simple" and if you need more than it provides then it
> might be best for your platform to implement a specific clock type.
> Especially since the purpose of clk_prepare is still up in the air.

I think i can wrap your simple gate clock, to make my "complex" gate
clock. What would help is if you would EXPORT_SYMBOL_GPL
clk_gate_enable() and clk_gate_disable(), since they do exactly what i
want. I can then build my own clk_ops structure, with my own
unprepare() function. I would probably use DEFINE_CLK_GATE as is, and
then at run time, before calling __clk_init() overwrite the .ops with
my own version.

However, if others have the need for {un}prepare(), it would be good
to have a generic solution.

   Andrew
