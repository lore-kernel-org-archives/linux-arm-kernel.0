From: robh@kernel.org (Rob Herring)
Date: Tue, 13 Oct 2015 12:55:11 -0500
Subject: [PATCH v3] arm-soc: Add support for Sigma Designs Tango4
In-Reply-To: <561D2952.4060908@sigmadesigns.com>
References: <560EAA7C.3070302@free.fr> <5124277.UR9sg1IOHT@wuerfel>
 <560EFDB3.9010305@free.fr> <11113740.WL812ZaRcZ@wuerfel>
 <5612A473.8030405@sigmadesigns.com>
 <5613EF4C.30603@sigmadesigns.com>
 <CAL_JsqJ+WTBYF=sJWbkgNzL48H5AiXL4aoVV3DNiL6T_UQKQfg@mail.gmail.com>
 <561D2952.4060908@sigmadesigns.com>
Message-ID: <CAL_JsqKa4trfpLY_DPsjBrfH-7SSUQMACYVW7DNN1=Pv3B4FrA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 13, 2015 at 10:54 AM, Marc Gonzalez
<marc_gonzalez@sigmadesigns.com> wrote:
> On 09/10/2015 16:08, Rob Herring wrote:
>
>> No memory node?
>
> "3.4 Memory node
>
> A memory device node is required for all device trees and describes
> the physical memory layout for the system. If a system has multiple
> ranges of memory, multiple memory nodes can be created, or the ranges
> can be specified in the reg property of a single memory node."
>
> (This is a board property then.)
>
> Suppose a board provides 2 GB of RAM, spanning physaddr 0x8000_0000
> to 0xFFFF_FFFF; the memory node should be written like this?
>
>         memory at 80000000 {
>                 device_type = "memory";
>                 reg = <0x80000000 0x80000000>; /* 2 GB */
>         };
>
> Does it make a difference if the 2 GB are provided by 1, 2, or even
> 4 memory modules?

No, as long as the OS supports that and Linux does.

> Assume a different board only provides 1 GB using two 512 MB modules
> DIMM0: 0x8000_0000 to 0xA000_000
> DIMM1: 0xC000_0000 to 0xE000_000
> What would the memory node look like?
> (Do I have to set #address-cells=2 and #size-cells=1?)

reg = <0x80000000 0x20000000>,
 <0xc0000000 0x20000000>;

#address-cells is how big the address is (in 32-bit words), not how
many address ranges you have.

>
>> cpus node?
>
> Is this used to document the CPU?
> I didn't see any code making use of that information.

The SMP code uses it: arch/arm/kernel/devtree.c

>> No pl310? A9 performance mon?
>
> About the pl310, it seems my SoC is one of a few running in ARM's
> "non-secure" world (TrustZone thingy).

highbank is also.

>
> Russell discussed this topic in:
> http://thread.gmane.org/gmane.linux.ports.arm.kernel/441454/focus=441806
>
> AFAIU, the firmware on my platform was made to behave like OMAP's.
> I suppose this means I can copy OMAP's DT and corresponding code
> for L2 interaction.
>
> omap4_l2c310_write_sec, omap_smc1

Right. Highbank is similar.

> Russell mentioned .l2c_aux_mask and .l2c_aux_val
>
> $ git grep l2c_aux_ arch/arm/kernel/
> arch/arm/kernel/irq.c:      (machine_desc->l2c_aux_mask || machine_desc->l2c_aux_val)) {
> arch/arm/kernel/irq.c:          ret = l2x0_of_init(machine_desc->l2c_aux_val,
> arch/arm/kernel/irq.c:                             machine_desc->l2c_aux_mask);
>
> They seem to be used exclusively in the l2x0_of_init call.
> Are they documented somewhere?

The register is in the PL310 TRM.

Ideally, your firmware should set aux ctrl register and you only need
to enable the L2.

Rob
