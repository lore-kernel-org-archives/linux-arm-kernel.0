From: matt@genesi-usa.com (Matt Sealey)
Date: Fri, 5 Apr 2013 20:33:36 -0500
Subject: [RFC PATCH] CLK: Allow parent clock and rate to be configured in
 DT.
In-Reply-To: <CAKGA1bkWLrOs15ni=8D__BvuG6kvqkeeLZGOLrVZY9g0q0z4Bg@mail.gmail.com>
References: <20130319170933.28337.50448.stgit@localhost>
 <20130325101707.GZ1906@pengutronix.de>
 <CAOMZO5ASkvquyzPCEGObvB5Xh9bDPTJ2zx26eOUJT_Vb36Bn3Q@mail.gmail.com>
 <CAKGA1bkWLrOs15ni=8D__BvuG6kvqkeeLZGOLrVZY9g0q0z4Bg@mail.gmail.com>
Message-ID: <CAKGA1bntow29MwxBFWNKiP8HwMEQkPVL+KeW6=m0Ee0pfPTFeg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Okay now I have finished my criticism, I will make some productive
suggestions :)

How about we implement a system as follows; modify the clock framework
and bindings such that we not only describe all the parents possible
for a clock, we also enter into the device tree the current parent? I
actually didn't fully realise it until now, but that just isn't in
there (it's derived from the list in the parents property and the
current hardware setting!).

That way, at least on clock initialization it will be able to warn
that the parent in the device tree is not the one in hardware, and -
with suitable options or by default - warn that it is setting the
parent to the one in the device tree. That solves the "which parent I
want" problem without involving ACTUAL configuration, and meets
Sascha's requirement that it is not done by a back door of
configuration items. So to summarize, the process is

* Device tree describes all parents of a clock in parents property
* Device tree describes which parent is the "current" parent
* Linux parses the tree and registers the clock - checks if the parent
in HW is the same as the one in DT
 - if it is not the same, print a horrific warning to the kernel log
 - if we desire to (and it should be possible to make this a debug
option for clock subsystem) set the parent to the one in the DT (also
printing a horrific warning that it has done so)

To solve the issue of "setting clocks to fixed rates", I would suggest
we do it by way of a similar system to the cpu frequency drivers or
regulators, and use operating points or ranges. For a good chunk of
devices, actual clock gating, rate changing and power management are
possible and highly useful in myriad different ways depending on the
device. In this way, an audio codec may end up with a list of
"operating-points" in a node which describes all the valid clock
rates. For example the SGTL5000 can accept many input clocks, the
CS42L52 audio codec can also accept many input clock rates - and the
audio frequency support is determined by those clock rates. For the
latter example, this huge table;

http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/sound/soc/codecs/cs42l52.c#n690

.. is a move-to-device-tree candidate. The driver could pick a
suitable operating point from a range (which it could determine by the
rates the clock phandle supports), and you can even "suggest" one the
same way we do for regulators - only supply a single value. That way,
everything looks like it is being done on the basis of power
management, WOULD be used as power management on a vast chunk of
devices, and can be "restricted" to only work for specific values on
systems which didn't have the dynamism of others (for instance the
MC13892 PMIC has many regulators with wide ranges of voltages, but on
most systems they are tied to specific, fixed voltage rails so giving
a range makes no sense, and there's no real driver that can take
responsibility for setting them. But some use cases may tie the same
regulator output to a dynamic voltage rail, so you can't get away with
just being fixed or just being totally rangey)

How does that sound (audio codec pun not entirely intentional..)?
Matt Sealey <matt@genesi-usa.com>
Product Development Analyst, Genesi USA, Inc.


On Fri, Apr 5, 2013 at 8:07 PM, Matt Sealey <matt@genesi-usa.com> wrote:
> On Thu, Apr 4, 2013 at 6:08 PM, Fabio Estevam <festevam@gmail.com> wrote:
>>
>> This could be useful for removing the imx6q_sabrelite_cko1_setup()
>> function from arch/arm/mach-imx/mach-imx6q.c.
>>
>> I would like to add audio support for another board and would like to
>> avoid to do the same as imx6q_sabrelite_cko1_setup()  for setting up
>> the CLKO, if possible.
>
> You know, we have the same problem on one of our designs here (CLKO is
> used on MX53 for audio codec and camera device, shared) - the current
> solution is hack it into platform support in a BSP kernel.
>
> If we move to device tree, we know and you know the solution already;
> all this clock setup HAS to be done in the bootloader.
>
> The device tree really, really is only a way to describe the
> configuration as it exists or to describe alternatives - for instance,
> a clock with 10 parents may be described as having 10 parents, and the
> binding (in complicated cases) or driver (if it is simple as a value
> from 0 to 7 and the field width is 3 bits for example) will determine
> how that alternative can be selected (and by consequence, what the
> current setting is).
>
> The device tree concept is NOT a place to dump configuration items for
> your board as hardcoded values to try and force something you could
> have done elsewhere. On i.MX53 you cannot boot a kernel verbatim - you
> at least have to run through the Boot ROM and supply a DCD table or
> plugins first. This is where you figure things like this out.
>
> In a case where you have, say, an audio codec and it has a dynamic
> input clock that you want to change on the fly, first of all you would
> not hardcode a frequency into a device tree, second of all there is
> nothing stopping you from doing that right now anyway. If the clock is
> static and fixed frequency and can only be turned on and off, there
> are clock bindings for this already. If it is static and can never be
> turned off, then there are clock bindings for this too, and in this
> case the proviso is that the clock is ALREADY turned on and ALREADY
> stable before you enter the kernel otherwise the description is by
> it's very definition invalid.
>
> If the clock frequency in hardware is not what you wanted when the
> driver comes up, and you only have an on/off switch, it is not up to
> the device tree binding to describe how to go about configuring the
> system to make sure. You cannot in good conscience put a clock
> frequency "to be set later" in the device tree along with a clock
> phandle, simply because that means the device tree no longer describes
> the hardware accurately - the clock phandle is a valid clock, the
> hardware will tell you a frequency from registers in the clock driver,
> the device tree will disagree. How do you know which one is the
> correct value, or if the frequency in the tree is a suggestion rather
> than a description?
>
> I am totally against this (sorry Sascha..). Let's put some effort into
> fixing the bootloaders rather than trying to use the device tree to
> enforce the ridiculous assumption that "Linux kernel does not trust
> the bootloader". Once the bindings and trees are out of the kernel
> source, you're going to HAVE to trust what the bootloader passes, be
> it pregenerated compiled blob (which needs to be written to match the
> hardware state the bootloader finishes up at) or dynamically generated
> at runtime during the boot process (which can describe to the bit what
> the hardware is doing). If you are testing this on Beagle XM you can
> fix your U-Boot easily. New boards will have to be designed *with the
> idea of device trees and working configurations in mind* - that is a
> fact of life, in fact this is how it should be in reality these days
> anyway (most HW designers will do initial bringup of the board - at
> least a minimal working configuration, in a restricted environment
> where they can use test pads to measure clocks, voltage outputs and
> levels of devices to ensure both production was successful and that
> the design is in itself electrically sound. This code 99% of the time
> ends up in the bootloader... sometimes not, when the board was
> designed by one group and the software written by the community, but
> in this case the community needs to learn board bringup and proper
> behavior...)
>
> --
> Matt Sealey <matt@genesi-usa.com>
> Product Development Analyst, Genesi USA, Inc.
