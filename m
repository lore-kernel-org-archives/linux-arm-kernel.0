From: hjk@linutronix.de (Hans J. Koch)
Date: Tue, 23 Mar 2010 11:15:40 +0100
Subject: [PATCH 05/07] Basic IO mappings for mach-tcc8k
In-Reply-To: <63386a3d1003230029r7ed7c4adm107298686aa14d5e@mail.gmail.com>
References: <20100322191900.GF2040@bluebox.local>
	<20100322192748.GK2040@bluebox.local>
	<63386a3d1003230029r7ed7c4adm107298686aa14d5e@mail.gmail.com>
Message-ID: <20100323101540.GB2049@bluebox.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 23, 2010 at 08:29:01AM +0100, Linus Walleij wrote:
> 2010/3/22 Hans J. Koch <hjk@linutronix.de>:
> 
> > Map the IO ranges of TCC8xxx peripherals.
> > + ? ? ? {
> > + ? ? ? ? ? ? ? .virtual ? ? ? ?= INT_SRAM_BASE_VIRT, ? /* Internal SRAM */
> > + ? ? ? ? ? ? ? .pfn ? ? ? ? ? ?= __phys_to_pfn(INT_SRAM_BASE),
> > + ? ? ? ? ? ? ? .length ? ? ? ? = INT_SRAM_SIZE,
> > + ? ? ? ? ? ? ? .type ? ? ? ? ? = MT_DEVICE
> > + ? ? ? },
> 
> MT_DEVICE is probably inappropriate here as well.
> 
> > + ? ? ? {
> > + ? ? ? ? ? ? ? .virtual ? ? ? ?= DATA_TCM_BASE_VIRT, ? /* Data TCM */
> > + ? ? ? ? ? ? ? .pfn ? ? ? ? ? ?= __phys_to_pfn(DATA_TCM_BASE),
> > + ? ? ? ? ? ? ? .length ? ? ? ? = DATA_TCM_SIZE,
> > + ? ? ? ? ? ? ? .type ? ? ? ? ? = MT_DEVICE
> > + ? ? ? },
> 
> Actually, look close at your specs here, because you seem to have both
> SRAM and TCM, usually you have ITCM+DTCM, so the thing that is
> called SRAM may be something else.
> 
> Looking at the .h file:
> 
> +#define INT_SRAM_BASE          0x30000000
> +#define INT_SRAM_SIZE          SZ_32K
> (...)
> +#define DATA_TCM_BASE          0xa0000000
> +#define DATA_TCM_SIZE          SZ_8K
> 
> Check if the SRAM is really an SRAM and not ITCM (which can be
> suspected).

I'm quite sure it's normal SRAM. I've got the boot ROM code sources, they
use it for both code and variables, like any standard SRAM. 

> Also check that the DTCM is really such a thing.

Yep, I'll do this.

> (The code in arch/arm/kernel/tcm.c does this once you enable it,
> it will scream if the config of the system does not match what the
> CPU register is saying about ITCM+DTCM.)

OK, will try.

> 
> If the DTCM is really an embedded TCM you can move it wherever
> you want, even i physical memory space. It doesn't have to be on
> 0xa0000000, this is probably only the place where your boot code
> locates it.

Thanks a lot for your detailed review and your hints.

Hans

> 
> Yours,
> Linus Walleij
