From: svenkatr@ti.com (Venkatraman S)
Date: Fri, 12 Mar 2010 11:33:18 +0530
Subject: [PATCH 03/03] omap hsmmc: adaptation of sdma descriptor
	autoloading feature
In-Reply-To: <009901cac18b$cc93e5a0$544ff780@am.dhcp.ti.com>
References: <618f0c911003010327s290fcce1ud665b5a16392aea1@mail.gmail.com>
	<011301cac0b6$542b1190$544ff780@am.dhcp.ti.com>
	<618f0c911003110252i36d6fc31wbaef4ad7a17565b1@mail.gmail.com>
	<004401cac137$cccbf0c0$544ff780@am.dhcp.ti.com>
	<618f0c911003110942s2f663928ie1203244fbd32da7@mail.gmail.com>
	<009901cac18b$cc93e5a0$544ff780@am.dhcp.ti.com>
Message-ID: <618f0c911003112203q2bdf88a4s7b8307f1ca8a693c@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Madhusudhan wrote:
>
>
>> -----Original Message-----
>> From: svenkatr at gmail.com [mailto:svenkatr at gmail.com] On Behalf Of
>> Venkatraman S
>> Sent: Thursday, March 11, 2010 11:43 AM
>> To: Madhusudhan
>> Cc: linux-mmc at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
>> linux-omap at vger.kernel.org
>> Subject: Re: [PATCH 03/03] omap hsmmc: adaptation of sdma descriptor
>> autoloading feature
>>
>> Madhusudhan <madhu.cr@ti.com> wrote:
>> >> -----Original Message-----
>> >> From: svenkatr at gmail.com [mailto:svenkatr at gmail.com] On Behalf Of
>> >> Venkatraman S
>> >> Sent: Thursday, March 11, 2010 4:52 AM
>> >> To: Madhusudhan
>> >> Cc: linux-mmc at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
>> >> linux-omap at vger.kernel.org
>> >> Subject: Re: [PATCH 03/03] omap hsmmc: adaptation of sdma descriptor
>> >> autoloading feature
>> >>
>> >> Madhusudhan <madhu.cr@ti.com> wrote:
>> >> >> -----Original Message-----
>> >> >> From: linux-mmc-owner at vger.kernel.org [mailto:linux-mmc-
>> >> >> owner at vger.kernel.org] On Behalf Of Venkatraman S
>> >> >> Sent: Monday, March 01, 2010 5:27 AM
>> >> >> To: linux-mmc at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
>> >> >> linux-omap at vger.kernel.org
>> >> >> Subject: [PATCH 03/03] omap hsmmc: adaptation of sdma descriptor
>> >> >> autoloading feature
>> >> >>
>> >> >> Start to use the sDMA descriptor autoloading feature.
>> >> >> For large datablocks, the MMC driver has to repeatedly setup,
>> program
>> >> >> and teardown the
>> >> >> dma channel for each element of the sglist received in
>> >> omap_hsmmc_request.
>> >> >>
>> >> >> By using descriptor autoloading, transfers from / to each element of
>> >> >> the sglist is pre programmed
>> >> >> into a linked list. The sDMA driver completes the entire transaction
>> >> >> and provides a single interrupt.
>> >> >>
>> >> >> Due to this, number of dma interrupts for a typical 100MB transfer
>> on
>> >> the
>> >> >> MMC is
>> >> >> reduced from 25000 to about 400 (approximate). Transfer speeds are
>> >> >> improved by ~5%
>> >> >> (Though it varies on the size of read / write & improves on huge
>> >> >> transfers)
>> >> >>
>> >> >> Descriptor autoloading is available only in 3630 and 4430 (as of
>> now).
>> >> >> Hence normal DMA
>> >> >> mode is also retained.
>> >> >>
>> >> >> Tested on omap4430 sdp.
>> >> >>
>> >> >> Signed-off-by: Venkatraman S <svenkatr@ti.com>
>> >> >
>> >> > I don't see any issues with this patch except the concern I had on
>> the
>> >> first
>> >> > patch in the series. Why is that change linked to this series?
>> >> >
>> >> ? Thanks. The problem was seen only in the context of using descriptor
>> >> load. Would
>> >> you prefer that I post it as a separate patch ?
>> >
>> > My point is why that change is needed for this feature to work?
>> >
>> > When DMA is completed and a callback is received the ch can be freed.
>> Once
>> > TC is received the core is notified of the same.
>> >
>> > Can the first patch be dropped? Or do you see issues?
>> Yes there are issues without this patch when the scatterlist is large
>> (300+ blocks), where the dma completion interrupt is received but the
>> mmc driver hangs waiting for TC. I don't see the issue if I delay the
>> execution of omap_free_dma inside the dma callback.
>
> This is strange. Ideally after the dma cb is received the transfer complete
> interrupt should fire.
>
> Your first patch would break a corner erroneous case the driver is already
> handling. A scenario where TC was received before DMA cb came. There is
> timeout logic in the driver which handles this case to let the request
> succeed if a dma cb was received after a while otherwise err out. See the
> function omap_hsmmc_start_dma_transfer.
>
> Is there a way to keep both the cases handled? If not we have to make
> changes based on which of these scenario is very odd.

   I think these cases are already handled properly. All actions are
taken if, and only if, TC is received.
Once TC is received, the sequence of execution is unaltered by DMA
callback. Dma callback
is effectively a no-op after the final block is transmitted.

   We can in fact get rid of the timeout logic. Of course, the DMA
channel is cleared
once the TC is received, hence there would be no spurious DMA callbacks during
the start of next transaction. [The only hanging case is when the TC
is never triggerred,
even after a successful transfer, but that's another issue altogether]

Regards,
Venkat.
