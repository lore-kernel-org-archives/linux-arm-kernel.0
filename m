From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Mon, 20 Feb 2017 07:47:42 -0800
Subject: [PATCH v5 0/4] i.MX7 PCI support
In-Reply-To: <20170220153025.32096-1-andrew.smirnov@gmail.com>
References: <20170220153025.32096-1-andrew.smirnov@gmail.com>
Message-ID: <CAHQ1cqH3doxS_HHACXF3goJNQsm17cr5-7Xn1T18ZAY=nSTrmA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ugh. Forgot to add correct CC list to patches #2 and #3 and drop
Lucas' Reviewed-by from patch #4 since code there changed. Please
ignore this thread. I'll resend all of the patches with aforementioned
corrections shortly.

Sorry for the noise.
Andrey

On Mon, Feb 20, 2017 at 7:30 AM, Andrey Smirnov
<andrew.smirnov@gmail.com> wrote:
> Hello, everyone:
>
> This is a fifth iteration of the code that adds PCI-subsystem bits
> necessary for enabling PCI support on i.MX7.
>
> Rob, Bjorn, power domain and reset bindings remained the same, please
> let me know if you still think that PHY aspect of the driver needs to
> be moved into a separate abstraction.
>
> Changes since v4 (can be found at [version4]):
>
>         - Dropped typo-fix patch (originally patch #1 of the
>           series). Bjorn, I am assuming that patch from v4 survived
>           and stayed in your tree, let me know if that is not true.
>
>         - Added patch with workaround to address speed change false
>           failures (I kept it as a separate patch to better document
>           exchange with NXP/Freescale that lead to that patch)
>
>         - Added patch to avoid speed change on links configured Gen1
>           only (Let me know if that is a terrible idea)
>
>         - Addressed section mismatch problem by moving call to
>           hook_fault_code to happend before driver registration.
>
> Changes since v3 (can be found at [version3]):
>         - Move all of the reset_control_assert's into imx6_pcie_assert_core_reset
>         - Documented required reset and power domain DT bindings
>
> Changes since v2 (can be found at [version2]):
>
>         - Collected Reviewed-by for patch #2 from Lucas
>         - Reset logic implementation moved out into a reset controller
>           driver (see [reset1])
>         - Removed unused leftover code
>
> Changes since v1 (can be found at [version1]):
>
>         - All GPC related code moved into a separate driver (see [gpc1])
>         - Removed GPIO probe deferral logging
>         - Fixed section mismatch warning
>         - Minor reformatting of fsl,imx6q-pcie.txt(as per Rob
>           Herring's request)
>
> [version4] https://lkml.org/lkml/2017/2/7/478
> [version3] https://lkml.org/lkml/2017/2/6/565
> [version2] https://lkml.org/lkml/2017/2/1/510
> [version1] https://lkml.org/lkml/2017/1/19/488
> [gpc1] https://lkml.org/lkml/2017/2/6/551
> [reset1] https://lkml.org/lkml/2017/2/6/554
>
> Andrey Smirnov (4):
>   PCI: imx6: Add code to support i.MX7D
>   PCI: imx6: Do not wait for speed change on i.MX7
>   PCI: imx6: Do not switch speed if Gen2 is disabled
>   PCI: imx6: Allow probe deferal by reset GPIO
>
>  .../devicetree/bindings/pci/fsl,imx6q-pcie.txt     |  13 +-
>  drivers/pci/host/pci-imx6.c                        | 199 +++++++++++++++------
>  include/linux/mfd/syscon/imx7-iomuxc-gpr.h         |   4 +
>  3 files changed, 161 insertions(+), 55 deletions(-)
>
> --
> 2.9.3
>
