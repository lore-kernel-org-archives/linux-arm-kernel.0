From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 17 Aug 2011 22:51:56 +0800
Subject: [PATCH 1/6] ARM: highbank: add devicetree source
In-Reply-To: <4E4BC6F5.4030707@gmail.com>
References: <1313526898-19920-1-git-send-email-robherring2@gmail.com>
	<1313526898-19920-2-git-send-email-robherring2@gmail.com>
	<20110817072706.GE10037@S2100-06.ap.freescale.net>
	<4E4BC6F5.4030707@gmail.com>
Message-ID: <20110817145155.GB11097@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 17, 2011 at 08:49:41AM -0500, Rob Herring wrote:
> Shawn,
> 
> On 08/17/2011 02:27 AM, Shawn Guo wrote:
> > Hi Rob,
> > 
> > On Tue, Aug 16, 2011 at 03:34:53PM -0500, Rob Herring wrote:
> >> From: Rob Herring <rob.herring@calxeda.com>
> >>
> >> This adds the devicetree source and documentation for the Calxeda highbank
> >> platform.
> >>
> >> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> >> ---
> >>  Documentation/devicetree/bindings/arm/calxeda.txt |    8 +
> >>  arch/arm/boot/dts/highbank.dts                    |  212 +++++++++++++++++++++
> >>  2 files changed, 220 insertions(+), 0 deletions(-)
> >>  create mode 100644 Documentation/devicetree/bindings/arm/calxeda.txt
> >>  create mode 100644 arch/arm/boot/dts/highbank.dts
> >>
> >> diff --git a/Documentation/devicetree/bindings/arm/calxeda.txt b/Documentation/devicetree/bindings/arm/calxeda.txt
> >> new file mode 100644
> >> index 0000000..4755caa
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/arm/calxeda.txt
> >> @@ -0,0 +1,8 @@
> >> +Calxeda Highbank Platforms Device Tree Bindings
> >> +-----------------------------------------------
> >> +
> >> +Boards with Calxeda Cortex-A9 based Highbank SOC shall have the following
> >> +properties.
> >> +
> >> +Required root node properties:
> >> +    - compatible = "calxeda,highbank";
> >> diff --git a/arch/arm/boot/dts/highbank.dts b/arch/arm/boot/dts/highbank.dts
> >> new file mode 100644
> >> index 0000000..2dd3b7b
> >> --- /dev/null
> >> +++ b/arch/arm/boot/dts/highbank.dts
> >> @@ -0,0 +1,212 @@
> >> +/*
> >> + * Copyright 2011 Calxeda, Inc.
> >> + *
> >> + * This program is free software; you can redistribute it and/or modify it
> >> + * under the terms and conditions of the GNU General Public License,
> >> + * version 2, as published by the Free Software Foundation.
> >> + *
> >> + * This program is distributed in the hope it will be useful, but WITHOUT
> >> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> >> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> >> + * more details.
> >> + *
> >> + * You should have received a copy of the GNU General Public License along with
> >> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> >> + */
> >> +
> >> +/dts-v1/;
> >> +
> >> +/* First 4KB has pen for secondary cores. */
> >> +/memreserve/ 0x00000000 0x0001000;
> >> +
> > I failed to find the "pen" handling in the whole patch series.  Am I
> > missing anything?
> > 
> 
> In highbank.c:
> 
> +#define HB_JUMP_TABLE_PHYS(cpu)		(0x40 + (0x10 * (cpu)))
> +#define HB_JUMP_TABLE_VIRT(cpu)		phys_to_virt(HB_JUMP_TABLE_PHYS(cpu))
> +
> +void highbank_set_cpu_jump(int cpu, void *jump_addr)
> +{
> +	writel(BSYM(virt_to_phys(jump_addr)), HB_JUMP_TABLE_VIRT(cpu));
> +	__cpuc_flush_dcache_area(HB_JUMP_TABLE_VIRT(cpu), 16);
> +	outer_clean_range(HB_JUMP_TABLE_PHYS(cpu),
> +			  HB_JUMP_TABLE_PHYS(cpu) + 15);
> +}
> 
Ah, ok, the 'pen' you meant is the entry address of secondary cores.
I thought of something like 'pen_release' in plat-versatile/platsmp.c.
So you do not need 'boot_lock' and 'pen_release' stuff to sync secondary
cores with the primary one (like all other smp platforms do)?

-- 
Regards,
Shawn
