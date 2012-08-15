From: dong.aisheng@linaro.org (Dong Aisheng)
Date: Wed, 15 Aug 2012 11:59:18 +0800
Subject: [PATCH] pinctrl: imx5: start numbering pad from 0
In-Reply-To: <CAKGA1bmHqyDGyvZjEcQ+RO1jHiZNZKNu3BGkyUXzYfwVaySYEQ@mail.gmail.com>
References: <1344869278-27334-1-git-send-email-shawn.guo@linaro.org>
 <CAKGA1b=DqyZvSre3C4YQ3GM6RuFtFsGWDkF784iKggrNzwiKpg@mail.gmail.com>
 <CAP1dx+zQvBurT9oCmfJ0dGHHV3rbgdy+0Yh_hoPL9jQB8QNxKw@mail.gmail.com>
 <CAKGA1bmHqyDGyvZjEcQ+RO1jHiZNZKNu3BGkyUXzYfwVaySYEQ@mail.gmail.com>
Message-ID: <CAP1dx+x0_j_f3Pj+9+YHcwoTqjGLXouf7t+SoCCMVGKJNOHCPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 August 2012 03:37, Matt Sealey <matt@genesi-usa.com> wrote:
> On Tue, Aug 14, 2012 at 2:20 AM, Dong Aisheng <dong.aisheng@linaro.org> wrote:
>> On 13 August 2012 23:12, Matt Sealey <matt@genesi-usa.com> wrote:
>>> I have a minor nit; while renumbering the pinctrl definitions is
>>> laudable and device trees can match, there are 16 other pin controls
>>> below EIM_D16 - this makes the start of the IOMUXC pin definitions
>>> actually be the value calculated by (iomuxc_base + 0x300 + (4*16) +
>>> (pin_id*4)).
>>
>> What do you mean of this value calculated?
>
> Well, it just seems the datasheet has been read from the point of view
> of the SW_CTRL settings (pad pullups, drive strength etc.) to define
> the enums; every pin setting in order from IOMUXC_BASE + 0x3f0 (sorry
> I mistyped) has been entered as an enum into this list. Then a table
> has been generated using these enums to supply a pin id. Then this pin
> id is not relevant anymore; it actually gets referenced by it's
> *offset into the table*.
>
Not exactly, probably.
Basically we follow the mux reigster offset to define pin id, however,
there're also some pads may not have mux function but only config
which also has a pin id
and vice versa.
Those pins are not ordered by it's mux regsiter offset.

Actually I did not manually search all those pins, instead, i just
using the exist ones:
arch/arm/plat-mxc/include/mach/iomux-mx51.h
Since this exist headfile already covers this case.

> In this case, basically the code misses a few pins which have ALT
> settings but perhaps not always the ability to change pad control -
> EIM_DA5 to 15 are a good example.
>
As i said, we already defined those pin ids.

> Probably better would be to define the binding almost exactly as it
> was done in the old method; iomux_v3_cfg_t took into account the three
> register offsets possible for the pin (SW_MUX_CTL, SW_PAD_CTL and IPP)
> and the three values to be put into those registers.
>
> This has been reduced down in pinctrl to what I find quite strange,
> which is a completely arbitrary pin "id" mapping, which indirectly
> references an entry in a table by index which is why pin 1 as a start
> looks odd.
>
Start with pin 1 is a bug which caused by my mistake during the early
data conversion.

> If the binding is entirely i.MX-specific or even i.MX51-specific then
> why not define the pins in the device tree the "old" iomux_v3_cfg_t
> way, which is the way they are in the table of imx_pin_regs;
>
>       IMX_PIN_REG(MX51_PAD_EIM_D16, 0x3f0, 0x05c, 5, 0x000, 0), /*
> MX51_PAD_EIM_D16__AUD4_RXFS */
>
> 0x3f0 is the SW_PAD_CTL, 0x05c is the SW_MUX_CTL, 5 is the ALT mode,
> 0x000 is the IPP reg, and 0 the IPP value.
>
> So fsl,iomux-pins = <0x3f0 0x85 0x05c 5 0 0 ... > (PAD, settings, MUX,
> mode/sion, IPP, select - in that order) would be a valid pin
> definition and require no table. Sure, the offsets are device specific
> but then the arbitrary numbering is too.
> This way old iomux controls
> can be re-derived for people who use the old method in old kernels, or
> use U-Boot with iomux-v3.h taken from Linux (MX6 got ported, I am
> porting the Efika to it on MX5 for U-Boot right now). Also that huge
> table goes away - it can be built at runtime, along with the
> PAD_NAME__ALT_MODE_NAME description.
>
I can't agree this is better than the exist one now.
It's hard to use in device tree.
And how would you parse the pin id from this data array?

If really in that way, i feel like it's pure register write and does not require
any subsystem or driver.

