From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 19 Nov 2013 12:53:07 -0700
Subject: [RFC PATCH V2 2/2] kbuild: dtbs_install: new make target
In-Reply-To: <20131119185729.GD28859@titan.lakedaemon.net>
References: <eaf050fbd62803784856a4f37d4b332f7778e22c.1384798508.git.jason@lakedaemon.net>
 <528A65DF.8060000@wwwdotorg.org>
 <20131118191955.GG10335@titan.lakedaemon.net>
 <528A6944.3070303@wwwdotorg.org>
 <20131118192852.GI10335@titan.lakedaemon.net>
 <528A6CA3.9030904@wwwdotorg.org>
 <20131118195243.GJ10335@titan.lakedaemon.net>
 <528A98C8.9040803@wwwdotorg.org>
 <20131119122801.GL16735@n2100.arm.linux.org.uk>
 <528BB109.2060201@wwwdotorg.org>
 <20131119185729.GD28859@titan.lakedaemon.net>
Message-ID: <528BC1A3.70202@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/19/2013 11:57 AM, Jason Cooper wrote:
> On Tue, Nov 19, 2013 at 11:42:17AM -0700, Stephen Warren wrote:
>> On 11/19/2013 05:28 AM, Russell King - ARM Linux wrote:
>>> On Mon, Nov 18, 2013 at 03:46:32PM -0700, Stephen Warren wrote:
>>>> Again, the point is not that it's hard to write the script. As you
>>>> demonstrated, it's easy. The problem is that then, everybody has to do
>>>> something different for Tegra, forever. No matter how small the actual
>>>> cost of doing it is, it's still non-scalable to require that everyone
>>>> know about this special case. I'm not convinced the issue would be
>>>> isolated to Tegra either.
>>>
>>> That's why there's the facility to allow an override to the script,
>>> just like there's the facility to override the default script when
>>> running "make install".
>>
>> Again, you are completely missing the point about that not scaling at all.
>>
>> But I will go and investigate what it takes to support renaming the
>> DTBs. Everyone (using Tegra) will have to update their bootloader, but
>> perhaps that can be dealt with.
> 
> Setting aside the idea of hard-coding filenames into any bootloader
> binary, did you catch that the proposed solution would allow you to
> continue using the dts filenames as they currently are?

I don't consider requiring people to install a custom /sbin/installdtbs
in order to override renaming done by the default in-kernel
scripts/installdtbs a solution.

Think of a distro that wants to support 5 different SoCs. If they
install a custom /sbin/installdtbs that does zero renaming, then they'll
get the desired DTB names for Tegra, but perhaps not for other SoCs. If
the don't install a custom /sbin/installdtbs that does zero renaming,
then they'll perhaps get the desired DTB names for SoCs other than
Tegra, but won't for Tegra.

Assuming we ever rename DTBs at all, there are a couple ways to solve this:

a) Require everyone who runs "make dtbs_install" (and who cares about
multiple SoCs, i.e. all distros at least) to install (and perhaps write)
their own custom /sbin/installdtbs that only renames some DTBs.

b) Just put the correct logic in the in-kernel installdtbs script, so
nobody has to do anything; it "just works" out-of-the-box.

> The find command in my example /sbin/installdtbs script spits out the
> in-tree dtb filename as it currently stands, and then you do what you
> want with it in your script.  Including, copying it, filename intact,
> into the location of your choice.  How could that possibly require you
> to upgrade your bootloader?

A "solution" that requires people to install custom scripts to undo
renaming that shouldn't be happening in the first place just isn't
workable; there's too much communication and support cost associated
with it.

So, if the renaming during "make dtbs_install" absolutely has to happen,
then I guess I'd just have to live with it, and force everyone to
upgrade their bootloader instead.

> I must admit I'm a bit mystified as to what Tegra is doing that this
> breaks it so horribly...

The idea is that a disto boot process runs as follow:

* U-Boot runs and initializes.

* U-Boot searches the boot disk (or any disk that could be a boot disk)
for e.g. /boot/boot.scr, and executes it.

* boot.scr loads the kernel, initrd, DTB, sets up the command-line, and
boots the kernel.

A few points to make here:

a) There must be a boot.scr or similar on disk, to provide a way for
distros to parameterize the boot process. At the very least they need to
configure the kernel command-line, specify whether an initrd is used at
all, etc.

b) boot.scr is responsible for loading the zImage etc. from disk, rather
than the default U-Boot environment doing this. This allows distros
complete flexibility re: where to put the zImage etc. on disk. On distro
might store a single copy in /boot/zImage, another might use
/boot/zImage-${kernelversion}, another might use
/boot/${kernelversion}/zImage, etc. By putting the onus on boot.scr to
do the loading, the distro has complete flexibility in file naming here.

c) There are a number of system-specific parameters required to
implement zImage/DTB loading. For example, the SDRAM address that they
should be loaded to. Distros shouldn't have to detect which board
they're running on and calculate the values of all those parameters.
Instead, U-Boot should provide the values to boot.scr, by setting
certain standard variables in the environment.

For example, the zImage gets loaded to $kernel_addr_r, the DTB to
$fdt_addr_r, etc.

d) Finally, boot.scr needs to load the DTB. This requires knowing which
DTB to load. Again, the distro shouldn't have to detect which board
they're running on, and either install the correct DTB to a static
filename, or make a decision on the DTB filename to load. Instead,
distros should simply install all DTBs generated by the kernel build,
and use some run-time information to calculate the DTB filename using a
completely HW-agnostic and generic algorithm.

To support this, U-Boot can be configured to add certain standard
environment variables to the default environment. These define which SoC
and board the code is running on. These are ${soc} and ${board}. If you
then calculate the DTB filename as ${soc}-${board}.dtb, that should work
anywhere. This is why keeping the current in-kernel DTB filenames is
important, so they match the assumption that this algorithm works.

Note: if the firmware contains an embedded DTB, boot.scr could detect
this e.g. by the standard variable $fdt_addr being set, and hence skiip
loading a DTB. IIRC, this is how Calxeda boards are set up.


So finally, if the kernel "make dtbs_install" starts renaming DTB files,
then I need to adjust the boot.scr we're using to use some other
algorithm to calculate the DTB filename. Given the filename isn't then
purely derived from ${soc} and ${board}, I probably need to set up some
additional (or replacement) variables in the standard U-Boot environment
that contain the extra fields required to calculate the DTB filename.
The existing ${vendor} might work. However, it'd be simplest if I just
had U-Boot export something like ${dtb_filename}, which contained the
(or a list of) filenames to try.

You can take a look at my boot.scr generation tool at:
https://github.com/NVIDIA/tegra-uboot-scripts

That probably works on the Raspberry Pi too (since I set up the Pi's
U-Boot port to work the same way) and likely would require minimal
changes to work on at least some TI and Calxeda boards.

The idea is that eventually, and board that wants to support a generic
distro booting on it would export the standard variables I mentioned
above, have a default U-Boot environment that simply searched for and
executed boot.scr, and distros would use a generic boot.scr as generated
by the tool I linked to above.
