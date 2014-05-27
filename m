From: olof@lixom.net (Olof Johansson)
Date: Tue, 27 May 2014 10:02:30 -0700
Subject: [PATCH 2/2] ARM: dts: mvebu: split SolidRun CuBox into variants
In-Reply-To: <5384BDB1.6000107@gmail.com>
References: <1401140009-31505-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1401140009-31505-2-git-send-email-sebastian.hesselbarth@gmail.com>
 <20140527161143.GS8664@titan.lakedaemon.net>
 <5384BDB1.6000107@gmail.com>
Message-ID: <CAOesGMjGAey+Tjj9iyz2CL+H59ssj12wUP8nT=gehF6qYx_OdA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 27, 2014 at 9:30 AM, Sebastian Hesselbarth
<sebastian.hesselbarth@gmail.com> wrote:
> On 05/27/2014 06:11 PM, Jason Cooper wrote:
>>
>> On Mon, May 26, 2014 at 11:33:29PM +0200, Sebastian Hesselbarth wrote:
>>>
>>> As Mainlining effort for SolidRun CuBox has been carried out on the
>>> Engineering Sample, the board DTS was reflecting this. Actually,
>>> SolidRun CuBox comes in three different variants: Engineering Sample
>>> (ES),
>>> production with 1GB RAM (1G), and production with 2GB RAM (2G).
>>>
>>> Therefore, we split the current dove-cubox.dts into a common board
>>> include
>>> and one board dts for each of the above variants.
>>>
>>> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>>> ---
>
> [...]
>
>>> diff --git a/arch/arm/boot/dts/dove-cubox-1g.dts
>>> b/arch/arm/boot/dts/dove-cubox-1g.dts
>>> new file mode 100644
>>> index 000000000000..eebd3f7ca7e6
>>> --- /dev/null
>>> +++ b/arch/arm/boot/dts/dove-cubox-1g.dts
>>> @@ -0,0 +1,17 @@
>>> +/dts-v1/;
>>> +
>>> +#include "dove-cubox.dtsi"
>>> +
>>> +/ {
>>> +       model = "SolidRun CuBox (1G)";
>>> +       compatible = "solidrun,cubox-1g", "solidrun,cubox",
>>> "marvell,dove";
>>> +
>>> +       memory {
>>> +               device_type = "memory";
>>> +               reg = <0x00000000 0x40000000>;
>>> +       };
>>> +
>>> +       chosen {
>>> +               bootargs = "console=ttyS0,115200n8 earlyprintk";
>>> +       };
>>> +};
>>> diff --git a/arch/arm/boot/dts/dove-cubox-2g.dts
>>> b/arch/arm/boot/dts/dove-cubox-2g.dts
>>> new file mode 100644
>>> index 000000000000..513b6a68eba3
>>> --- /dev/null
>>> +++ b/arch/arm/boot/dts/dove-cubox-2g.dts
>>> @@ -0,0 +1,17 @@
>>> +/dts-v1/;
>>> +
>>> +#include "dove-cubox.dtsi"
>>> +
>>> +/ {
>>> +       model = "SolidRun CuBox (2G)";
>>> +       compatible = "solidrun,cubox-2g", "solidrun,cubox",
>>> "marvell,dove";
>>> +
>>> +       memory {
>>> +               device_type = "memory";
>>> +               reg = <0x00000000 0x80000000>;
>>
>>
>> Do you anticipate any other differences between the 1G and the 2G?
>> Otherwise, I'm inclined to just have a "solidrun,cubox".  The bootloader
>> should be setting the amount of RAM at boottime anyway.
>
>
> No, there is no known difference between 1G and 2G except doubled RAM.
> I'll squash the two back into a single non-ES dts.
>
> About the board specific compatibles, I am not so sure if we should
> keep them at all. "solidrun,cubox" for all three variants should be
> enough. checkpatch is already choking on every unknown compatible it
> sees and documenting each individual board clearly doesn't scale well.

Yeah, I agree -- but I'd say the scaling problem is with checkpatch.
It's silly to require every single small board variant to be
documented, especially in cases where the dts is self-documenting such
as this. If anything, there should be a script that can be used to
scrape this info and build the docs from compat+model info.

It's not a bad idea to add a more specific compatible. if you think
you want a separate model string, then you should probably have a
separate compatible (but keep lower-order ones so that there's no
difference from the kernel point of view which will just match the
more generic one).


-Olof
