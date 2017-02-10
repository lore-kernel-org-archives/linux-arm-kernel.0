From: helgaas@kernel.org (Bjorn Helgaas)
Date: Fri, 10 Feb 2017 15:40:17 -0600
Subject: [PATCH v4 0/3] i.MX7 PCI support
In-Reply-To: <20170207155027.7734-1-andrew.smirnov@gmail.com>
References: <20170207155027.7734-1-andrew.smirnov@gmail.com>
Message-ID: <20170210214017.GO29169@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 07, 2017 at 07:50:24AM -0800, Andrey Smirnov wrote:
> Hello, everyone:
> 
> This is a fourth iteration of the code that adds PCI-subsystem bits
> necessary for enabling PCI support on i.MX7.
> 
> Changes since v3 (can be found at [version3]):
> 	- Move all of the reset_control_assert's into imx6_pcie_assert_core_reset
> 	- Documented required reset and power domain DT bindings
> 
> Changes since v2 (can be found at [version2]):
> 
> 	- Collected Reviewed-by for patch #2 from Lucas
> 	- Reset logic implementation moved out into a reset controller
>           driver (see [reset1])
> 	- Removed unused leftover code
> 
> Changes since v1 (can be found at [version1]):
> 
> 	- All GPC related code moved into a separate driver (see [gpc1])
> 	- Removed GPIO probe deferral logging
> 	- Fixed section mismatch warning
> 	- Minor reformatting of fsl,imx6q-pcie.txt(as per Rob
>           Herring's request)
> 
> [version3] https://lkml.org/lkml/2017/2/6/565
> [version2] https://lkml.org/lkml/2017/2/1/510
> [version1] https://lkml.org/lkml/2017/1/19/488
> [gpc1] https://lkml.org/lkml/2017/2/6/551
> [reset1] https://lkml.org/lkml/2017/2/6/554
> 
> Andrey Smirnov (3):
>   PCI: imx6: Fix a typo in error message
>   PCI: imx6: Allow probe deferal by reset GPIO
>   PCI: imx6: Add code to support i.MX7D
> 
>  .../devicetree/bindings/pci/fsl,imx6q-pcie.txt     |  13 +-
>  drivers/pci/host/pci-imx6.c                        | 131 ++++++++++++++++-----
>  include/linux/mfd/syscon/imx7-iomuxc-gpr.h         |   4 +
>  3 files changed, 118 insertions(+), 30 deletions(-)

I applied patches 1 & 3 (with reviewed-by and ack from Lucas and Lee)
to pci/host-imx6 for v4.11, thanks!

I didn't apply 2 because of the section mismatch found by the autobuilder:

  >> WARNING: drivers/built-in.o(.data+0x6948c): Section mismatch in reference from the variable imx6_pcie_driver to the function .init.text:imx6_pcie_probe()
     The variable imx6_pcie_driver references
     the function __init imx6_pcie_probe()
     If the reference is valid then annotate the
     variable with or __refdata (see linux/init.h) or name the variable:

Please repost it after you figure out how to deal with that.

Bjorn
