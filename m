From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 21 Jan 2015 20:35:41 +0100
Subject: [PATCH 3/5] PCI: st: Provide support for the sti PCIe controller
In-Reply-To: <CAG374jCRByNZuuYxi5+-mKvV7p5-tCf2G+8mTYfzU4rRV4yfYQ@mail.gmail.com>
References: <1418812486-12394-1-git-send-email-gabriel.fernandez@linaro.org>
 <1682713.ac5OoTJoOr@wuerfel>
 <CAG374jCRByNZuuYxi5+-mKvV7p5-tCf2G+8mTYfzU4rRV4yfYQ@mail.gmail.com>
Message-ID: <6574269.bTBzFhcnBx@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 21 January 2015 16:47:36 Gabriel Fernandez wrote:
> On 19 January 2015 at 14:49, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Monday 19 January 2015 13:37:33 Gabriel Fernandez wrote:
> >> On 17 December 2014 at 23:14, Arnd Bergmann <arnd@arndb.de> wrote:
> >> > On Wednesday 17 December 2014 11:34:44 Gabriel FERNANDEZ wrote:
> >> > > +/*
> >> > > + * On ARM platforms, we actually get a bus error returned when the PCIe
> >> > IP
> >> > > + * returns a UR or CRS instead of an OK.
> >> > > + */
> >> > > +static int st_pcie_abort_
> >> >
> >> > handler(unsigned long addr, unsigned int fsr,
> >> > > +                              struct pt_regs *regs)
> >> > > +{
> >> > > +     return 0;
> >> > > +}
> >> >
> >> > You should check that it's actually PCI that caused the abort. Don't
> >> > just ignore a hard error condition.
> >> >
> >> > Usually there are registers in the PCI core that let you identify what
> >> > happened.
> >> >
> >>
> >>
> >> We return 0 because abort handler is not activated during boot.
> >>
> >
> > Can you just remove the handler then? We should never have exception
> > handlers that unconditionally return 0.
> >
> 
> Ah sorry, we need the handler because we can received aborts from
> user-land after the boot.
> 
> I have 2 solutions, the first to simplify we can only return 0.
> The second is to manage handler during boot. Then i need for that a
> new patch from Fabrice
> https://lkml.org/lkml/2014/2/7/631

I still don't get it. What is causing the abort? Is that something
user space does, or is it just a condition that gets stuck the pcie
device after probing that gets delivered once as soon as the aborts
are enabled?

> >>
> >> msi_data is a virtual address, it's obtained through a   __get_free_pages()
> >> function in dw_pcie_msi_init() procedure.
> >
> > I guess you need dma_map_single() then, or use dma_alloc_coherent instead
> > of __get_free_pages(). There is no guarantee that the page you allocate
> > there is actually visible to the PCI host at the same address that the CPU
> > uses, so you need to map from a CPU address to a DMA address that the PCI
> > host bridge uses.
> >
> >         Arnd
> 
> This is only to check the msi magic address given to ip, we never read
> or write in this area.
> this code is only a check

But doesn't the hardware access the pointer?

	Arnd
