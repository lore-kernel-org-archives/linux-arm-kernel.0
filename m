From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Fri, 29 Apr 2011 13:04:13 -0500
Subject: [PATCH v3 00/23] Create common framework for AT91 device
	initialisation
In-Reply-To: <1304045972-19319-1-git-send-email-ryan@bluewatersys.com>
References: <1304045972-19319-1-git-send-email-ryan@bluewatersys.com>
Message-ID: <0D753D10438DA54287A00B027084269764D274304B@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, April 28, 2011 7:59 PM, Ryan Mallon wrote:
>
> Each AT91 variant (AT91RM9200, AT91SAM9260, etc) currently has its own
> devices file, which includes the MMIO address, interrupt
> configuration, GPIO setup, etc for each device. This results in a large
> amount of duplicated code.
>
> This patch set introduces a framework for adding shared devices for the
> AT91 platform and replaces the multiple device setup implementations for
> each device with single implementations in the new framework. This has
> a net reduction of nearly 5000 lines of code.
>
> Each of the arch/arm/mach-at91/*_devices.c files becomes a collection of
> structures (with some initialisation callbacks where necessary) with a
> table of devices which are present on the particular AT91 variant. All
> structures/functions are marked as __init/__initdata so there is little
> additional memory overhead. This also means that the #ifdefs around each
> device can be removed from the *_devices.c files (but remain in the new
> common devices.c file) without overhead.
>
> This patch series does not introduce any functional changes to how the
> board files add devices, it only replaces the duplicate device 
> initialisation code with common versions. The patch series attempts to
> have minimum change by rewriting as little as possible of the actual
> device initialisation functions.
>
> This is also a step towards allowing more than one AT91 variant to be
> built into a single kernel by removing duplicate function names across
> the *_devices.c files.
> 
> I have build tested the patch series for all of the  AT91 variants 
> and devices, and have boot tested it on the AT91SAM9G20 (Snapper 9G20
> board) and tested basic device functionality.

Ryan,

This patch series does not apply to linux-next.

It appears Jean-Christophe PLAGNIOL-VILLARD has recently committed a number
of patches to that branch.

    at91: move clock subsystem init to soc generic init
    at91: move register clocks to soc generic init
    at91: move st timer to drivers/clocksource
    at91: move pit timer to drivers/clocksource
    at91: switch st timer to early platform devices
    at91: switch pit timer to early platform devices
    at91: move gpio to drivers/gpio
    at91: switch gpio to early platfrom device
    at91: switch to CLKDEV_LOOKUP
    at91: use structure to store the current soc
    at91: merge board usb-a9260 and usb-a9263 together
    at91: factorize at91 interrupts init to soc
    at91: introduce commom AT91_BASE_SYS
    at91rm9200: introduce at91rm9200_set_type to specficy cpu package
    at91: 9260 and 9g20 add support of join SRAM Memory Mapping
    at91/board-eco920: remove at91_beeper ressource as no driver at91_beeper exist
    atmel_serial: keep the platform_device unchanged
    at91: remove MTD_NAND_ATMEL_BUSWIDTH_16 option
    at91: Add ARCH_ID and basic cpu macros definition for 5series chips family.

There are also these three ahead of Linus' linux-2.6 tree:

    arm: at91: fix compiler warning for eb01 board build
    ARM: at91: AT91CAP9 has a macb device
    treewide: remove extra semicolons

Regards,
Hartley
