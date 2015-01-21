From: l.stach@pengutronix.de (Lucas Stach)
Date: Wed, 21 Jan 2015 20:59:21 +0100
Subject: [PATCH 3/5] PCI: st: Provide support for the sti PCIe controller
In-Reply-To: <6574269.bTBzFhcnBx@wuerfel>
References: <1418812486-12394-1-git-send-email-gabriel.fernandez@linaro.org>
 <1682713.ac5OoTJoOr@wuerfel>
 <CAG374jCRByNZuuYxi5+-mKvV7p5-tCf2G+8mTYfzU4rRV4yfYQ@mail.gmail.com>
 <6574269.bTBzFhcnBx@wuerfel>
Message-ID: <1421870361.3430.12.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, den 21.01.2015, 20:35 +0100 schrieb Arnd Bergmann:
> On Wednesday 21 January 2015 16:47:36 Gabriel Fernandez wrote:
> > On 19 January 2015 at 14:49, Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Monday 19 January 2015 13:37:33 Gabriel Fernandez wrote:
> > >> On 17 December 2014 at 23:14, Arnd Bergmann <arnd@arndb.de> wrote:
> > >> > On Wednesday 17 December 2014 11:34:44 Gabriel FERNANDEZ wrote:
> > >> > > +/*
> > >> > > + * On ARM platforms, we actually get a bus error returned when the PCIe
> > >> > IP
> > >> > > + * returns a UR or CRS instead of an OK.
> > >> > > + */
> > >> > > +static int st_pcie_abort_
> > >> >
> > >> > handler(unsigned long addr, unsigned int fsr,
> > >> > > +                              struct pt_regs *regs)
> > >> > > +{
> > >> > > +     return 0;
> > >> > > +}
> > >> >
> > >> > You should check that it's actually PCI that caused the abort. Don't
> > >> > just ignore a hard error condition.
> > >> >
> > >> > Usually there are registers in the PCI core that let you identify what
> > >> > happened.
> > >> >
> > >>
> > >>
> > >> We return 0 because abort handler is not activated during boot.
> > >>
> > >
> > > Can you just remove the handler then? We should never have exception
> > > handlers that unconditionally return 0.
> > >
> > 
> > Ah sorry, we need the handler because we can received aborts from
> > user-land after the boot.
> > 
> > I have 2 solutions, the first to simplify we can only return 0.
> > The second is to manage handler during boot. Then i need for that a
> > new patch from Fabrice
> > https://lkml.org/lkml/2014/2/7/631
> 
> I still don't get it. What is causing the abort? Is that something
> user space does, or is it just a condition that gets stuck the pcie
> device after probing that gets delivered once as soon as the aborts
> are enabled?
> 
The abort is caused by the kernel trying to access a non-existent device
while probing the bus. It isn't delivered to the ARM core, as it is an
imprecise external abort which are masked during boot.
Once pid1 is started and we do the first schedule imprecise aborts get
unmasked and pid1 will be hit by the stale abort.

The above patch does the right thing by unmasking imprecise abort early
during boot, so they can get handled once they are hit.

The abort handling for the DW PCIe core right now is a complete
disaster. Hooking the fault code means we possibly overwrite any other
handler for the same abort. Also as the configuration space is mapped as
device memory the abort actually happens on the *next* instruction after
the read that caused it. Improving this is something I had on my to-do
list for quite some time now. 

Regards,
Lucas
