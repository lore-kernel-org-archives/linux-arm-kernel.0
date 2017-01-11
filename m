From: helgaas@kernel.org (Bjorn Helgaas)
Date: Wed, 11 Jan 2017 16:02:35 -0600
Subject: CONFIG_PCIEASPM breaks PCIe on Marvell Armada 385 machine
In-Reply-To: <20170111194942.q5rdma2es6hkmxfe@perseus.defre.kleine-koenig.org>
References: <20170111194942.q5rdma2es6hkmxfe@perseus.defre.kleine-koenig.org>
Message-ID: <20170111220235.GP14532@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On Wed, Jan 11, 2017 at 08:49:46PM +0100, Uwe Kleine-K?nig wrote:
> Hello,
> 
> on an Marvell Armada 385 based machine (Turris Omnia) with 4.9 the
> ath10k driver fails to bind to the matching hardware if CONFIG_PCIEASPM
> is enabled:
> 
> # dmesg | grep ath
> [    7.207770] ath10k_pci 0000:02:00.0: Refused to change power state, currently in D3
> [    7.237955] ath10k_pci 0000:02:00.0: failed to wake up device : -110
> [    7.238146] ath10k_pci: probe of 0000:02:00.0 failed with error -110
> 
> if however PCIEASPM is off, the driver probes correctly and the ath10k
> adapter works fine.
> 
> I wonder if someone has an idea what needs to be done to fix this
> problem. (OK, I could disable PCIEASPM, but I'd like to have a solution
> for a distribution kernel where I think PCIEASPM=y is sensible in
> general.)

PCIEASPM=y is definitely sensible and disabling ASPM is OK for a
workaround but is not a fix.

We have several open issues related to ASPM:

  https://bugzilla.kernel.org/show_bug.cgi?id=102311 ASPM: ASMEDA asm1062 not working
  https://bugzilla.kernel.org/show_bug.cgi?id=187731 Null pointer dereference in ASPM
  https://bugzilla.kernel.org/show_bug.cgi?id=189951 Enabling ASPM causes NIC performance issue
  https://bugzilla.kernel.org/show_bug.cgi?id=60111 NULL pointer deref in ASPM alloc_pcie_link_state()

I don't recognize yours as being one of these.  Can you open a new
issue and attach the complete dmesg log and "lspci -vv" output?

Is this a regression?

Bjorn
