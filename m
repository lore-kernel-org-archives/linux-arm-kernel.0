From: will.deacon@arm.com (Will Deacon)
Date: Wed, 23 May 2018 17:42:20 +0100
Subject: [PATCH] perf: hisi: fix uncore PMU index ID
In-Reply-To: <a301d72f-687c-0c4f-1d44-83e5bbad5e60@hisilicon.com>
References: <1526901317-52248-1-git-send-email-zhangshaokun@hisilicon.com>
 <20180521170554.GE21034@arm.com>
 <a301d72f-687c-0c4f-1d44-83e5bbad5e60@hisilicon.com>
Message-ID: <20180523164219.GG2983@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 22, 2018 at 05:18:51PM +0800, Zhangshaokun wrote:
> On 2018/5/22 1:05, Will Deacon wrote:
> > Whilst I'd normally just accept PMU driver submissions for vendor PMUs,
> > this part rang my alarm bells:
> > 
> >> diff --git a/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c b/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c
> >> index 443906e..dcd8e77 100644
> >> --- a/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c
> >> +++ b/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c
> >> @@ -238,19 +238,10 @@ MODULE_DEVICE_TABLE(acpi, hisi_hha_pmu_acpi_match);
> >>  static int hisi_hha_pmu_init_data(struct platform_device *pdev,
> >>  				  struct hisi_pmu *hha_pmu)
> >>  {
> >> -	unsigned long long id;
> >>  	struct resource *res;
> >> -	acpi_status status;
> >> -
> >> -	status = acpi_evaluate_integer(ACPI_HANDLE(&pdev->dev),
> >> -				       "_UID", NULL, &id);
> >> -	if (ACPI_FAILURE(status))
> >> -		return -EINVAL;
> >> -
> >> -	hha_pmu->index_id = id;
> >>  
> >>  	/*
> >> -	 * Use SCCL_ID and UID to identify the HHA PMU, while
> >> +	 * Use SCCL_ID and HHA index ID to identify the HHA PMU, while
> >>  	 * SCCL_ID is in MPIDR[aff2].
> >>  	 */
> >>  	if (device_property_read_u32(&pdev->dev, "hisilicon,scl-id",
> >> @@ -258,6 +249,13 @@ static int hisi_hha_pmu_init_data(struct platform_device *pdev,
> >>  		dev_err(&pdev->dev, "Can not read hha sccl-id!\n");
> >>  		return -EINVAL;
> >>  	}
> >> +
> >> +	if (device_property_read_u32(&pdev->dev, "hisilicon,idx-id",
> >> +				     &hha_pmu->index_id)) {
> >> +		dev_err(&pdev->dev, "Can not read hha index-id!\n");
> >> +		return -EINVAL;
> >> +	}
> > 
> > Is this a new DT property? If so, please can you update the binding
> > documentation and get an Ack from a DT maintainer? It's not clear to me
> 
> No, it is not a DT property. We don't support DT mode for this platform and
> only support ACPI mode.

Hmm, but by using the firmware-agnostic "device_property_read_u32"
interface, aren't you implicitly supporting it via DT as well? In fact,
don't you now fail the probe if this new property isn't present? Isn't
that a regression?

> > what a "hisilicon,idx-id" is, nor how I would generate on from firmware.
> > 
> 
> For HiSilicon this platform, it supports multi-sccl. each sccl has more than one uncore
> PMUs. Like HHA uncore PMUs, each sccl has 2-HHA PMUs and idx-id is in _DSD package and
> used to distinguish different HHA PMUs with the same sccl, as follow:
>     Name (_DSD, Package () {
>       ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>       Package () {
>         Package () {"hisilicon,scl-id", 0x03},
>         Package () {"hisilicon,idx-id", 0x00},
>       }
>     })

I'm still none the wiser about what this actually is. How is new _DSD crud
supposed to be documented?

Will
