From: r65037@freescale.com (Zhu Richard-R65037)
Date: Tue, 2 Jul 2013 04:53:22 +0000
Subject: [PATCH 3/4] PCI: Add driver for i.MX6 PCI Express
In-Reply-To: <2E3BDF14016345FA887E3BACAE05DADA@kosagi.com>
References: <1372662947-27160-1-git-send-email-xobs@kosagi.com>
 <1372662947-27160-4-git-send-email-xobs@kosagi.com>
 <51D15513.7020101@st.com> <2E3BDF14016345FA887E3BACAE05DADA@kosagi.com>
Message-ID: <0E83723C55F66F43A6041464FE31119D30C672@039-SN2MPN1-013.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Cross:
First of all, Thanks for your efforts to summit the imx pcie support patches.
I looked through your patch-set, and have some concerns:
* PCIe driver used in the FSL linux-2.6.35 BSP, is not good enough,
Based on the latest FSL BSP.
* The PCIe switch/MSI features had been supported.
* In order to support the 8MB memory space size, the mem layout had been updated as listed below,
 otherwise, the memory space size required by PCIe EP device wouldn't larger than 4MB.
        /*
         * i.MX6 defines 16MB in the AXI address map for PCIe.
         *
         * That address space excepted the pcie registers is
         * split and defined into different regions by iATU,
         * with sizes and offsets as follows:
         *
         * RC:
         * 0x0100_0000 --- 0x01DF_FFFF 14MB IORESOURCE_MEM
         * 0x01E0_0000 --- 0x01EF_FFFF 1MB IORESOURCE_IO
         * 0x01F0_0000 --- 0x01FF_FFFF 1MB Cfg + MSI + Registers
         *
         * EP (default value):
         * 0x0100_0000 --- 0x01FF_C000 16MB - 16KB IORESOURCE_MEM
         */

* BTW, the PCIe EP mode had been verified too.

Best Regards
Richard Zhu


-----Original Message-----
From: linux-pci-owner@vger.kernel.org [mailto:linux-pci-owner at vger.kernel.org] On Behalf Of Sean Cross
Sent: Tuesday, July 02, 2013 11:46 AM
To: Pratyush Anand
Cc: devicetree-discuss at lists.ozlabs.org; linux-pci at vger.kernel.org; linux-arm-kernel at lists.infradead.org; Arnd Bergmann; Mohit KUMAR
Subject: Re: [PATCH 3/4] PCI: Add driver for i.MX6 PCI Express

On Monday, July 1, 2013 at 6:08 PM, Pratyush Anand wrote:
> On 7/1/2013 12:45 PM, Sean Cross wrote:
> > This adds a PCI Express port driver for the on-chip PCI Express port 
> > present on the i.MX6 SoC. It is based on the PCI Express driver 
> > available in the Freescale BSP.
> > 
> > Signed-off-by: Sean Cross <xobs at kosagi.com (mailto:xobs@kosagi.com)>
> > ---
> 
> 
> 
> ...
> 
> > diff --git a/drivers/pci/pcie/pcie-imx.c 
> > b/drivers/pci/pcie/pcie-imx.c new file mode 100644 index 
> > 0000000..664679e
> > --- /dev/null
> > +++ b/drivers/pci/pcie/pcie-imx.c
> 
> 
> 
> Should go to drivers/pci/host/
I'll pull from arm-soc rather than from Linus' tree and place the driver there instead.
 
> > @@ -0,0 +1,1049 @@
> > +/*
> > + * drivers/pci/pcie/pcie-imx.c
> > + *
> 
> 
> 
> ...
> 
> 
> > +#define ATU_R_BaseAddress 0x900
> > +#define PCIE_PL_iATUVR (ATU_R_BaseAddress + 0x0) #define 
> > +PCIE_PL_iATURC1 (ATU_R_BaseAddress + 0x4) #define PCIE_PL_iATURC2 
> > +(ATU_R_BaseAddress + 0x8) #define PCIE_PL_iATURLBA 
> > +(ATU_R_BaseAddress + 0xC) #define PCIE_PL_iATURUBA 
> > +(ATU_R_BaseAddress + 0x10) #define PCIE_PL_iATURLA 
> > +(ATU_R_BaseAddress + 0x14) #define PCIE_PL_iATURLTA 
> > +(ATU_R_BaseAddress + 0x18) #define PCIE_PL_iATURUTA 
> > +(ATU_R_BaseAddress + 0x1C)
> 
> 
> 
> I may be wrong, but from these offset it seems to me that it is SNPS 
> controller. If yes, then please go through comments of "[PATCH V1-10 
> 0/4] PCIe support for Samsung Exynos5440 SoC"

Exynos5440 appears to use the same port logic controller.  However, the PHYs are different.  I'm not exactly certain which comments you want me to notice in that series of patchsets, but I see references to splitting Exynos-specific code into its own project.  Based on that, it seems like the best approach would be to:

    1) Move Exynos code into its own file, say, pcie-exynos.c.  This would leave only Synopsys-specific ATC code in pcie-designware.c
    2) Rename generic exynos functions to reflect the fact that they're designware-generic functions.
    3) Have pcie-imx.c reference this generic designware ATC code.

I'll rework the patch and re-submit it following these three changes.


--
Sean Cross

--
To unsubscribe from this list: send the line "unsubscribe linux-pci" in the body of a message to majordomo at vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
