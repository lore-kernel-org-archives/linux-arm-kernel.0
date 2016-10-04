From: helgaas@kernel.org (Bjorn Helgaas)
Date: Tue, 4 Oct 2016 12:40:51 -0500
Subject: ks_dw_pcie_initiate_link_train() question
Message-ID: <20161004174051.GE3449@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Murali,

This code looks suspicious.  Can you comment?

    void ks_dw_pcie_initiate_link_train(struct keystone_pcie *ks_pcie)
    {
        u32 val;

        /* Disable Link training */
        val = readl(ks_pcie->va_app_base + CMD_STATUS);
        val &= ~LTSSM_EN_VAL;
        writel(LTSSM_EN_VAL | val,  ks_pcie->va_app_base + CMD_STATUS);

Here we cleared the LTSSM_EN_VAL bit in "val", but then we add it
right back in before writing it back to CMD_STATUS.

That looks like a cut and paste error to me, but of course I don't
know the hardware.

        /* Initiate Link Training */
        val = readl(ks_pcie->va_app_base + CMD_STATUS);
        writel(LTSSM_EN_VAL | val,  ks_pcie->va_app_base + CMD_STATUS);
    }
