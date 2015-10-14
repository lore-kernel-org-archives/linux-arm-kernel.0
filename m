From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 14 Oct 2015 18:47:21 +0100
Subject: l2c: Kernel panic in l2c310_enable() in non-secure mode
In-Reply-To: <561E6B1F.1070701@sigmadesigns.com>
References: <561E6407.6000002@sigmadesigns.com>
 <561E6B1F.1070701@sigmadesigns.com>
Message-ID: <20151014174721.GR32532@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 14, 2015 at 04:47:59PM +0200, Marc Gonzalez wrote:
> Just to be sure, I changed set_auxcr() to a NOP. The kernel does not
> panic with that setup, and I can see the boot messages:
> 
> [    0.000000] l2x0_of_init: FOO
> [    0.000000] L2C-310 enabling early BRESP for Cortex-A9
> [    0.000000] L2C-310: enabling full line of zeros but not enabled in Cortex-A9
> [    0.000000] reg=0x104 val=0x66460801
> [    0.000000] reg=0x100 val=0x1
> [    0.000000] L2C-310 I prefetch enabled, offset 1 lines
> [    0.000000] L2C-310 dynamic clock gating enabled, standby mode enabled
> [    0.000000] L2C-310 cache controller enabled, 8 ways, 512 kB
> [    0.000000] L2C-310: CACHE_ID 0x410000c8, AUX_CTRL 0x62460801
> 
> The "reg=0x%x val=0x%lx\n" lines are from tango_l2c_write_sec()
> 
> It seems the firmware forgot to enable FLOZ.

Wrong.  Do _not_ enable FLZ in the Cortex-A9.  FLZ needs the L2 cache
enabled _before_ the Cortex A9.  This is not something you can do in
firmware/boot loader/etc.  It has to be done by the kernel when the L2
cache is initialised.

If your firmware prevents this, sorry, you can't ever use FLZ.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