> It would also remove any arbitrary indexes, and allow lookup based on
> an actual documented value (which is listed at the top of every page
> of Appendix A register definitions), cross-referencing with the manual
> on the actual register settings etc.  It is certainly less confusing
> than <0 0x17058> or so, which says nothing without a comment, and the
> value listed is entirely arbitrary encoding of the PAD_CTL values.
>
> For a different way of explaining and another example of what is
> wrong, in the current binding doc for example;
>
>         1386 0x17059    /* MX6Q_PAD_SD4_CMD__USDHC4_CMD */
>
> 1386 is a pin index, correct? But it's a pin index into the
No, like every device else, you should refer to the binding doc for the detailed
binding details rather than assuming ourselves.

> imx_pin_regs array. It has no relation to the enums at the top of
> pinctrl-imx6q.c, which is only used to refer to the pin_desc
> structure.
>
>         IMX_PIN_REG(MX6Q_PAD_SD4_CMD, 0x06DC, 0x02F4, 0, 0x0000, 0),
> /* MX6Q_PAD_SD4_CMD__USDHC4_CMD */
>
> So the enums at the top of the file don't even define the pin number.
> You have to COUNT inside this file, or look at the binding which
> someone has written by doing the counting by hand or script.
They're different things.
The enum imx51_pads is the pin id definitions.
The 'MX6Q_PAD_SD4_CMD__USDHC4_CMD' is the pin func id definition.
See binding doc: fsl,mxs-pinctrl.txt

> Change
> the array, change the binding. This is terrible, terrible design.
No, the binding is driver independant.
The array you said here is implementation and should not affect binding.

> There should be one point of reference, and if possible, the binding
> should be totally obvious without cross-reference.
I agree.
Can you point out the exist one?

>
> The docs then say 0x17059 defines the pin control settings (hysteresis
> etc.) - MUX_MODE (ALT) is inferred from this database inside the
> kernel.
>
> If you need to add more items in the list (for instance if MX7 gains
> an extra set of configuration registers for each pin), this is what
> #size-cells property is for in the device tree, or better yet why not
> walk the tree to find the machine compatible?
>
>> What trouble do you mean?
>> Those pins, EIM_DA*, are already defined but just on a different pin id.
>> Can't user use it in this way?
>
> Yuck.
>
>>> Therefore I propose;
>>>
>>> * add MX51_PAD_EIM_DA0 through DA15 as index 0-15 (same for any
>>> differences in other i.MX etc.)
>> Hmm, as i said above, those pins are already defined.
>> See:
>>         MX51_PAD_SD1_DATA0 = 209,
>>         MX51_PAD_EIM_DA0 = 210,
>>         MX51_PAD_EIM_DA1 = 211,
>>         MX51_PAD_EIM_DA2 = 212,
>>         MX51_PAD_EIM_DA3 = 213,
>
> Where are 4 through 15?
>
b29396 at shlinux2:~/upstream/linux-2.6-linus-imx$ grep -rn
MX51_PAD_EIM_DA drivers/pinctrl/pinctrl-imx51.c
235:    MX51_PAD_EIM_DA0 = 210,
236:    MX51_PAD_EIM_DA1 = 211,
237:    MX51_PAD_EIM_DA2 = 212,
238:    MX51_PAD_EIM_DA3 = 213,
240:    MX51_PAD_EIM_DA4 = 215,
241:    MX51_PAD_EIM_DA5 = 216,
242:    MX51_PAD_EIM_DA6 = 217,
243:    MX51_PAD_EIM_DA7 = 218,
245:    MX51_PAD_EIM_DA10 = 220,
246:    MX51_PAD_EIM_DA11 = 221,
247:    MX51_PAD_EIM_DA8 = 222,
248:    MX51_PAD_EIM_DA9 = 223,
252:    MX51_PAD_EIM_DA12 = 227,
253:    MX51_PAD_EIM_DA13 = 228,
254:    MX51_PAD_EIM_DA14 = 229,
255:    MX51_PAD_EIM_DA15 = 230,

>> I did not quite understand, remove other pin ids up by 16? why?
>
> See above.
>
>> Why we may want to change the definitions again?
>
> If you got ANYTHING at all wrong. Shawn already sent a patch to change
> a definition. What if the order in the table changes? Where is the
> note above the table that says the order of the table is tied directly
> to the binding and no order changes or inserts-in-the-middle should be
> made?
>
I think the binding imx pinctrl used is not pin id dependent since it
only tells the
pin func id(which hw pin used in which function, pin id is linux abstract),
how to define the pin id or how to parse the pin id from pin func id
is driver specific.
That means you can define pin id in a arbitrary number as you want.
Anyway, i could double check it later.

>> Since we already have those pins EIM_DA* defined, it looks to me user could use
>
> No.. because there are 12 pins missing. I don't know how many others
> might be missing,
Can you point out the exact missing pins you found?

> but the implementation as a whole is too arbitrary
> and too abstract. You do not need to implement indirection in the
> device tree.
>
I just chose a better way to use.
Current i did not see any big issue, anyway, i will think a bit more according
to your comments.

Regards
Dong Aisheng
