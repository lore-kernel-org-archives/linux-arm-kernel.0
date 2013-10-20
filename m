From: robt201108@gmail.com (robert)
Date: Sun, 20 Oct 2013 21:08:14 +0100
Subject: DreamPlug / GuruPlug support in 3.12-rc
In-Reply-To: <20131020161747.GA15169@titan.lakedaemon.net>
References: <5263C7C2.4000204@gmail.com>
 <20131020161747.GA15169@titan.lakedaemon.net>
Message-ID: <5264382E.9050207@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason,

Many thanks for the additional info, and suggestions.. 

I've been running more tests, and still no luck, so far.

For 3.11, I found that selecting the 'Dreamplug' options for Kirkwood
didn't work, and I had to select both 'Marvell GuruPlug Reference Board'
_and_ 'Marvell GuruPlug Reference Board (Flattened Device Tree)', and
then use kirkwood-guruplug-server-plus.dtb:

# cat arch/arm/boot/zImage
arch/arm/boot/dts/kirkwood-guruplug-server-plus.dtb >
arch/arm/boot/zImage_w_dtb
# mkimage -A arm -O linux -T kernel -C none -a 0x8000 -e 0x8000 -n
"linux-dreamplug" -d arch/arm/boot/zImage_w_dtb ../uImage3116

Robert.

On 10/20/2013 05:17 PM, Jason Cooper wrote:
> Robert,
>
> I add the other kirkwood/Marvell maintainers to the Cc:
>
> On Sun, Oct 20, 2013 at 01:08:34PM +0100, robert wrote:
>> I have an 'older' DreamPlug, that is - effectively - a GuruPlug inside:
> Yes, all Dreamplugs are essentially a Guruplug without the heat problems
> :)  The big difference is that the Guruplugs have NAND flash and the
> Dreamplugs have 2MB NOR flash (for u-boot and environment).  DP uses the
> micro SD card for rootfs.
>
>> # cat /proc/cpuinfo
>> processor       : 0
>> model name      : Feroceon 88FR131 rev 1 (v5l)
>> BogoMIPS        : 1191.11
>> Features        : swp half thumb fastmult edsp
>> CPU implementer : 0x56
>> CPU architecture: 5TE
>> CPU variant     : 0x2
>> CPU part        : 0x131
>> CPU revision    : 1
>> Hardware        : Marvell GuruPlug Reference Board
>> Revision        : 0000
>> Serial          : 0000000000000000
>>
>> UBoot:
>> Marvell-DreamPlug
>> SoC:   Kirkwood 88F6281_A0
>>
>> I have managed to get kernels up to 3.11.6 to compile and install OK,
>> with the 'device tree' option, by selecting 'Marvel GuruPlug reference
>> board' and 'Marvel GuruPlug reference board (flattened device tree)',
>> but none of the available options on 3.12-rc seem to work..    I have
>> tried selecting all the 'Marvell Kirkwood' options, and the 'Marvell
>> SOC' options, and none of these produces a bootable kernel.
> Yes, the DT conversion has progressed far enough that we don't need
> much, if any, code (board-dreamplug.c) for individual boards.  So the
> Kconfig options for individual boards have been removed.  When you
> select "Marvell Kirkwood Flattened Device Tree", it will build a kernel
> bootable on any of the kirkwood boards.  After the zImage is built, you
> need to run 'make dtbs' and it will build all of the available kirkwood
> dtb files for you.
>
>> As a test, I temporarily deselected 'Embedded system', and got the
>> following at boot:
>> Uncompressing Linux... done, booting the kernel.
>> Error: unrecognized/unsupported machine ID (r1 = 0x00000a63).
>> Available machine support:
>> ID (hex)        NAME
>> 00000b44        Marvell OpenRD Ultimate Board
>> 00000939        Marvell OpenRD Client Board
>> 00000915        Marvell OpenRD Base Board
>> 00000691        Marvell RD-88F6192-NAS Development Board
>> 00000692        Marvell RD-88F6281 Reference Board
> Unless you plan on booting this kernel on any of these boards, you can
> go ahead and disable building the above legacy board files.
>
>> ffffffff        Marvell Kirkwood (Flattened Device Tree)
>> Please check your kernel config and/or bootloader.
> You need to enable CONFIG_ARM_APPENDED_DTB and then append the
> appropriate dtb:
>
> $ cp arch/arm/boot/zImage /tmp/
> $ cat arch/arm/boot/dts/kirkwood-dreamplug.dtb >>/tmp/zImage
> $ mkimage ... -d /tmp/zImage /tmp/uImage
>
> Alternatively, you could upgrade u-boot to mainline which has supported
> both the dreamplug and DT booting for a _long_ time now.  A lot of folks
> are uncomfortable with that, though.  Which is why we added
> CONFIG_ARM_APPENDED_DTB as a temporary work around.
>
>> 0a63(hex) is 2659(dec), which is, in ~/arch/arm/tools/mach-types:
>> guruplug        MACH_GURUPLUG        GURUPLUG        2659
> Yes, that was a bad design decision on the part of Globalscale, nothing
> we can do about it. :(
>
>> I appreciate that ARM support in 3.12-rc is still a work-in-progress,
>> but would like to know if this support will be included soon..   I have
>> - as usual - tried to find some clues online, but haven't found
>> anything, so far...
> Asking here is the right thing to do.  Let us know how the above works
> out for you.
>
> hth,
>
> Jason.
