From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Mon, 11 Jul 2011 12:17:25 -0500
Subject: [PATCH 01/52] ARM: introduce atag_offset to replace boot_params
In-Reply-To: <alpine.LFD.2.00.1107111046350.14596@xanadu.home>
References: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
	<20110708203634.GU4812@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1107081714251.14596@xanadu.home>
	<alpine.LFD.2.00.1107111046350.14596@xanadu.home>
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F383D6D6F7@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, July 11, 2011 7:59 AM, Nicolas Pitre wrote:
> After looking at it some more, this can't work either as on ep93xx the 
> RAM offset is currently selected a kernel config time and we do want to 
> get rid of that.

The ep93xx actually uses the same relative offset for the boot_params (+0x100)
for all memory configurations.  The issue is the base physical address of the
system memory.

There are four sdram chip selects available on the ep93xx.  These, along with
the ASDO boot option pin, define the base address for the sdram.

nSDCS3, ASDO=1	0x00000000
nSDCS3, ASDO=0	0xf0000000
nSDCS2, ASDO=x	0xe0000000
nSDCS1, ASDO=x	0xd0000000
nSDCS0, ASDO=x	0xc0000000

Unfortunately, all the ep93xx boards I have are designed with the sdram using
nSDCS0 so I can't test the other boot configurations.

Regardless, with these patches, and having ARM_PATCH_PHYS_VIRT enabled, I am
able to boot all of my boards successfully.

The EDB9315 dev board can be jumper selected so that the sdram is connected
to either nSDSC0 or nSDCS3 (default).

The EDB9312 dev board can be jumper selected to use any of the chip selects
for the sdram.

If anyone has access to either of these boards and could test these patches
it would be a great help.

Before the ARM_PATCH_PHYS_VIRT patch the Kconfig options to select the
"EP93xx first SDRAM bank selection" was needed to limit the board selections
so that only board which shared an SDRAM chip select configuration could be
selected.  With ARM_PATCH_PHYS_VIRT I don't think this is needed any longer.

But, if the boot_params are still going to be used, the bank selection is still
needed so that the physical address of the boot_params is correct.  Changing it
to an atag_offset makes it work on the ep93xx.

Just my 2 cents....

Regards,
Hartley
