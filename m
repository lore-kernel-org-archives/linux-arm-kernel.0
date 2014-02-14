From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 14 Feb 2014 19:14:47 +0800
Subject: use {readl|writel}_relaxed instead of readl/writel in
 i2c-designware-core ?
In-Reply-To: <8705989.qzo882Ldx0@wuerfel>
References: <20140214155438.4f749a79@xhacker>
	<8705989.qzo882Ldx0@wuerfel>
Message-ID: <20140214191447.7b283568@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnd,

On Fri, 14 Feb 2014 01:09:44 -0800
Arnd Bergmann <arnd@arndb.de> wrote:

> On Friday 14 February 2014 15:54:38 Jisheng Zhang wrote:
> > Hi all,
> > 
> > The writel/readl is too expensive especially on Cortex A9 w/ outer L2
> > cache. This introduce i2c read/write error on Marvell Berlin SoCs when
> > there are L2 cache maintenance operations at the same time.
> > 
> > In our internal berlin bsp, we just replaced readl/writel with the relaxed
> > version. But AFAIK, the "relaxed" version doesn't exist on all
> > architectures. How to handle this issue? 
> 
> In case of i2c-designware, this is safe because that driver does not perform
> DMA. In other drivers, you may have to be more careful, to ensure that all
> MMIO is serialized with DMA operations performed by the driver.
> 
> > Any suggestions are appreciated.
> 
> I would definitely welcome a patch that adds a default  _relaxed
> implementation to include/linux/io.h, like this:
> 
> #ifndef readb_relaxed
> #define readb_relaxed(p) readb(p)
> #endif
> 
> and then adds "#define readb_relaxed(p) readb_relaxed(p)" etc. to all
> architectures that have a non-macro definition for readb.

Thanks for the suggestions. I'll try to send out one RFC patch.

Thanks,
Jisheng
