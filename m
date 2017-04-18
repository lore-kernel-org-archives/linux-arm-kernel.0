From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 18 Apr 2017 11:37:20 +0530
Subject: [Query] Enabling parent device clock from resume_noirq
Message-ID: <62cd5ee0-3f0c-5e65-5f64-0c91a2a6f1e6@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

resume_noirq callbacks are used in PCIe core to restore PCI state (this
accesses PCI module). So the clocks of PCI module has to be enabled before
resume_noirq.

The clocks for the PCI module in DRA7xx is provided by PIPE3 PHY device which
in turn gets it's clock from OCP2SCP device. During resume_noirq callbacks,
pm_runtime is disabled, so pm_runtime_get_sync is ineffective. However
pm_runtime can be enabled using pm_runtime_force_resume. Now the problem is
adding pm_runtime_force_resume() in resume_noirq callback of pci-dra7xx driver
will enable only the pm_runtime of PCI device but not PIPE3 PHY or OCP2SCP.
Adding pm_runtime_force_resume() in resume_noirq callback of PIPE3 PHY driver
or OCP2SCP driver will not help if the resume_noirq callbacks in PIP3PHY driver
and OCP2SCP driver are invoked after the resume_noirq of pci-dra7xx driver.

How to enable the pm_runtime of parent devices in resume_noirq callback? Does
existing pm_runtime framework has support for that?

Thanks
Kishon
