From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Fri, 11 Jan 2013 16:45:16 +0100
Subject: [PATCH 10/14] PCI: tegra: Move PCIe driver to drivers/pci/host
In-Reply-To: <201301111536.14799.arnd@arndb.de>
References: <1357764194-12677-1-git-send-email-thierry.reding@avionic-design.de>
 <50EF54B6.6010100@wwwdotorg.org>
 <20130111034015.GA28094@avionic-0098.adnet.avionic-design.de>
 <201301111536.14799.arnd@arndb.de>
Message-ID: <20130111154516.GA25335@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 11, 2013 at 03:36:14PM +0000, Arnd Bergmann wrote:
> On Friday 11 January 2013, Thierry Reding wrote:
> > Right, it'll need #ifdefs around the arch_{setup,teardown}_msi_irq(). Or
> > select PCI_MSI unconditionally. Once this is merged I was going to post
> > a patch that enables PCI_MSI in tegra_defconfig anyway. But it might be
> > better to keep it optional anyway since the remainder of the code copes
> > with it properly.
> > 
> Actually, we need something better than that. You cannot define
> arch_setup_msi_irq in a tegra specific pci host driver, because that
> will seriously mess up other platforms in multiplatform configurations
> by giving a link error when they also define this function, or with a
> run-time error when they don't support it.
> 
> I think what we should do here is fix it the right way by adding
> a pci host specific callback rather than an architecture specific
> callback in drivers/pci/msi.c. There is already a default version
> of arch_setup_msi_irqs (with s), and we can probably do the
> same for arch_setup_msi_irq (without s) to fall back to the
> arch version for most architectures.
> Most architectures (at least powerpc, sparc, ia64 and x86) already
> multiplex the msi handlers internally, but ARM does not because
> there is only one implementation (iop33x) at the moment.
> 
> We can add a generix multiplex and then move architectures over to
> use it.

I already hinted at that in one of the other subthreads. Having such a
multiplex would also allow the driver to be built as a module. I had
already thought about this when I was working on an earlier version of
these patches. Basically these would be two ops attached to the host
bridge, and the generic arch_setup_msi_irq() could then look that up
given the struct pci_dev that is passed to it and call this new per-
host bridge .setup_msi_irq().

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130111/2731df24/attachment.sig>
