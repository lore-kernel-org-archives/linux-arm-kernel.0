From: matt@genesi-usa.com (Matt Sealey)
Date: Wed, 15 Aug 2012 11:49:01 -0500
Subject: [PATCH] pinctrl: imx5: start numbering pad from 0
In-Reply-To: <20120815153107.GG2258@S2101-09.ap.freescale.net>
References: <1344869278-27334-1-git-send-email-shawn.guo@linaro.org>
 <CAKGA1b=DqyZvSre3C4YQ3GM6RuFtFsGWDkF784iKggrNzwiKpg@mail.gmail.com>
 <CAP1dx+zQvBurT9oCmfJ0dGHHV3rbgdy+0Yh_hoPL9jQB8QNxKw@mail.gmail.com>
 <CAKGA1bmHqyDGyvZjEcQ+RO1jHiZNZKNu3BGkyUXzYfwVaySYEQ@mail.gmail.com>
 <CAP1dx+x0_j_f3Pj+9+YHcwoTqjGLXouf7t+SoCCMVGKJNOHCPw@mail.gmail.com>
 <20120815054436.GK2232@pengutronix.de>
 <20120815065526.GG19681@shlinux2.ap.freescale.net>
 <20120815075117.GL2232@pengutronix.de>
 <20120815092539.GH19681@shlinux2.ap.freescale.net>
 <20120815135947.GC2258@S2101-09.ap.freescale.net>
 <20120815153107.GG2258@S2101-09.ap.freescale.net>
Message-ID: <CAKGA1bkNEJbQgwcdZs8PozCgVyOfUE=bDCGkRkKV3VMfbvRMgw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 15, 2012 at 10:31 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Wed, Aug 15, 2012 at 09:59:50PM +0800, Shawn Guo wrote:
>> On Wed, Aug 15, 2012 at 05:25:40PM +0800, Dong Aisheng wrote:
>> > On Wed, Aug 15, 2012 at 03:51:17PM +0800, Uwe Kleine-K?nig wrote:
>> > Hmm, not sure if dt macro may support this kind of syntax but yes if it supports.
>> > Grant,
>> >
>> > Do you know if dt macro can support it?
>>
>> I have the same doubt there.  Copied Stephen who might have a better
>> insight on this.
>>
> Rather than betting how DTC will implement macro, we'd better make the
> the safest assumption - it will not support that syntax.

It won't. DT is defined by properties and those properties have cells.
Properties
that have more than one cell or multiple definitions in them have to have a
#size-cells property to go with it somehow.

I don't see what the problem would be here; you want to define pin properties,
sure, they are intrinsically defined by 3 possible registers and value pairs. In
actual fact if you drill down to this, what happens is you get a pin property
which defines offsets into the unit, and values to stuff into those
registers, so
you could either dictate a size-cell of 6 (3 pairs of reg-value) or 2
(reg, value).
It would be more convenient for a driver to know what those pairs are maybe,
so 6 is better.

> still work our issue, I guess.  Actually, the goal is all about
> encoding the data that is currently defined in driver as a big array of
> struct imx_pin_reg in device tree.

Absolutely!

> struct imx_pin_reg {
>         u16 pid;
>         u16 mux_reg;
>         u16 conf_reg;
>         u8 mux_mode;
>         u16 input_reg;
>         u8 input_val;
> };
>
> As we will figure out the pid from the mux_reg and conf_reg as below,
> it becomes how we encode other fields.  An u64 can just cover them.

Or 3 pairs of values can encode them. Don't needlessly encode data in
the device tree that can just exist in a cell of a property.

> That said, the line below in binding doc
>
>   MX35_PAD_COMPARE__SDMA_EXTDMA_2 11
>
> becomes
>
>   MX35_PAD_COMPARE__SDMA_EXTDMA_2 0x032c000807000000

I can only give a quick example on MX51, MX53 or MX6 since that's my
experience, but essentially.. you're overthinking it.

What it becomes is

iomuxc at 0x73f08000 {
  fsl,iomux-pins = <mux value ctrl value ipp value
/* MX53_PIN_SD4_CMD__SD4_CMD */
                            mux value ctrl value ipp value
       /* etc. */
                            ...>;

You can encode those values *in the driver* as a hash or lookup to get
names for them if you like in the driver.. or build them at runtime
for truly odd combinations or not-usual pin configurations. In any
case, those reg can be "valid" 0 since 0 is IOMUXC_GPR0.. which you do
not want to set. That said, setting IOMUXC_GPR can be useful! Ethernet
may need (on MX6 examples) ENET_CLK_SEL set, IPU may need to select
MIPI gasket or IOMUX. Usually though I would assume that you would
have properties for these though as you do not want to "trash"
bootloader configuration of any clock or mux settings, just update
them (so, fsl,ethernet-clock-sel =1 or fsl,ipu-iomux = <1 0>)

That said, the usual thing is to set them to "-1" explicitly in the
tree and let the DT code sort out what -1 actually means (usually
0xffffffff since by default OF cells are 32-bit, but it's the same
difference if it's a 64-bit device tree binding) since this is totally
invalid. That way a pin with no ctrl or ipp, or ctrl but no ipp or mux
would be

fsl,iomux-pin = <-1 -1 0x05c 0x85 -1 -1
                        ...>;

> We should probably have it be mux_reg + mux_mode + conf_reg +
> input_reg + input_val or something to have the offset and value coupled.
> Anyway, we will still have fsl,pins formatted as <PIN_FUNC_ID CONFIG>,
> and only difference is PIN_FUNC_ID becomes an u64 integer.  But it can
> save us that big array from the driver.

As above. Please do not encode the data. Don't assume you can encode a
64-bit integer either.. that's not in any core binding. What you need
here is a multi-cell property as above. That  way it can be expanded
if MX7 has an extra iomux register set for something else ("enable
awesome mode" or so).

>> The question comes to how PIN_NO_MUX_ID_BASE gets determined?
>>
> So PIN_NO_MUX_ID_BASE will be: the largest mux_reg_offset / 4 + 1, right?

Nope. It should be -1. Do it properly, please. Do not "hack" numbers,
as this can mean the driver has to intimately know the hardware when
it is needless to do so. The driver MAY however  assume that
IOMUXC_BASE_ADDR + 0xffffffff is not really possible - check the
offset generated and if it goes beyond the reg = <start length> range,
it is obviously invalid. Or just check the offset against the length..
walking into unmapped memory invalid is invalid across the board.

One thing though, I don't understand why Dong thinks it would be more
difficult to look up a register number in the docs (PDF search, Dong,
it's easy!) versus looking up the binding number in the binding
document. These pairs are ALREADY encoded in older kernels too in that
64 bit integer. Just split them back out again (there's code in
iomux-v3.h to do this still in the kernel) and you can encode your
device tree. Including headers, macros is unecessary. You may want to
petition Freescale to create a plugin for their IOMUX tool though that
not only spits out the reg/pair values in C source format (this is
very useful, though, since you can paste it into anything that can use
writel() to set up all pins exactly as your board designer dictated),
but also does it in device-tree binding pairs as above. That would
make it a lot easier all round, too.. nobody needs to look up a
binding, the binding is "fsl,iomux-pins defines pairs of offsets and
values inside the IOMUXC unit. These offsets and values are defined in
the manual. <some examples here>"

-- 
Matt Sealey <matt@genesi-usa.com>
Product Development Analyst, Genesi USA, Inc.
