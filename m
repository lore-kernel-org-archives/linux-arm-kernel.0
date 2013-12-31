From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 31 Dec 2013 23:21:24 +0100
Subject: Openblocks AX3-4 i2c bus lockup
In-Reply-To: <52C2BD9A.9080303@gmail.com>
References: <20131221164151.GF20115@lunn.ch>
 <CADx9zJDbzUmgHCRn9K=8m_d_uiSAYoW3y_NVfLFiDq4WzS3C0A@mail.gmail.com>
 <52C2A5C8.7040201@free-electrons.com>
 <52C2B889.4030903@free-electrons.com> <52C2BD9A.9080303@gmail.com>
Message-ID: <20131231222124.GJ32537@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >We can have this information in the same way that it is currently done
> >by the other mvebu SoC: accessing the PCIE_DEV_REV_OFF register. In
> >arch/arm/plat-orion/pcie.c there were functions named
> >orion_pcie_dev_id() and orion_pcie_dev_id() to retrieve information
> >about the CPU variant and its version.
> 
> Depending on running pcie when calling is tricky, as it can be clock
> gated. Maybe we should have some mach code to get the SoC revision
> early for all SoCs. That should look for a pcie controller node,
> enable the clock, store the revision once, and disable the clock
> again. The callback can then return the stored value.

I think this is something we need, not just for this i2c problem, but
for other issues, in particular, helping userspace get the right DT
file.

We already have kirkwood-ts219-6281.dts and kirkwood-ts219-6282.dts,
different QNAP 21X variants which differ by SoC. I will soon be adding
kirkwood-ts419-6281.dts and kirkwood-ts419-6282.dts, once testing is
complete.

It would be nice if the Debian installer can figure out which variant
is needed. I don't think we currently reliably export this information
to user space. We do print it at boot time, but there is no guarantee
it will still be there later. lspci does not seem to show it, and that
assumes PCIe devices are actually enabled in the DT, which for
ts219-6181 they are not.

At the moment, PCI_MVEBU is a bool in Kconfig. It is either built in,
or not available. That helps a little, but not too much. It could be
the i2c driver gets probed before PCI. Also, for Dove, PCI is
optional, since things like CuBox does not have any use of PCI.  

So maybe some mach code would be best, which directly peeks the PCIe
registers, and twiddles the clocks as needed. We can hard code the
addresses, and use dt_compat to determine which set of addresses to
use, and do it from init_machine, so we don't need to worry about what
the PCIe and clock drivers are doing.

    Andrew
