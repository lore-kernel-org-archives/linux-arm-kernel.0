From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 12 Oct 2015 09:15:44 +0200
Subject: [PATCH v2] PCI: layerscape: Add PCIe support for LS1043a and
 LS2080a
In-Reply-To: <20151011191027.GA29221@localhost>
References: <1442481219-28299-1-git-send-email-Minghuan.Lian@freescale.com>
 <20151007175725.GC27633@localhost>
 <20151011191027.GA29221@localhost>
Message-ID: <20151012091544.7dbbe330@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bjorn,

On Sun, 11 Oct 2015 14:10:27 -0500, Bjorn Helgaas wrote:

> > driver/of/irq.c  void of_msi_configure(struct device *dev, struct
> > device_node *np) will bind "msi-parent" to each device if there is
> > "msi-parent" handler. The PCIe driver do not need to do anything. If
> > we do not check "msi-parent" here, we will have no chance to check it.
> > The common code of 'of' and 'pci' bus driver will not complain,
> > because the msi controller may be found by other way.
> 
> Hmm.   In mvebu_pcie_msi_enable() and xgene_pcie_msi_enable(), we
> also look for "msi-parent".  If that fails, mvebu continues silently
> and xgene complains (but only if CONFIG_PCI_MSI=y).

I don't really have the context of the discussion here. But the reason
why the mvebu pcie driver silently continues if msi-parent is missing
is because we initially introduced the PCIe mvebu Device Tree binding
without MSI support. When we later added MSI support thanks to the
msi-parent property, we wanted to preserve backward compatibility with
old DTs that didn't had the msi-parent property. Such DTs would
continue to work, albeit without the MSI functionality obviously.

Other drivers that had the MSI functionality from day 1 may want to
make such a property mandatory rather than optional.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
