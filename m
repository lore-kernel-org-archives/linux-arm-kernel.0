From: fujita.tomonori@lab.ntt.co.jp (FUJITA Tomonori)
Date: Thu, 9 Jun 2011 09:07:02 +0900
Subject: [PATCH v2 1/3] dmaengine: add new dma API for max_segment_number
In-Reply-To: <BANLkTikFKr+3Qph+CR40SUV-DCir1v=KBg@mail.gmail.com>
References: <BANLkTi=FcNncT_6HpvB_6OnQ94f0_sz7Gw@mail.gmail.com>
	<20110608160844E.fujita.tomonori@lab.ntt.co.jp>
	<BANLkTikFKr+3Qph+CR40SUV-DCir1v=KBg@mail.gmail.com>
Message-ID: <20110609090403I.fujita.tomonori@lab.ntt.co.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 8 Jun 2011 13:05:57 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Perhaps, but this sounds like the reverse of what happens today where
> scsi device drivers with knowledge of their own hardware will tell the
> midlayer/subsystem the restriction.  The change with regard to this
> patch is that the scsi device driver (for example) will recognize that
> the device it is driving will not be a bus master and will arrange to
> allocate a dma channel from dmaengine.  When said scsi driver reports
> the dma restrictions to the subsystem it will borrow the parameters
> from the dma channel, not the scsi device.  So yes, I still think it
> should be whatever the dma channel says.
> 
> Although, you've been doing scsi work longer than I, so maybe I'm
> overlooking something...?
> 
> Are there any cases today where the subsystem imposes tighter
> restrictions on the dma geometry than what the device reports?  Even

Yeah, there are already lots.

SCSI-mid layer set the max sg entries to 128 on many architectures
(see SCSI_MAX_SG_CHAIN_SEGMENTS).

SCSI HBA drivers stores the max sg entries in scsi_host structure.

SCSI-mid layer sets the tighter one (see __scsi_alloc_queue).

	blk_queue_max_segments(q, min_t(unsigned short, shost->sg_tablesize,
					SCSI_MAX_SG_CHAIN_SEGMENTS));

As you know, modern SCSI HBA can handle more sg entries than 128.


> if that were the case it would be same situation that the scsi device
> driver reports maximum parameters, but the subsystem opts for
> something tighter.  Whether the maximal parameters come from the scsi
> device or the dma channel is moot.

If only you convert all the SCSI HBA drivers to store the limit of sg
entries in struct device_dma_parameters and use the proposed API.

I can't find any description in this patchset about how we will
convert software that already set the limit of max sg entries in a
different way.

I don't think that this patchset needs to convert the SCSI (and other
software layers setting the limit of max sg entries). But I think that
we need a new rule, the data structure, and the API about how and
where everyone sets the dma restrictions and tells them to the upper
software layers.
