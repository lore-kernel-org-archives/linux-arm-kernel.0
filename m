From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 25 Jan 2017 19:02:24 +0900
Subject: [PATCH/RFC 1/2] arm64: mm: Silently allow devices lacking IOMMU
 group
In-Reply-To: <66c082c6-da2e-9765-0db8-e0ba2c5bd501@arm.com>
References: <148517349585.18128.10696161017872202809.sendpatchset@little-apple>
 <148517353630.18128.12799811817831597628.sendpatchset@little-apple>
 <66c082c6-da2e-9765-0db8-e0ba2c5bd501@arm.com>
Message-ID: <CANqRtoSczM8U+u6ke0cqJ06EExqqQtt-dagqXFJ7CTeB01x=oA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,

On Mon, Jan 23, 2017 at 9:34 PM, Robin Murphy <robin.murphy@arm.com> wrote:
> Hi Magnus,
>
> On 23/01/17 12:12, Magnus Damm wrote:
>> From: Magnus Damm <damm+renesas@opensource.se>
>>
>> Consider failure of iommu_get_domain_for_dev() as non-critical and
>> get rid of the warning printout. This allows IOMMU properties to be
>> included in the DTB even though the kernel is configured with
>> CONFIG_IOMMU_API=n or in case a particular IOMMU driver refuses to
>> enable IOMMU support for a certain slave device and returns error
>> from the ->add_device() callback.
>>
>> This is only a cosmetic change that removes console warning printouts.
>
> The warning is there for a reason - at this point, we *expected* the
> device to be using an IOMMU for DMA, so a failure is significant. Rather
> than masking genuine failures in other cases because your case
> deliberately breaks that expectation, simply change the expectation -
> i.e. rather than letting of_xlate() succeed then failing add_device()
> later, reject the of_xlate() call up-front such that the DMA layer never
> gets told about the IOMMU in the first place.

Thanks for pointing me in the right direction! I will try to handle
this in xlate() instead.

Cheers,

/ magnus
