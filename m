From: andre.przywara@arm.com (Andre Przywara)
Date: Tue, 5 Jan 2016 12:05:36 +0000
Subject: [linux-sunxi] reason for Allwinner SoC specific pinctrl drivers?
In-Reply-To: <CAOMqctQL3nmWECpQgtVdxgzEfn2obu4cdj67W1ESONO=5EpQdQ@mail.gmail.com>
References: <568A514D.7070102@arm.com>
 <CAEzqOZu8wkPKLp6bZZ7JuiM07ixDksdD=U-WK=3kFPYJZMon4Q@mail.gmail.com>
 <CAOMqctQL3nmWECpQgtVdxgzEfn2obu4cdj67W1ESONO=5EpQdQ@mail.gmail.com>
Message-ID: <568BB190.1080006@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michal,

thanks for your input!

On 04/01/16 21:36, Michal Suchanek wrote:
> Hello,
> 
> On 4 January 2016 at 18:27, Vishnu Patekar <vishnupatekar0510@gmail.com> wrote:
>> Hello Andre,
>> This is something we can do for future SOCs.
>>
>> On 4 Jan 2016 19:02, "Andre Przywara" <andre.przywara@arm.com> wrote:
>>>
>>> Hi,
>>>
>>> while looking at the Allwinner A64 SoC support, I was wondering why we
>>> would actually need a pinctrl driver (file) for each and every Allwinner
>>> SoC that we support.
>>> Looking at both the A20 and the A64 doc I don't see any differences in
>>> the port controller implementation apart from the actual
>>> muxval <-> subsystem assignment, which is just data, right?
>>> Comparing the code files in drivers/pinctrl/sunxi seems to support this,
>>> as those drivers only consist of the table and some boilerplate code.
>>>
>>> Now I was wondering whether we could get away with one generic Allwinner
>>> pinctrl driver and put the SoC specific pin assignments in DT instead.
>>> It looks like adding an "allwinner,muxval" property in addition to the
>>> existing "allwinner,function" in the SoC's .dtsi would give us all the
>>> information we need. This could look like:
>>>
>>>         uart0_pins_a: uart0 at 0 {
>>>                 allwinner,pins =   "PB22", "PB23";
>>> +               allwinner,muxval = <0x02    0x02>;
>>>                 allwinner,function = "uart0";
> 
> As I understand it
> 
> 1) uart0 is basically a mnemonic for muxval 2

Not really. At the moment uart0 is used to lookup the (hard-coded) table
entry for pins PB22 and PB23, which returns the said value of 0x02 (in
this example, cf. line 246 in pinctrl-sun7i-a20.c).
But if there are other pins where UART0 can be muxed too, there is
another node describing them (cf. uart3_pins_a and uart3_pins_b in
sun7i-a20.dtsi). This one uses the "uart0" name as well, but the muxval
returned for _those pins_ can be different. So the string only makes
sense in connection with a certain pin.

> 2) if you try to mux uart0 on pins for which it is not in the table it fails

How would you mux them if they are not in the table?

> So it makes no sense to have both function and muxval - this is redundant.

Kind of, but not if we want to keep compatibility with older and newer
DTs and older and newer kernels (drivers, really) - which is my goal.
So we just _add_ the muxval values. The existing chip-specific drivers
would naturally ignore the values and just use their built-in table for
lookup. The generic driver on the other hand would use the DT
information. An appropriate compatible string could then be added to
refer to the generic driver as a fallback.
For (future) SoCs (which would not have a specific driver) we could omit
the function string (if this isn't needed elsewhere, I have to check).
So I don't see how the redundancy would be an issue here.

> And it does not make sense to move from function to muxval - it's like
> moving from assembly programing to raw machine code programming.

But it removes the requirement of relying on the built-in lookup table.
So by using a more readable uart0 "mnemonic" we rely on some hardcoded,
chip specific table in each kernel, which is just wrong IMHO. Other DT
users (be it Xen or *BSD, for instance) would have to replicate this
table and since it's really SoC specific, it does not make any sense to
me to keep it separate. After all this DT node is SoC specific as well,
so I don't see the point of abstracting this with some string lookup.

So to stay with your comparison: Yes, we move from assembly to machine
code, but we get rid of the need for a SoC specific assembler, which is
maintained separately.

> For compatibility it's not possible to move the table to the shared
> SoC DT

Why is that? We have the actual pin tables in the shared SoC DT, each
board specific DT just refers to the actually connected pins by
reference. That wouldn't change at all. So the above example for
instance is from sun7i-a20.dtsi, board specific .dts files just use:
pinctrl-0 = <&uart0_pins_a>;

> although it would be possible to have the pin tables in DT.
> However, it would inflate the DT and make working in u-boot (SPL)
> where full DT parser is not available problematic.

I don't get this. Having the actual values instead of a string lookup
would make it actually easier to lookup for more light-weight kernels.

> What might be possible is merging the different pinmux drivers in one.
> Instead of replicating some pinmux boilerplate you will probably end
> up with lots of ifdefs so only tables for SoC support compiled in the
> kernel are built into the driver.

That doesn't sound to tempting to me.

> I am not sure how large the tables are and if anybody should care but
> you might be also missing some symbols for them.

So I guess I just failed to express my approach properly.
I will try to code a proof of concept this week and convert once SoC
over to the new driver, maybe this clears things up.

If I have a blatant misunderstanding of the concepts (quite possible),
please keep correcting me!

Thanks!
Andre.
