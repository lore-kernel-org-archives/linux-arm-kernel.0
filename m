From: adrian.hunter@intel.com (Adrian Hunter)
Date: Wed, 13 Apr 2016 11:07:16 +0300
Subject: [PATCH] ARM: mach-imx: sdhci-esdhc-imx: initialize DMA mask
In-Reply-To: <570DA8C3.5030206@nvidia.com>
References: <1460362846-2906-1-git-send-email-akurz@blala.de>
 <20160411083510.GN10108@pengutronix.de> <570B780E.7090801@intel.com>
 <alpine.DEB.2.00.1604111803080.6072@blala.de> <570C902E.7090607@intel.com>
 <20160412084048.GM19428@n2100.arm.linux.org.uk> <570CC6F2.4090301@intel.com>
 <570CE920.4040204@nvidia.com> <20160412153153.GO19428@n2100.arm.linux.org.uk>
 <570DA8C3.5030206@nvidia.com>
Message-ID: <570DFE34.6040206@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/04/16 05:02, Alexandre Courbot wrote:
> On 04/13/2016 12:31 AM, Russell King - ARM Linux wrote:
>> On Tue, Apr 12, 2016 at 09:25:04PM +0900, Alexandre Courbot wrote:
>>> Clearly these devices need to be fixed. If we want to give them a grace
>>> period, we could also (temporarily) not propagate the return value of
>>> dma_set_mask_and_coherent() and limit ourselves to emitting a big warning
>>> about the inconsistency of having SDHCI_USE_SDMA/SDHCI_USE_ADMA in the host
>>> flags while not setting a dma mask.
>>
>> Isn't it just easier to fix the root problem?  It'll be one patch.
>>
>> There's no need to add churn by changing sdhci stuff, then fixing the
>> imx stuff, and then reverting the sdhci changes.
> 
> I think Adrian was concerned that other SDHCI drivers might unknowingly be
> in the same case.

Yes, that is the concern.

>                   That being said I am also in favor of fixing the root
> issue instead of adding temporary glue that we might eventually forget to
> remove...

Yes, temporary glue just defers the problem.

> 
> How long it will take for everyone to fix their drivers is another question,
> since the device doesn't clearly break, but falls back to a degraded mode
> with a warning.
> 

It looks like DeviceTree, PCI and ACPI enumerated devices always set up a
dma_mask.  I guess that just leaves devices enumerated from hard-coded
platform data.  I will have a look for any more of those, and also send an
email for affected people to check their device setup and drivers.
