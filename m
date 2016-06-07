From: helgaas@kernel.org (Bjorn Helgaas)
Date: Mon, 6 Jun 2016 19:28:22 -0500
Subject: [PATCH 1/3] pci: introduce read_bridge/write_bridge pci ops
In-Reply-To: <3585926.N1C2xx3GaB@wuerfel>
References: <1464784332-3775650-1-git-send-email-arnd@arndb.de>
 <4967020.J4dsRYGugq@wuerfel> <20160602140001.GB8262@localhost>
 <3585926.N1C2xx3GaB@wuerfel>
Message-ID: <20160607002822.GA1391@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 02, 2016 at 05:06:55PM +0200, Arnd Bergmann wrote:
> On Thursday, June 2, 2016 9:00:01 AM CEST Bjorn Helgaas wrote:
> > > I just did a count of the implementations of pci_ops: I found 107
> > > instances of 'struct pci_ops', and 67 of them treat type0 and type1
> > > access differently in some form.
> > > 
> > > I'd estimate that about half of them, or roughly a third of the total
> > > instances would benefit from my change, if we were to do them again.
> > > Clearly there is no need to change the existing code here when it works,
> > > unless the benefit is very clear and the code is actively maintained.
> > > 
> > > In some cases, the difference is only that the root bus has a limited
> > > set of devices that are allowed to be accessed, so there would
> > > likely be no benefit of this, compared to e.g. yet another callback
> > > that checks the validity.
> > > Some other instances have type0 registers at a different memory location
> > > from type1, some use different layout inside of that space, and some
> > > are completely different.
> > 
> > The type0/type1 distinction still seems out of place to me at the call
> > site.  Is there any other reason a caller would care about the
> > difference between type0 and type1?
> 
> The callers really shouldn't care, but they also shouldn't call the
> pci_ops function pointer (and as we found earlier, there are only
> three such callers).
> 
> The distinction between type0 and type1 in my mind is an implementation
> detail of the pci_{read,write}_config_{byte,word,dword} functions
> that call the low-level operations here.

The caller is performing one abstract operation: reading or writing
config space of a PCI device.  In the caller's context, it makes no
difference whether it's a type0 or type1 access.

Moving the test from the host bridge driver to pci_read_config_byte()
does move a little code from the callee to the caller, and there are
more callees than callers, so in that sense it does remove code
overall.  If you consider a single driver by itself, I'm not sure it
makes much difference.

The pcie-designware.c patch is a net removal of 17 lines, but that's
not all from moving the type0/type1 test: restructuring along the same
lines but keeping the original type0/type1 test removes about 9 lines.

Anyway, I think I'd rather work first on your RFC patches to make
pci_host_bridge the primary structure for probing PCI.  I think
there will be a *lot* of benefit there.

Bjorn
