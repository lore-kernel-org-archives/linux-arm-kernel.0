From: balbi@kernel.org (Felipe Balbi)
Date: Thu, 19 May 2016 21:36:57 +0300
Subject: [RFC PATCH 2/3] mmc: host: omap_hsmmc: Enable ADMA2
In-Reply-To: <20160519145745.GU5995@atomide.com>
References: <1463561115-31798-1-git-send-email-kishon@ti.com>
 <1463561115-31798-3-git-send-email-kishon@ti.com>
 <b66f678a-be74-d5f7-f2ef-93b5c9f29b92@ti.com>
 <20160518193028.GT5995@atomide.com>
 <0d463add-9fa5-a768-2ba6-34c4126c7817@ti.com>
 <20160519145745.GU5995@atomide.com>
Message-ID: <87shxdlws6.fsf@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Tony Lindgren <tony@atomide.com> writes:
> * Peter Ujfalusi <peter.ujfalusi@ti.com> [160519 01:10]:
>> On 05/18/2016 10:30 PM, Tony Lindgren wrote:
>> > Ideally the adma support would be a separate loadable module,
>> > similar how the cppi41dma is a child of the OTG controller.
>> 
>> The Master DMA is part of the hsmmc IP block. If the same ADMA module is
>> present on other IPs it might be beneficial to have a helper library to handle
>> it (allocating the descriptor pool, wrinting, updating descriptors, etc).
>
> OK. Yeah if it's part of the MMC controller it makes no sense to
> separate it. So then the conecrns are using alternate DMA
> implementations and keeping PM runtime working :)
>
> BTW, Felipe mentioned that the best thing to do in the long run would
> be to set up sdhci-omap.c operating in ADMA mode.
>
> Felipe, care to summarize what you had in mind?

yeah, just write a new sdhci-omap.c to start moving away from
omap-hsmmc.c, just like it was done for 8250-omap.

At the beginning, it could be just the bare minimum to get it working
and slowly move over stuff like pm runtime, dmaengine, PIO. Move more
platforms over to that driver and, eventually, get rid of omap-hsmmc.c
altogether.

That way, development can be focussed on generic layers (SDHCI) to which
OMAP MMC controller is compliant (apart from the VERSION register
quirk).

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160519/67d87938/attachment.sig>
