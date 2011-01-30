From: therealbadguy@gmail.com (Badguy Badguy)
Date: Sat, 29 Jan 2011 23:48:54 -0700
Subject: iMX31 MBX registers Porting problem
Message-ID: <AANLkTin+Mo9YXEfoDAa+btjX5VdiOz1QJp++ck0efPAk@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

 I am trying to access the MBX registers on the iMX31 SOM from LogicPD

executing this code works on kernel 2.6.19.2 which has some out of
tree patches (freescale + community)

/* arch/arm/mach-mx3/mach-mx31lite.c */
#define MBX1_GLOBREG_REVISION  0x0F10
#define MBX_REG_SYS_PHYS_BASE  0xC0000000
#define MBX_REG_RANGE                   0x00004000

static struct resource mxc_reg_resources[] = {
       {
       .start = MBX_REG_SYS_PHYS_BASE,
       .end = MBX_REG_SYS_PHYS_BASE + MBX_REG_RANGE - 1,
       .flags = IORESOURCE_MEM },
};

/* some drivertest.c */
static u32 mx3reg_read_reg(struct mx3reg_data *mx3reg, unsigned long reg)
{
       return __raw_readl(mx3reg->reg_base + reg);
}

static int reg_probe(struct platform_device *pdev)
{
...
       mbx_reg = platform_get_resource(pdev, IORESOURCE_MEM, 0);
       if (!mbx_reg)
               return -EINVAL;
..
       mx3reg->reg_base = ioremap(mbx_reg->start, resource_size(mbx_reg));
       if (!mx3reg->reg_base) {
               ret = -ENOMEM;
               goto eremap;
       }

       printk(KERN_CRIT "Address: 0x%08X\n", mx3reg->reg_base);

       regread = mx3reg_read_reg(mx3reg, MBX1_GLOBREG_REVISION);
       printk(KERN_CRIT "MBX1_GLOBREG_REVISION: 0x%.8X\n", regread);
....
}

 I get:

Address: 0xC7860000
MBX1_GLOBREG_REVISION: 0x01010200

on kernel 2.6.19.2 and this is correct value as the revision.

I have tried it on these kernels:

2.6.19.2-custom - this one works, without any pvr drivers loaded
outside of kernel.

2.6.35
2.6.38-rc2
 neither of these worked, provide various dynamic address results for
the registers,
 when read do not conform to expected results.

here are some examples, I am iounmap and kfree when removing correctly
but I still get a new address for each insert, after removal,
this does not happen on 2.6.19.2, it's always the same.

Address: 0xC48A0000
MBX1_GLOBREG_REVISION: 0x00000000

Address: 0xC48A8000
MBX1_GLOBREG_REVISION: 0x00000000

Address: 0xC48B8000
MBX1_GLOBREG_REVISION: 0x00000000

Address: 0xC48C0000
MBX1_GLOBREG_REVISION: 0x00000000

 I have been trying to understand the code behind ioremap, and the
changes involved.

I have read a number of posts regarding ioremap
I am unsure of exactly what the problem is.

Is there another memory access method I should be using?

Could it could be that, either the ipu code, or the frame buffer code
from kernel 2.6.19.2 is somehow enabling this to work?
disabling the code via the configuration does not stop my driver from working

Is it likely there is some further initialization code in kernel 2.6.19.2?
how can I identify it?

are there any tips for finding out more about this?
I am afraid I have not been able to find a good start point.

Thanks for reading, sorry for length.
