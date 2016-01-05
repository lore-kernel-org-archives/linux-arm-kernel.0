From: hramrach@gmail.com (Michal Suchanek)
Date: Tue, 5 Jan 2016 16:20:04 +0100
Subject: [linux-sunxi] reason for Allwinner SoC specific pinctrl drivers?
In-Reply-To: <568BB190.1080006@arm.com>
References: <568A514D.7070102@arm.com>
 <CAEzqOZu8wkPKLp6bZZ7JuiM07ixDksdD=U-WK=3kFPYJZMon4Q@mail.gmail.com>
 <CAOMqctQL3nmWECpQgtVdxgzEfn2obu4cdj67W1ESONO=5EpQdQ@mail.gmail.com>
 <568BB190.1080006@arm.com>
Message-ID: <CAOMqctQ_GKVt0eyU3DhvvpwajTeea_0+LMqBLfLgNbKpFwc=qg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 January 2016 at 13:05, Andre Przywara <andre.przywara@arm.com> wrote:
> Hi Michal,
>
> thanks for your input!
>
> On 04/01/16 21:36, Michal Suchanek wrote:
>> Hello,
>>
>> On 4 January 2016 at 18:27, Vishnu Patekar <vishnupatekar0510@gmail.com> wrote:
>>> Hello Andre,
>>> This is something we can do for future SOCs.
>>>
>>> On 4 Jan 2016 19:02, "Andre Przywara" <andre.przywara@arm.com> wrote:
>>>>

>>>>
>>>>         uart0_pins_a: uart0 at 0 {
>>>>                 allwinner,pins =   "PB22", "PB23";
>>>> +               allwinner,muxval = <0x02    0x02>;
>>>>                 allwinner,function = "uart0";
>>
>> As I understand it
>>
>> 1) uart0 is basically a mnemonic for muxval 2
>
> Not really. At the moment uart0 is used to lookup the (hard-coded) table
> entry for pins PB22 and PB23, which returns the said value of 0x02 (in
> this example, cf. line 246 in pinctrl-sun7i-a20.c).
> But if there are other pins where UART0 can be muxed too, there is
> another node describing them (cf. uart3_pins_a and uart3_pins_b in
> sun7i-a20.dtsi). This one uses the "uart0" name as well, but the muxval
> returned for _those pins_ can be different. So the string only makes
> sense in connection with a certain pin.
>
>> 2) if you try to mux uart0 on pins for which it is not in the table it fails
>
> How would you mux them if they are not in the table?

You cannot. The muxing fails because you request a function that is
not in the table for that pin - as opposed to muxing some other random
function on the pin silently.

>
>> So it makes no sense to have both function and muxval - this is redundant.
>
> Kind of, but not if we want to keep compatibility with older and newer
> DTs and older and newer kernels (drivers, really) - which is my goal.
> So we just _add_ the muxval values. The existing chip-specific drivers
> would naturally ignore the values and just use their built-in table for
> lookup. The generic driver on the other hand would use the DT
> information. An appropriate compatible string could then be added to
> refer to the generic driver as a fallback.
> For (future) SoCs (which would not have a specific driver) we could omit
> the function string (if this isn't needed elsewhere, I have to check).
> So I don't see how the redundancy would be an issue here.

The function string is needed for the setting to make any sense.

As you have pointed out yourself the function name may resolve to
different muxval for different pins.

You need those SoC pin tables so you know what you multiplexed to
what. They are in the kernel where they IMHO belong. Not having them
at all is a no-go because then you have no idea what functions you
have enabled on the SoC.

What you suggest is adding duplicate lower level information in the DT
so higher level pinmux driver uses symbolic function name and lower
level driver using raw mux number. This means that maintenance
problems increase with these low level and high level pin mux
descriptions potentially going out of sync in the DT.

>
>> And it does not make sense to move from function to muxval - it's like
>> moving from assembly programing to raw machine code programming.
>
> But it removes the requirement of relying on the built-in lookup table.
> So by using a more readable uart0 "mnemonic" we rely on some hardcoded,
> chip specific table in each kernel, which is just wrong IMHO. Other DT
> users (be it Xen or *BSD, for instance) would have to replicate this
> table and since it's really SoC specific, it does not make any sense to
> me to keep it separate. After all this DT node is SoC specific as well,
> so I don't see the point of abstracting this with some string lookup.
>
> So to stay with your comparison: Yes, we move from assembly to machine
> code, but we get rid of the need for a SoC specific assembler, which is
> maintained separately.

We cannot get rid of it. And really, the assembly is the same for all
the SoCs. It's the machine code which isn't and which the assembly
abstracts.

>
>> For compatibility it's not possible to move the table to the shared
>> SoC DT
>
> Why is that? We have the actual pin tables in the shared SoC DT, each
> board specific DT just refers to the actually connected pins by
> reference. That wouldn't change at all. So the above example for
> instance is from sun7i-a20.dtsi, board specific .dts files just use:
> pinctrl-0 = <&uart0_pins_a>;

Except as has been pointed out in DT unused features are not to be
included so you would lose the functions which are included in the
in-kernel tables but are not wired on any supported board.

Also the uart0_pins_a part is just trashed AFAIK so once the kernel
boots you have no idea what pins you got in the driver. So if the low
level pinmux driver were to replace the high level pinmux driver it
would have to parse the pin tables in the DT and reconstruct the
currently hardcoded pin tables from the DT information so that when
you look at the pinmux state later you know what it means without the
in-kernel hardcoded table. Then all pinmux values are technically used
by the pinmux driver to reconstruct the pinmux table and should be
included in the DT.

>
>> although it would be possible to have the pin tables in DT.
>> However, it would inflate the DT and make working in u-boot (SPL)
>> where full DT parser is not available problematic.
>
> I don't get this. Having the actual values instead of a string lookup
> would make it actually easier to lookup for more light-weight kernels.

No. You can just include the pin table in the C code as opposed to
linking in a DT parser as well as requiring heap space to parse the
DT.

well, you can always cut and paste the data from DT to any code you
want, anyway. So long as you do have the data somewhere.

Thanks

Michal
