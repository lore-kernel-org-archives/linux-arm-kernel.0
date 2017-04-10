From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Mon, 10 Apr 2017 18:16:19 +0200
Subject: DT overlay issues - dtc flags
Message-ID: <1264bdc3-e61e-0256-0a0f-fdd8dbf50397@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I've tried to play around with Device Tree overlays (.dtbo files):

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/overlay-notes.txt

First of all, that document refers to a non-existing
Documentation/devicetree/dt-object-internal.txt. Could someone please
fix that one way or another?

In my particular example I've tried to extend the &i2c1 and &gpio nodes
of 4.11-rc5 arm64 broadcom/bcm2837-rpi-3-b.dts. The above documentation
prominently claims that this can be done via target = <&foo> syntax, but
U-Boot's fdt apply command fails for such a file. If instead I use the
alternative target-path = "/soc/..." then it works just fine.

As mentioned in the very bottom of the documentation, resolution of
phandle target references requires a __symbols__ node in the base .dtb.
IIUC this is only generated when passing the -@ dtc command line flag.

At first I thought this were an issue with how we build the .dtb files
in openSUSE [1], but by my reading of the kernel Makefiles not passing
-@ in DTC_FLAGS or cmd_dtc, you should run into the exact same issue.

I could think of a few ARMv7-M systems where such DT bloat might be
undesired (small flash sector sizes), but then it would seem easier to
suppress -@ where needed than to have a feature that by all practical
means is half unusable by default.

U-Boot itself appears to face a similar issue in that its internal
Device Trees are built without -@, and via Alex' distro boot extensions
this internal DT is passed on via UEFI as fallback when no external .dtb
file is found. So in the non-SPL case the DT should probably be built
with -@, too.

Or am I misunderstanding something here?

Thanks,
Andreas

[1]
https://build.opensuse.org/package/view_file/Kernel:HEAD/dtb-aarch64/dtb-aarch64.spec?expand=1

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
