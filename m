From: liguozhu@hisilicon.com (Kenneth Lee)
Date: Mon, 17 Aug 2015 17:17:50 +0800
Subject: [PATCH 3/5] net: add Hisilicon Network Subsystem MDIO support
In-Reply-To: <2142879.tTtWetb0nc@wuerfel>
References: <1439548222-231611-1-git-send-email-liguozhu@hisilicon.com>
 <1439548222-231611-4-git-send-email-liguozhu@hisilicon.com>
 <2142879.tTtWetb0nc@wuerfel>
Message-ID: <20150817091750.GA134983@Turing-Arch-b>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks, Arnd, 

You are right. This is the same IP as hip04_mdio.c. We just mis-understand the
hardware design. We will merge them and re-submit the patches.

On Fri, Aug 14, 2015 at 10:57:28PM +0200, Arnd Bergmann wrote:
> On Friday 14 August 2015 18:30:20 Kenneth Lee wrote:
> 
> > +#define MDIO_BASE_ADDR                 0x403C0000
> 
> Does not belong in here (and is not used)
> 
> > +#define MDIO_COMMAND_REG               0x0
> > +#define MDIO_ADDR_REG                  0x4
> > +#define MDIO_WDATA_REG                 0x8
> > +#define MDIO_RDATA_REG                 0xc
> > +#define MDIO_STA_REG                   0x10
> 
> These look suspiciously similar to definitions from
> drivers/net/ethernet/hisilicon/hip04_mdio.c.
> 
> Could the hardware be related? If so, please try to share
> the common parts.
> 
> > +static inline void mdio_write_reg(void *base, u32 reg, u32 value)
> > +{
> > +       u8 __iomem *reg_addr = ACCESS_ONCE(base);
> > +
> > +       writel(value, reg_addr + reg);
> > +}
> > +
> > +#define MDIO_WRITE_REG(a, reg, value) \
> > +       mdio_write_reg((a)->vbase, (reg), (value))
> > 
> 
> Something seems wrong here: why do you have an ACCESS_ONCE() on a
> local variable? Doesn't this just make the code less efficient
> without providing lockless access to shared variables?
> 
> The types are inconsistent here, you should get a warning from
> running this through 'make C=1' because of the missing __iomem
> annotation of the pointer.
> 
> Also, why both a macro and an inline function? Just use an inline
> function.
> 
> 	Arnd
