From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Sat, 16 Apr 2011 11:20:29 +0300
Subject: [PATCH 2/2] mtd: msm_nand: Add initial msm nand driver support.
In-Reply-To: <4DA85B24.50807@codeaurora.org>
References: <1298940450-27365-1-git-send-email-mnalajal@codeaurora.org>
	<1298940450-27365-2-git-send-email-mnalajal@codeaurora.org>
	<1302861097.3220.12.camel@localhost>  <4DA85B24.50807@codeaurora.org>
Message-ID: <1302942029.2308.1.camel@koala>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2011-04-15 at 20:20 +0530, Murali Nalajala wrote:
> On 4/15/2011 3:21 PM, Artem Bityutskiy wrote:
> > On Tue, 2011-03-01 at 06:17 +0530, Murali Nalajala wrote:
> >> +#define pr_fmt(fmt) "%s:" fmt, __func__
> >> +
> >> +#include<linux/kernel.h>
> >> +#include<linux/mtd/mtd.h>
> >> +#include<linux/mtd/nand.h>
> >> +#include<linux/mtd/partitions.h>
> >> +#include<linux/platform_device.h>
> >> +#include<linux/sched.h>
> >> +#include<linux/slab.h>
> >> +#include<linux/dma-mapping.h>
> >> +#include<asm/mach/flash.h>
> >> +#include<mach/dma.h>
> >> +
> >> +#include "msm_nand.h"
> >> +
> >> +unsigned long msm_nand_phys;
> >
> > No global variables like this please. Here is how you use them:
> >
> > +extern unsigned long msm_nand_phys;
> 
> extern declaration in the 'C' file causing warning. We are in plan to 
> upload the OneNAND changes soon which makes use of the same .h file.

So you say that OneNAND (an independent driver) is going to use this
variable? Are you also going to export it?

> > +#define MSM_NAND_REG(off) (msm_nand_phys + (off))
> > +
> > +#define MSM_NAND_FLASH_CMD            MSM_NAND_REG(0x0000)
> > +#define MSM_NAND_ADDR0                MSM_NAND_REG(0x0004)
> >
> > Could you please make the macros to take the "struct msm_nand_chip
> > *chip" argument instead, and store the pase address there. Do not hide
> > the fact that those macros are actually functions, not constant - this
> > is error prone.
> >
> > Besides, I'm do not know your HW, but if you have several controllers
> > with various base addresses - your driver won't work.
> 
> you are correct, we have multiple controllers, which breaks this logic 
> in future.

So then make your macros to accept the base address as an argument
instead please.

-- 
Best Regards,
Artem Bityutskiy (???????? ?????)
