From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sun, 09 Dec 2012 14:54:58 +0100
Subject: [PATCH 1/2] thermal: Add support for thermal sensor for Kirkwood
 SoC
In-Reply-To: <20121208001152.GA14363@n2100.arm.linux.org.uk>
References: <1354922151-3250-1-git-send-email-iwamatsu@nigauri.org>
 <20121208010708.260209f5@skate>
 <20121208001152.GA14363@n2100.arm.linux.org.uk>
Message-ID: <50C49832.7070503@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/08/2012 01:11 AM, Russell King - ARM Linux wrote:
> On Sat, Dec 08, 2012 at 01:07:08AM +0100, Thomas Petazzoni wrote:
>> Hello,
>>
>> On Sat,  8 Dec 2012 08:15:50 +0900, Nobuhiro Iwamatsu wrote:
>>> +static const struct of_device_id kirkwood_thermal_id_table[] = {
>>> +	{ .compatible = "marvel,thermal-kirkwood" },
>>
>> marvel ->  marvell
>>
>> Also, I think it should be marvell,kirkwood-thermal, since most other
>> DT compatible strings that we have for Marvell SoCs are
>> marvell,<soc>-<function>.
>>
>> Also, the Device Tree binding documentation is missing (even though it
>> is admittedly going to be a very short documentation).
>
> Is this in any way compatible with the thermal monitoring found on
> Dove (510) stuff?  If so, should it have the SoC prefix in there,
> or should it be "armada-thermal" for the SoC family?

I haven't checked the driver in detail but at least register offsets
and the register-to-temperature function are different for Dove.
This is no big deal and can be handled with compatible strings.

But more important, "kirkwood" includes 88f618x, 88f619x, and 88f6281
that have no thermal diode - at least it is not mentioned in the public
datasheet. So, finally for Nobuhiro's patch I suggest to have two
compatible strings, one for marvell,88f6282-thermal and one for
marvell,88f6282-thermal. Numbering scheme of Marvell SoCs is a mess..

For the driver, the name should be either orion_thermal.c (as we will
reuse it for Dove), or mvebu_thermal.c if there is also a thermal diode
on Armada 370/XP. Using "armada" alone is not a good idea, as it also
includes some pxa-based SoCs - naming scheme of Marvell SoCs is even
more broken than numbering scheme ;)

Sebastian
