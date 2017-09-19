From: robh@kernel.org (Rob Herring)
Date: Tue, 19 Sep 2017 09:53:14 -0500
Subject: [PATCH v7 1/5] Doc: iommu/arm-smmu-v3: Add workaround for
 HiSilicon erratum 161010801
In-Reply-To: <20170914125756.14836-2-shameerali.kolothum.thodi@huawei.com>
References: <20170914125756.14836-1-shameerali.kolothum.thodi@huawei.com>
 <20170914125756.14836-2-shameerali.kolothum.thodi@huawei.com>
Message-ID: <20170919145314.2irmqpsfneeydupo@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 14, 2017 at 01:57:52PM +0100, Shameer Kolothum wrote:
> From: John Garry <john.garry@huawei.com>
> 
> The HiSilicon erratum 161010801 describes the limitation of HiSilicon platforms
> hip06/hip07 to support the SMMU mappings for MSI transactions.
> 
> On these platforms, GICv3 ITS translator is presented with the deviceID
> by extending the MSI payload data to 64 bits to include the deviceID.
> Hence, the PCIe controller on this platforms has to differentiate the MSI
> payload against other DMA payload and has to modify the MSI payload.
> This basically makes it difficult for this platforms to have a SMMU
> translation for MSI.
> 
> This patch adds a SMMUv3 binding to flag that the SMMU breaks msi
> translation at ITS.
> 
> Also, the arm64 silicon errata is updated with this same erratum.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  Documentation/arm64/silicon-errata.txt                  | 1 +
>  Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt | 3 +++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/Documentation/arm64/silicon-errata.txt b/Documentation/arm64/silicon-errata.txt
> index 66e8ce1..02816b1 100644
> --- a/Documentation/arm64/silicon-errata.txt
> +++ b/Documentation/arm64/silicon-errata.txt
> @@ -70,6 +70,7 @@ stable kernels.
>  |                |                 |                 |                             |
>  | Hisilicon      | Hip0{5,6,7}     | #161010101      | HISILICON_ERRATUM_161010101 |
>  | Hisilicon      | Hip0{6,7}       | #161010701      | N/A                         |
> +| Hisilicon      | Hip0{6,7}       | #161010801      | N/A                         |
>  |                |                 |                 |                             |
>  | Qualcomm Tech. | Falkor v1       | E1003           | QCOM_FALKOR_ERRATUM_1003    |
>  | Qualcomm Tech. | Falkor v1       | E1009           | QCOM_FALKOR_ERRATUM_1009    |
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
> index c9abbf3..1f5f7f9 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
> @@ -55,6 +55,9 @@ the PCIe specification.
>  - hisilicon,broken-prefetch-cmd
>                      : Avoid sending CMD_PREFETCH_* commands to the SMMU.
>  
> +- hisilicon,broken-untranslated-msi
> +                    : Reserve ITS HW region to avoid translating msi.
> +

This should be determined from the compatible string. Continuing to add 
properties for each errata doesn't scale.

>  - cavium,cn9900-broken-page1-regspace
>                      : Replaces all page 1 offsets used for EVTQ_PROD/CONS,
>  		      PRIQ_PROD/CONS register access with page 0 offsets.
> -- 
> 1.9.1
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
