From: balbi@ti.com (Felipe Balbi)
Date: Thu, 27 Aug 2015 08:02:18 -0500
Subject: CONFIG_DEBUG_SHIRQ and PM
In-Reply-To: <CAAEAJfAPB1N-xcz+HbHCcF8JaXAVL05CSwpQGi7ea+114mMpmw@mail.gmail.com>
References: <20150825195830.GH27534@saruman.tx.rr.com>
 <CAAEAJfCY1BRuoQCWfD2pCq36E54vDB5Coy2S7rz3RfL2BVLGaw@mail.gmail.com>
 <20150826193820.GT14625@saruman.tx.rr.com>
 <CAAEAJfAPVgxhRnfYJYzebFJDRJ4Ooam6n+0B5HJ-+uLJ0exTLA@mail.gmail.com>
 <20150826200300.GU14625@saruman.tx.rr.com>
 <CAAEAJfB3iiRENEKm6xx-kLae5AR6BV0XVo0KNkb8-okvLjhFhg@mail.gmail.com>
 <20150826202429.GV14625@saruman.tx.rr.com>
 <CAAEAJfAPB1N-xcz+HbHCcF8JaXAVL05CSwpQGi7ea+114mMpmw@mail.gmail.com>
Message-ID: <20150827130218.GA4701@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 26, 2015 at 05:36:24PM -0300, Ezequiel Garcia wrote:
> On 26 August 2015 at 17:24, Felipe Balbi <balbi@ti.com> wrote:
> [..]
> >>
> >> static irqreturn_t tw68_irq(int irq, void *dev_id)
> >> {
> >>         struct tw68_dev *dev = dev_id;
> >>         u32 status, orig;
> >>         int loop;
> >>
> >>         status = orig = tw_readl(TW68_INTSTAT) & dev->pci_irqmask;
> >
> > Now try to read that register when your clock is gated. That's the
> > problem I'm talking about. Everything about the handler is functioning
> > correctly; however clocks are gated in ->remove() and free_irq() is
> > only called *AFTER* ->remove() has returned.
> >
> 
> Yeah, it's pretty clear you are talking about clocks here. That's
> why I said "read won't stall" in the next paragraph.
> 
> >>         [etc]
> >> }
> >>
> >> The IRQ handler accesses the device struct and then
> >> reads through PCI. So if you use devm_request_irq
> >> you need to make sure the device struct is still allocated
> >> after remove(), and the PCI read won't stall or crash.
> >
> > dude, that's not the problem I'm talking about. I still have my
> > private_data around, what I don't have is:
> >
> >               _            _
> >   __ _    ___| | ___   ___| | __
> >  / _` |  / __| |/ _ \ / __| |/ /
> > | (_| | | (__| | (_) | (__|   <
> >  \__,_|  \___|_|\___/ \___|_|\_\
> >
> >
> 
> Yes, *you* may have your private data around and have a clock gated,
> others (the tw68 for instance) may have its region released and unmapped.
> 
> And yet others may have $whatever resource released in the
> remove() and assume it's available in the IRQ handler.
> 
> I honestly can't think why using request_irq / free_irq to solve this
> is a workaround.

because it'll, eventually, boil down to not using devm_* at all and
that's pretty stupid.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150827/d7668b03/attachment.sig>
