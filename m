From: bpringlemeir@nbsps.com (Bill Pringlemeir)
Date: Tue, 23 Sep 2014 11:54:26 -0400
Subject: [PATCH 1/2] ARM: dts: vf610: Add ARM Global Timer
References: <1410437175-6636-1-git-send-email-stefan@agner.ch>
Message-ID: <87mw9qmix9.fsf@nbsps.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 Sep 2014, stefan at agner.ch wrote:

> Add Global Timer support which is part of the Snoop Control Unit
> of the Cortex-A5 processor. This Global Timer is compatible with the
> Cortex-A9 implementation. It's a 64-bit timer and is clocked by the
> peripheral clock, which is typically 133 or 166MHz on Vybrid.

> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
> arch/arm/boot/dts/vf610.dtsi | 8 ++++++++
> 1 file changed, 8 insertions(+)

As per the GPC and SRC series, adding these peripherals to the
'vf610.dtsi' may make some configuration no longer boot.  I have an
Cortex-A5 MQX in the secure world and it uses the Global timer for the
OS tick.  Maybe that is just my problem and I need to have several
trees.  However, It would be nice if the system timer choice was made in
a '.config' and the machine DT and not the generic Vybrid one.

Also, the timer is listed in the same bank as the snoop control unit,
but it is part of several banks of registers,

 0x40002000 AIPS slot 2, CA5-SCU+GIC CPU Interface registers 1

 0x000-0x054 SCU 
 0x100-0x1fc GIC local registers
 0x200-0x218 Global Timer
 0x600-0x634 Local timer/watchdog timer

I think that the 'reg' mapping will be limited to 4k MMU pages and so we
will have a bunch of aliases.  At least the GIC registers are already
mapped.  Is there some way in the DT to provide several sets of
registers under one mapping and then use the different offsets in the
driver/device instance?

Fwiw,
Bill Pringlemeir.
