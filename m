From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 16 Mar 2015 18:16:34 +0000
Subject: Versatile Express randomly fails to boot - Versatile Express to
 be removed from nightly testing
In-Reply-To: <55071742.6000405@arm.com>
References: <20150315213330.GB8656@n2100.arm.linux.org.uk>
 <20150316000438.GD8656@n2100.arm.linux.org.uk>
 <20150316004239.GE8656@n2100.arm.linux.org.uk>
 <20150316093553.GF8656@n2100.arm.linux.org.uk>
 <20150316130419.GI8656@n2100.arm.linux.org.uk>
 <55071742.6000405@arm.com>
Message-ID: <20150316181634.GK8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 16, 2015 at 05:47:46PM +0000, Sudeep Holla wrote:
> Hi Russell,
> 
> I was able to see exact behaviour on my VExpress setup with CA9X4 core-tile.
> Few observations from my side:
> 
> 1. This issue can be reproduced even on v3.19
> 2. As you suspected L2C, I tried disabling L2C and it seems to solve
>    the issue

My L2C says it's cache ID is 0x410000c3 - which is indeed a L2C-310, but
with an undocumented revision ID of 3, which as far as we can make out,
it's a R1Px where x > 0.

> 3. Since it's very random and enabling LL_DEBUG made it difficult to
>    reproduce the issue, I tried to dump the stack using DS5 debugger
> 4. The stack is exactly same always both on v4.0-rc* and v3.19 kernel
>    and on multiple runs

Hmm, I haven't seen them before I moved to 4.0-rc3 - before then my
nightly boot tests (which run two boots on the platform each night)
always seemed to succeed.

> 5. Connecting to h/w debugger, stopping and re-starting the CPUs,
>    solves the issue. It's helping CPUs to get out of __radix_tree_lookup
>    somehow

Interesting.  Are the traces below from 4.0-rc3 or an older kernel?

> Stacktrace
> ==========
> (sorry it's looks different from std. Linux backtrace as this one id dump
> from DS5)
> 
> CPU 0
> ----
> #0 __radix_tree_lookup( root = <Value currently has no location>, index =
> 16, nodep = (struct radix_tree_node**) 0x0, slotp = (void***) 0x0 ) at
> radix-tree.c:517

Can you dump the disassembly around this location for both CPU0 and CPU1
and the register values please?  I think it would be interesting to see
if they're both stuck on exactly the same address access.

I've currently narrowed down my latest potential culpret to something in
my Cubox-i code... specifically something in my "cubox-i-sdio" or
"imx-drm^" branches.

The cubox-i-sdio branch contains Olof's modifications to MMC to support
resets and regulators associated with wifi cards, which would be built,
but we would not have executed any of the MMC code at the point where
we'd be bringing the secondary CPUs up.  The imx-drm^ changes don't
touch any file which is built into my Versatile Express kernel, so it's
unlikely to affect anything (though, I'm build-boot-testing with imx-drm^
but cubox-i-sdio dropped just to make absolutely sure.)

One thing I've tried is turning off are the Cortex-A9 features - early
BRESP and full line of zeros.  That seems to make no apparent difference,
though it's hard to tell when #if 0'ing out the code, because that changes
the code placement and seems to stop the problem triggering.  I did have
a case where disabling FLZ (via #if 0'ing it out) seemed to solve it with
errata 588369 enabled, but changing the code to clear the FLZ bit instead
(which should have had the same effect) resulted in the problem
re-appearing.

I'm beginning to believe at this point that there /is/ a bug in the L2C on
the test chip, and that we're probably better off changing the Versatile
Express DT files to disable the L2C cache controller... what are your
thoughts on that?

I'm currently doing up to 8 boot tests - if I can do 8 consecutive boot
tests which all succeed, I'm declaring it a pass, otherwise it's a fail.
Generally, I've found that it will fail very early (like the first) but
sometimes up to the 4th.

I guess one thing we need to confirm is whether we have exactly the same
hardware and firmware versions.  Here's my board's early boot messages:

ARM V2M Boot loader v1.1.1
HBI0190 build 2313

ARM V2M Firmware v3.1.2
Build Date: Apr 16 2013

Date: Mon 30 Mar 2009
Time:     16:59:14

Cmd> reboot

Powering up system...
Daughterboard fitted to site 1.

Switching on ATXPSU...
ATX3V3: ON
VIOset: 1.8V
MBtemp: 27 degC

Configuring motherboard (rev D, var A)...
IOFPGA  config: PASSED
MUXFPGA config: PASSED
OSC CLK config: PASSED

Testing SMC devices (FPGA build 8)...
SRAM 32MB test: PASSED
VRAM  8MB test: PASSED
LAN9118   test: PASSED
USB & OTG test: PASSED
KMI1/KMI2 test: PASSED
MMC & SD  test: PASSED
DVI image test: PASSED
AACI AC97 test: PASSED
CF card   test: PASSED
UART port test: PASSED
MAC addrs test: PASSED

Reading Site 1 Board File \SITE1\HBI0191B\board.txt
DB1 JTAG configuration complete.
Setting DB1 OSCCLKS...
DB1.0 DCC 0 SPI configuration complete.

Writing SCC 0x40610000 with 0xBB8A802A
Writing SCC 0x40610001 with 0x00001F09
Writing SCC 0x40610002 with 0x00000000
DB1.0 DCC 0 SCC configuration complete.

DB SMB clock enabled.
Waiting for SITE1 CB_READY...
Testing SMB clock...
Configuring MUXFPGA for MB.
Setting DVI mode for VGA.
Releasing Daughterboard resets.
Switching MCC log to UART1.

Warning: Card Format not recognised, please check card.

ARM Versatile Express Boot Monitor
Version:    V5.2.1
Build Date: Apr  4 2013
Daughterboard Site 1: V2P-CA9 Cortex A9
Daughterboard Site 2: Not Used
Running boot script from flash - BOOTSCRIPT


U-Boot 2013.01.-rc1-00003-g43ee87aabf17-dirty (Jan 07 2014 - 00:00:38)
...

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
