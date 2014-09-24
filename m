From: bpringlemeir@nbsps.com (Bill Pringlemeir)
Date: Wed, 24 Sep 2014 12:33:00 -0400
Subject: [PATCH 0/9] ARM: vf610: Suspend/resume support
In-Reply-To: <4ee0621b0bf5f4d4e10eae7673bdf1cd@agner.ch> (Stefan Agner's
 message of "Wed, 24 Sep 2014 10:22:39 +0200")
References: <cover.1411404079.git.stefan@agner.ch> <87zjdqmjr3.fsf@nbsps.com>
 <4ee0621b0bf5f4d4e10eae7673bdf1cd@agner.ch>
Message-ID: <87y4t9kmgz.fsf@nbsps.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 Sep 2014, stefan at agner.ch wrote:

> Am 2014-09-23 17:36, schrieb Bill Pringlemeir:
>> On 22 Sep 2014, stefan at agner.ch wrote:

[snip]

>>> Power measurement (Colibri VF61, whole module):
>>> - Idle: 540mW
>>> - LP-RUN: 220mW (standby)
>>> - STOP: 200mW (mem)
>>
>>> Stefan Agner (9):
>>> ARM: dts: vf610: Add system reset controller (SRC)
>>> ARM: dts: vf610: add global power controller (GPC)
>>> ARM: dts: vf610: add on-chip SRAM
>>
>> These above three change sets have some implications for dual-chip
>> (Cortex-A5/Cortex-M4) configurations.  Epecially those running MQX.
>> There is not harm to define the register space (except DT size).
>> However, if you activate drivers that manipulate the registers for
>> all systems, then there is no choice to have MQX work on the 2nd
>> core.

> On the Timesys BSP, the kernel is fiddling around with this registers
> too, and AFAIK MQX is working with that kernel. Is MQX really using
> the GPC and SRC modules? I thought MQX is just relying on Linux taking
> care of that.

> Also, you have this problem with other registers as well, for instance
> the CCM module. In fact, to get into deeper sleep modes, you need to
> access the GPC (global power controller) as well as the CCM (clock
> controller module, for instance the CCM_CLPCR register). When you look
> at all the entry sequences, they all fiddling around with the GPC and
> the CCM. And I don't think that the kernel can work properly without
> having control over the clock module.

> IMHO, the SRC and GPC are like the CCM, and need to be under control
> of Linux exclusively.

Yes, it is difficult to see the existing Linux infrastructure working
without these.  The two cores both depend on the same clocks.  You must
use 'clk_ignore_unused' if you want to run both.

> Another case is the SRAM. There are other peripherals which are much
> more important, e.g. both instances of the EDMA modules are currently
> unconditional part of the device tree.

The SRAM is even more of an issue.  Often the MQX is running from the
SRAM.  I agree that the EDMA are actually a bit of an issue as well.
You need to modify MQX to not use them.  However, the MQX use of EDMA
seems stupid, so I prefer Linux to have this feature.  I didn't see
the edma patches when they went in and/or I didn't think of this until I
actually encounter the 'emda' conflict issue.

> Besides, afaik you can also use status = "disabled" in a device tree
> including the vf610.dtsi. The device tree is parsed sequential, the
> last settings wins.

This is true, but in some cases the code is depending on the device
being enabled?  Also, we have automatically compiled in the drivers if
'SOC_VF610' is active.  Ie, there is no way to exclude the code.  The
device tree also becomes a little heavier instead of including them in
the machine file.

>> I think that Shawn Guo already did a patchset to remove stuff from
>> the vf610.dtsi to the machine/configuration DT files.

In this patchset, I suggested that we could include the notation in the
headers which are included in the 'DT' files.  So instead of 'dtsi', we
could use,

   #define VF610_GPC_SUPPORT \
           gpc: gpc at 4006c000 {                \
                   compatible = "fsl,vf610-gpc"; \
                   reg = <0x4006c000 0x1000>;    \
           };

Or even,

   #define VF610_SUSPEND_DT_SUPPORT \ ...

Anyways, the DT issue doesn't matter so much.  People will have to make
custom versions for their own boards.  Although, I don't think it is not
that hard to support it at the machine level.

I agree that so far there are some peripherals that make it difficult to
run the mainline Linux with an MQX.  However, I think this patch set
seems to bring it closer to making it impossible.  I am only suggesting
that we make it a configuration option and not include it for all Vybrid
devices.

Is it clear that the desired way is to use,

   &gpc { status = "disabled"; };
   &src { status = "disabled"; };

We have,

arch/arm/mach-imx/gpc.c

      void __init vf610_gpc_init(void)
      {
              struct device_node *np;

              np = of_find_compatible_node(NULL, NULL, "fsl,vf610-gpc");
              gpc_base = of_iomap(np, 0);
              gpc_imr_base = gpc_base + VF610_GPC_IMR1;
   ...

arch/arm/mach-imx/mach-vf610.c

   static void __init vf610_init_irq(void)
   {
           vf610_gpc_init();
           irqchip_init();
   }

   ...

   +	.init_irq	= vf610_init_irq,

I don't think this will work.  Not to mention that 'mach-vf610.c' will
not build if HAVE_IMX_GPC is not defined.  Also, I don't really see a
use of the GPC module unless suspend/resume is active?   Even some wall
powered designs may wish to exclude this functionality?

I think that the SRC maybe needed for secure parts.  I think that some
designs might wish to restrict Linux's access to these registers as
well.  I don't actually see why we need this module?  I think the imx6
needs it due to multi-CPU bring-up, but in the Vybrid case, this does
not exist.  Can you check to see why we need the SRC?  I don't see where
we actually use it?  In patch9/9, we record it but do we actually access
the registers?  Is it just for the vf610_src_init() code?  Even that
seems the whole 'src.c' file is only needed for the 'src_base'
reference, which we don't use?

Thanks,
Bill Pringlemeir.
