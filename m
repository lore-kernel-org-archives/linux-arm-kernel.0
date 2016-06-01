From: helgaas@kernel.org (Bjorn Helgaas)
Date: Wed, 1 Jun 2016 14:04:30 -0500
Subject: [PATCH 1/3] pci: introduce read_bridge/write_bridge pci ops
In-Reply-To: <4890460.9IGW89muCc@wuerfel>
References: <1464784332-3775650-1-git-send-email-arnd@arndb.de>
 <20160601150929.GA13882@localhost> <4890460.9IGW89muCc@wuerfel>
Message-ID: <20160601190430.GA19546@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 01, 2016 at 05:41:53PM +0200, Arnd Bergmann wrote:
> On Wednesday, June 1, 2016 10:09:29 AM CEST Bjorn Helgaas wrote:
> > Hi Arnd,
> > 
> > On Wed, Jun 01, 2016 at 02:31:22PM +0200, Arnd Bergmann wrote:
> > > A lot of PCI host bridges require different methods for initiating
> > > type 0 and type 1 config space accesses, leading to duplication of
> > > code.
> > > 
> > > This adds support for the two different kinds at the pci_ops
> > > level, with the newly added map_bridge/read_bridge/write_bridge
> > > operations for type 1 accesses.
> > > 
> > > When these are not set, we fall back to the regular map_bus/read/write
> > > operations, so all existing drivers keep working, and bridges that
> > > have identical operations continue to only require one set.
> > 
> > This adds new config accessor functions to struct pci_ops and makes
> > the callers responsible for figuring out which one to use.  The
> > benefit is to reduce code duplication in some host bridge drivers
> > (DesignWare and MVEBU so far).
> > 
> > From a design perspective, I'm not comfortable with moving this burden
> > from the host bridge drivers to the callers of the config accessors.
> ...

> Maybe we can simply change them to use the normal API and come up with
> a way to make the pci_ops harder to misuse? Would it make you feel better
> if we also renamed .read/.write into .read_type0/.write_type0 or something
> like that?

I'm trying to get a better feel for the tradeoff here.  It seems like
an API complication vs. code duplication.

I don't really think the callers should have to figure out which
accessor to use.  How much of a benefit do we really gain by
complicating the callers?  We've managed for quite a few years with
the current scheme, and it seems like only a couple new ARM platforms
would benefit.

Bjorn
