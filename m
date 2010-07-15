From: viresh.kumar@st.com (Viresh KUMAR)
Date: Thu, 15 Jul 2010 11:32:19 +0530
Subject: [PATCH v4] GPIO PL061: Adding Clk framework support
In-Reply-To: <20100713182644.GC30142@n2100.arm.linux.org.uk>
References: <1277183247-4557-1-git-send-email-viresh.kumar@st.com>	<20100709124050.GF22845@n2100.arm.linux.org.uk>	<AANLkTikm-wupuQA1_zsmqf3jrpavkMaw8Bt-GWb04TSo@mail.gmail.com>	<20100710071913.GM22845@n2100.arm.linux.org.uk>	<AANLkTimskXW4Nnxhc5bxwKiNrfJkMb-9NeWKhVOGaA1k@mail.gmail.com>	<20100713074449.GA20118@n2100.arm.linux.org.uk>	<AANLkTilZJTHh_iFS37UL7XoUs_DhAB50A3tHfcfEr5JM@mail.gmail.com>
	<20100713182644.GC30142@n2100.arm.linux.org.uk>
Message-ID: <4C3EA46B.1000709@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/13/2010 11:56 PM, Russell King - ARM Linux wrote:
> On Tue, Jul 13, 2010 at 01:00:51PM +0200, Linus Walleij wrote:
>> Since that works, it means that we can likely insert
>> amba_bus_clk_[disable|enable] at the same sites that we have
>> this in the current code for the external clocks at the same time,
>> atleast for pl011, pl022 and pl180.
> 
> Almost - but there's a few corner cases.  Basically, what I think you'll
> need for pl011 is:
> 1. add an amba_bus_clk_disable() at the end of the successful probe
>    function
> 2. add amba_bus_clk_enable() at the beginning of the remove function.
> 3. add amba_bus_clk_enable()/amba_bus_clk_disable() around each of the
>    suspend(), resume(), pl011_console_write(), and
>    pl011_console_get_options() functions.
> 4. amba_bus_clk_enable() at the start of the startup method.
> 5. amba_bus_clk_disable() at the end of the shutdown method.
> 
> Most of these do tie up with existing clk_enable()s, but there are some
> additional places you'd need to enable the pclk because of register
> accesses.
> 

Russell,

These cases particularly in our architecture where functional and
interface clock are tied together (through same gating option) would
produce difficult scenarios (as already mentioned by you) and which
would be difficult and not so clean to handle.

For example just looking at driver src which disables bus clock (without
enabling it) in different scenarios would not be very readable.
Further that would vary from architecture to architecture (even for
standard drivers).

>> > For drivers that need to conserve power, also the block
>> > clock has to be gated when the device is not in use,
>> > sometimes since that affects some hardware that keep
>> > track of the usecount of the clock tree for a larger region of
>> > silicon, so the power savings can be drastic.
> You can't have the core code doing that.  If you unconditionally turn
> the bus clock off after probe, what happens when a driver receives an
> interrupt and tries to access its registers?
> 
> Hint: the core code can't know that the driver has registered an IRQ
> handler.

We haven't seen this kind of issues in our devices, SPEAr as well as
U300 (as we have both clocks controlled by same bit). Normally, when device
is not in use then interrupts are disabled. When device is used then interrupts
and clock are enabled and clocks are not disabled till the time work is
finished. So, this condition might not occur that you have landed in interrupt
handler with clocks off.

IMO, Clocks enabling is required at following places:
1. During device add where we need to read id registers.
- We can do this by simple enabling/disabling "apb_bus" clk before and
  after reading registers.
2. In driver, when device is used.
- This can be handled best by the driver itself. We don't require to
  enable interface clock from amba_probe for ever.


One way to do this cleanly is:
- Add clock structures for devices with connection id "apb_bus".
  (Platforms can have 2 different structures if they have different
controlling bits otherwise single structure will solve the purpose.)
- amba_device_register can simple get this clk and use it.
- Drivers need to enable/disable both interface and functional clock to
save maximum power.



regards,
viresh kumar.
