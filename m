From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 9 Jun 2016 11:19:21 +0200
Subject: [PATCH 2/3] PCI: host: new PCI host controller driver for
 Marvell Armada 3700
In-Reply-To: <3112077.0RPfokLCAs@wuerfel>
References: <1464858585-10963-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1464858585-10963-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <3112077.0RPfokLCAs@wuerfel>
Message-ID: <20160609111921.11975627@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, 02 Jun 2016 11:46:04 +0200, Arnd Bergmann wrote:

> > +	timeout = PCIE_LINKUP_TIMEOUT;
> > +	do {
> > +		val = advk_readl(pcie, CFG_REG);
> > +		ltssm_state = (val >> LTSSM_SHIFT) & LTSSM_MASK;
> > +		timeout--;
> > +	/* Use ltssm < LTSSM_L0 instead of ltssm != LTSSM_L0 */
> > +	} while (ltssm_state < LTSSM_L0 && timeout > 0);
> > +
> > +	return (timeout > 0);
> > +}  
> 
> Maybe wait for some amount of time to have passed here (using 
> time_before(jiffies, end)) rather than a number of retries,
> for robustness and determinism.

Will. There was another similar loop in the driver which was doing a
number of retries rather than a timeout-bounded loop, so I've fixed
that one as well.

> > +	/* Point PCIe unit MBUS decode windows to DRAM space. */
> > +	for (i = 0; i < 8; i++)
> > +		advk_pcie_set_ob_win(pcie, i, 0, 0, 0, 0, 0, 0, 0);  
> 
> Is this actually mbus based, or is the comment copied from some
> other Marvell driver?

No, it's not MBUS based, the address decoding logic is very different
from previous mvebu SoCs, I guess it's just a "familiar" name to say
that it's configuring address decoding. I'll remove the comment.

> What is the version of the GIC in the Armada 3700? If you have GICv3
> or GICv2m, could you use that instead of the built-in MSI logic?
> 
> We typically handle this using the msi-map or msi-parent properties
> pointing to either the gic or the PCI host, depending on which one
> you want to use, but either of them should work, and the GIC should
> be more efficient because you can distribute the interrupts of the
> PCI devices over all CPUs by workload, rather than having to
> multiplex all MSI through a single GIC interrupt.

There is a GIC-500, but Marcin told me that attempts to use MSI with it
have not been successful so far. There will be investigation on this
topic in the future, but for the moment, we'd like to have the MSI
functionality built into the PCIe driver supported. We can migrate
later to GIC-500 powered MSIs once working.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
