From: helgaas@kernel.org (Bjorn Helgaas)
Date: Tue, 5 Sep 2017 12:57:01 -0500
Subject: [PATCH 2/2] PCI: iproc: fix Stingray CRS defect handling
In-Reply-To: <20170905072004.3959082-2-arnd@arndb.de>
References: <20170905072004.3959082-1-arnd@arndb.de>
 <20170905072004.3959082-2-arnd@arndb.de>
Message-ID: <20170905175701.GB14367@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 05, 2017 at 09:19:45AM +0200, Arnd Bergmann wrote:
> The condition that was used to detect the PCI_EXP_RTCAP
> flag access is wrong, as pointed out by gcc-8:
> 
> drivers/pci/host/pcie-iproc.c: In function 'iproc_pcie_config_read':
> drivers/pci/host/pcie-iproc.c:531:22: error: bitwise comparison always evaluates to false [-Werror=tautological-compare]
>    if ((where & ~0x3) == PCI_EXP_CAP + PCI_EXP_RTCAP)
> 
> This adds the same bit mask to the other end as well, so the
> condition is evaluated correctly for any access.
> 
> Fixes: ac8d3e852f75 ("PCI: iproc: Work around Stingray CRS defects")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/pci/host/pcie-iproc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
> index d7f4c29aed96..f2df9c2266b9 100644
> --- a/drivers/pci/host/pcie-iproc.c
> +++ b/drivers/pci/host/pcie-iproc.c
> @@ -528,7 +528,7 @@ static int iproc_pcie_config_read(struct pci_bus *bus, unsigned int devfn,
>  			return ret;
>  
>  		/* Don't advertise CRS SV support */
> -		if ((where & ~0x3) == PCI_EXP_CAP + PCI_EXP_RTCAP)
> +		if ((where & ~0x3) == ((PCI_EXP_CAP + PCI_EXP_RTCAP) & ~0x03))
>  			*val &= ~(PCI_EXP_RTCAP_CRSVIS << 16);
>  		return PCIBIOS_SUCCESSFUL;
>  	}

Definitely looks like a bug.  I'm slightly confused because Oza tested
this and reported that lspci said CRS SV was not supported.  But there
used to be an lspci bug related to reporting CRS SV, and there are a
lot of executables that don't have the fix:

http://git.kernel.org/cgit/utils/pciutils/pciutils.git/commit/?id=1cefd379194e

lspci -vvxxx should have enough info to tell for sure.  Oza, any
chance you could apply the incremental patch (or use my pci/host-iproc
branch) and collect that lspci output?

I propose the following slightly different fix because (a) the shift
in the next line depends on the fact that we read the 32-bit value
that contains both PCI_EXP_RTCTL and PCI_EXP_RTCAP so I like the use
of PCI_EXP_RTCTL as a hint that it's involved and (b) there's similar
code in xgene_pcie_config_read32() that uses the equivalent of
PCI_EXP_RTCTL; see

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/host/pci-xgene.c?h=v4.13#n191

diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
index 0e29338703bf..9a006cbc3021 100644
--- a/drivers/pci/host/pcie-iproc.c
+++ b/drivers/pci/host/pcie-iproc.c
@@ -528,7 +528,7 @@ static int iproc_pcie_config_read(struct pci_bus *bus, unsigned int devfn,
 			return ret;
 
 		/* Don't advertise CRS SV support */
-		if ((where & ~0x3) == PCI_EXP_CAP + PCI_EXP_RTCAP)
+		if ((where & ~0x3) == PCI_EXP_CAP + PCI_EXP_RTCTL)
 			*val &= ~(PCI_EXP_RTCAP_CRSVIS << 16);
 		return PCIBIOS_SUCCESSFUL;
 	}
