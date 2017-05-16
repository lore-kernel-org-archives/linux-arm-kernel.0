From: robh@kernel.org (Rob Herring)
Date: Mon, 15 May 2017 19:15:51 -0500
Subject: [v6 2/3] iommu/arm-smmu-v3: Add workaround for Cavium ThunderX2
 erratum #74
In-Reply-To: <1494592866-14076-3-git-send-email-gakula@caviumnetworks.com>
References: <1494592866-14076-1-git-send-email-gakula@caviumnetworks.com>
 <1494592866-14076-3-git-send-email-gakula@caviumnetworks.com>
Message-ID: <CAL_Jsq+FC8=T9pi7XpMHoqDSUW6c9o14=ybS8BP0fS_Q432NxQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DT changes should go to DT list.

On Fri, May 12, 2017 at 7:41 AM, Geetha sowjanya
<gakula@caviumnetworks.com> wrote:
> From: Linu Cherian <linu.cherian@cavium.com>
>
> Cavium ThunderX2 SMMU implementation doesn't support page 1 register space
> and PAGE0_REGS_ONLY option is enabled as an errata workaround.
> This option when turned on, replaces all page 1 offsets used for
> EVTQ_PROD/CONS, PRIQ_PROD/CONS register access with page 0 offsets.
>
> SMMU resource size checks are now based on SMMU option PAGE0_REGS_ONLY,
> since resource size can be either 64k/128k.
> For this, arm_smmu_device_dt_probe/acpi_probe has been moved before
> platform_get_resource call, so that SMMU options are set beforehand.
>
> Signed-off-by: Linu Cherian <linu.cherian@cavium.com>
> Signed-off-by: Geetha Sowjanya <geethasowjanya.akula@cavium.com>
> ---
>  Documentation/arm64/silicon-errata.txt             |  1 +
>  .../devicetree/bindings/iommu/arm,smmu-v3.txt      |  6 ++
>  drivers/iommu/arm-smmu-v3.c                        | 64 +++++++++++++++++-----
>  3 files changed, 56 insertions(+), 15 deletions(-)
>
> diff --git a/Documentation/arm64/silicon-errata.txt b/Documentation/arm64/silicon-errata.txt
> index 10f2ddd..4693a32 100644
> --- a/Documentation/arm64/silicon-errata.txt
> +++ b/Documentation/arm64/silicon-errata.txt
> @@ -62,6 +62,7 @@ stable kernels.
>  | Cavium         | ThunderX GICv3  | #23154          | CAVIUM_ERRATUM_23154        |
>  | Cavium         | ThunderX Core   | #27456          | CAVIUM_ERRATUM_27456        |
>  | Cavium         | ThunderX SMMUv2 | #27704          | N/A                         |
> +| Cavium         | ThunderX2 SMMUv3| #74             | N/A                         |
>  |                |                 |                 |                             |
>  | Freescale/NXP  | LS2080A/LS1043A | A-008585        | FSL_ERRATUM_A008585         |
>  |                |                 |                 |                             |
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
> index be57550..e6da62b 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
> @@ -49,6 +49,12 @@ the PCIe specification.
>  - hisilicon,broken-prefetch-cmd
>                      : Avoid sending CMD_PREFETCH_* commands to the SMMU.
>
> +- cavium-cn99xx,broken-page1-regspace

"cavium-cn99xx" is not a vendor.

I'm sure you have an SoC specific compatible string, so use that to
enable any errata work-arounds.

Rob
