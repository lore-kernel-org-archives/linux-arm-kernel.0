From: helgaas@kernel.org (Bjorn Helgaas)
Date: Thu, 22 Oct 2015 13:46:22 -0500
Subject: [PATCH v11 4/6] PCI: hisi: Add PCIe host support for HiSilicon
 SoC Hip05
In-Reply-To: <1444991021-109306-5-git-send-email-wangzhou1@hisilicon.com>
References: <1444991021-109306-1-git-send-email-wangzhou1@hisilicon.com>
 <1444991021-109306-5-git-send-email-wangzhou1@hisilicon.com>
Message-ID: <20151022184622.GD21237@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Zhou,

This looks pretty good to me; just a mask question and add a printk.

On Fri, Oct 16, 2015 at 06:23:39PM +0800, Zhou Wang wrote:
> This patch adds PCIe host support for HiSilicon SoC Hip05.
> ...

> +#define PCIE_SUBCTRL_SYS_STATE4_REG                     0x6818
> +#define PCIE_LTSSM_LINKUP_STATE                         0x11
> +#define PCIE_LTSSM_STATE_MASK                           0x3F

Fabio unified some of this; see
  https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?h=pci/host-designware&id=4788fe6ebf4594c9a95b620cbff05147c8504823
  https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?h=pci/host-designware&id=b09464f77dd252a782da1f4e9925c1dbce4540ac

So the question is, why do you use a 6-bit (0x3f) LTSSM_STATE_MASK?
We think we can use a 5-bit mask (0x1f) for all the other
DesignWare-based systems.

> +/* Hip05 PCIe host only supports 32-bit config access */

Thanks for the comment asserting that Hip05 only supports 32-bit
config access.  I assume you confirmed that with the hardware
designers.  As far as I can tell, this *is* a hardware defect, and at
the minimum, I want a printk at driver probe-time so a dmesg log will
have a clue that read/modify/write on config space might do the wrong
thing.

> +static int hisi_pcie_cfg_read(struct pcie_port *pp, int where, int size,
> +			      u32 *val)
> ...

Bjorn
