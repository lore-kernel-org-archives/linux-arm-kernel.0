From: hramrach@gmail.com (Michal Suchanek)
Date: Mon, 4 Jan 2016 22:36:28 +0100
Subject: [linux-sunxi] reason for Allwinner SoC specific pinctrl drivers?
In-Reply-To: <CAEzqOZu8wkPKLp6bZZ7JuiM07ixDksdD=U-WK=3kFPYJZMon4Q@mail.gmail.com>
References: <568A514D.7070102@arm.com>
 <CAEzqOZu8wkPKLp6bZZ7JuiM07ixDksdD=U-WK=3kFPYJZMon4Q@mail.gmail.com>
Message-ID: <CAOMqctQL3nmWECpQgtVdxgzEfn2obu4cdj67W1ESONO=5EpQdQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 4 January 2016 at 18:27, Vishnu Patekar <vishnupatekar0510@gmail.com> wrote:
> Hello Andre,
> This is something we can do for future SOCs.
>
> On 4 Jan 2016 19:02, "Andre Przywara" <andre.przywara@arm.com> wrote:
>>
>> Hi,
>>
>> while looking at the Allwinner A64 SoC support, I was wondering why we
>> would actually need a pinctrl driver (file) for each and every Allwinner
>> SoC that we support.
>> Looking at both the A20 and the A64 doc I don't see any differences in
>> the port controller implementation apart from the actual
>> muxval <-> subsystem assignment, which is just data, right?
>> Comparing the code files in drivers/pinctrl/sunxi seems to support this,
>> as those drivers only consist of the table and some boilerplate code.
>>
>> Now I was wondering whether we could get away with one generic Allwinner
>> pinctrl driver and put the SoC specific pin assignments in DT instead.
>> It looks like adding an "allwinner,muxval" property in addition to the
>> existing "allwinner,function" in the SoC's .dtsi would give us all the
>> information we need. This could look like:
>>
>>         uart0_pins_a: uart0 at 0 {
>>                 allwinner,pins =   "PB22", "PB23";
>> +               allwinner,muxval = <0x02    0x02>;
>>                 allwinner,function = "uart0";

As I understand it

1) uart0 is basically a mnemonic for muxval 2
2) if you try to mux uart0 on pins for which it is not in the table it fails

So it makes no sense to have both function and muxval - this is redundant.

And it does not make sense to move from function to muxval - it's like
moving from assembly programing to raw machine code programming.

For compatibility it's not possible to move the table to the shared
SoC DT although it would be possible to have the pin tables in DT.
However, it would inflate the DT and make working in u-boot (SPL)
where full DT parser is not available problematic.

What might be possible is merging the different pinmux drivers in one.
Instead of replicating some pinmux boilerplate you will probably end
up with lots of ifdefs so only tables for SoC support compiled in the
kernel are built into the driver.
I am not sure how large the tables are and if anybody should care but
you might be also missing some symbols for them.

Thanks

Michal
