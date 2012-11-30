From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 30 Nov 2012 16:10:36 +0000
Subject: [PATCH v3] ARM: Factor out cpuid implementor and part number
In-Reply-To: <20121130160337.GQ19440@n2100.arm.linux.org.uk>
References: <1354290073-55801-1-git-send-email-c.dall@virtualopensystems.com>
 <20121130160337.GQ19440@n2100.arm.linux.org.uk>
Message-ID: <20121130161036.GR19440@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 30, 2012 at 04:03:38PM +0000, Russell King - ARM Linux wrote:
> On Fri, Nov 30, 2012 at 10:41:13AM -0500, Christoffer Dall wrote:
> > Decoding the implementor and part number of the CPU id in the CPU ID
> > register is needed by KVM, so we factor it out to share the code.
> > 
> > Cc: Will Deacon <will.deacon@arm.com>
> > Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
> > ---
> > Changes since v2:
> >  - Take implementor as argument to read_cpuid_part_number
> 
> Actually, I don't think this is the correct way.  There's noting
> inherently different about Xscale wrt part numbers, it's just that
> someone decided to do stuff "differently" and use the CPU part
> number to identify the SoC as a whole.
> 
> Here's the full list:
> 
> 80200	69052000	fffffff0
> PXA250	69052100	fffff7f0
> PXA210	69052120	fffff3f0
> 8032x	69052420	fffff7e0
> PXA255	69052d00	fffffff0
> 80219	69052e20	ffffffe0
> 8033x	69054010	fffffd30
> IXP43x	69054040	fffffff0
> PXA270	69054110	fffffff0
> IXP2400	69054190	fffffff0
> IXP2800	690541a0	fffffff0
> IXP42x	690541c0	ffffffc0
> IXP46x	69054200	ffffff00
> Xscale3	69056000	ffffe000
> PXA935	56056000	ffffe000
> 
> What we get from these is:
> XScale1 can be identified by (id & 0xe000) == 0x2000
> Xscale2 can be identified by (id & 0xe000) == 0x4000
> Xscale3 can be identified by (id & 0xe000) == 0x6000
> 
> I don't think we should make a distinction in read_cpuid_part_number()
> between these; if manufacturers are silly enough to abuse these fields
> then its their problem. :)
> 
> What I suggest is that read_cpuid_part_number() returns the part number
> field as defined by ARM.  We then also define XSCALE_ARCH_MASK to be
> 0xe000 and a bunch of XSCALE_ARCH_V1..V3 along those lines.  Maybe even
> a xscale_cpu_version() macro which returns the XScale CPU version
> pre-masked.

Here's the other place where the CPU ID is parsed on Xscale devices:

drivers/usb/gadget/pxa25x_udc.c-#define CP15R0_VENDOR_MASK	0xffffe000
drivers/usb/gadget/pxa25x_udc.c:#define CP15R0_XSCALE_VALUE	0x69052000	/* intel/arm/xscale */
drivers/usb/gadget/pxa25x_udc.c:#define CP15R0_XSCALE_VALUE	0x69054000	/* intel/arm/ixp4xx */
drivers/usb/gadget/pxa25x_udc.c-	asm("mrc%? p15, 0, %0, c0, c0" : "=r" (chiprev));
drivers/usb/gadget/pxa25x_udc.c:	if ((chiprev & CP15R0_VENDOR_MASK) != CP15R0_XSCALE_VALUE) {
drivers/usb/gadget/pxa25x_udc.c-		pr_err("%s: not XScale!\n", driver_name);
drivers/usb/gadget/pxa25x_udc.c-		return -ENODEV;
drivers/usb/gadget/pxa25x_udc.c-	}
