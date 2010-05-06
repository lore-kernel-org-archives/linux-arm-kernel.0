From: svenkatr@ti.com (Venkatraman S)
Date: Thu, 6 May 2010 14:29:51 +0530
Subject: [PATCH v8 1/2] sDMA: descriptor autoloading feature
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C538737A@dbde02.ent.ti.com>
References: <l2i618f0c911004291035ja334efb0o5016c5cb70c4b5bc@mail.gmail.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C52D16D1@dbde02.ent.ti.com>
	<k2l618f0c911005050450t75968621m61e3ff39e90d20ad@mail.gmail.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C52D1806@dbde02.ent.ti.com>
	<i2r618f0c911005050925h253532c7wb758ac7781840b4c@mail.gmail.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C538737A@dbde02.ent.ti.com>
Message-ID: <s2y618f0c911005060159v4be26a14y85a7548a080ae380@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shilimkar, Santosh <santosh.shilimkar@ti.com> wrote:
>> -----Original Message-----
>> From: svenkatr at gmail.com [mailto:svenkatr at gmail.com] On Behalf Of Venkatraman S
>> Sent: Wednesday, May 05, 2010 9:56 PM
>> To: Shilimkar, Santosh
>> Cc: linux-omap at vger.kernel.org; linux-mmc at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
>> Chikkature Rajashekar, Madhusudhan; Adrian Hunter; Tony Lindgren
>> Subject: Re: [PATCH v8 1/2] sDMA: descriptor autoloading feature
>>
>> On Wed, May 5, 2010 at 5:31 PM, Shilimkar, Santosh
>> <santosh.shilimkar@ti.com> wrote:
>> >
>> >
>> >> -----Original Message-----
>> >> From: svenkatr at gmail.com [mailto:svenkatr at gmail.com] On Behalf Of Venkatraman S
>> >> Sent: Wednesday, May 05, 2010 5:20 PM
>> >> To: Shilimkar, Santosh
>> >> Cc: linux-omap at vger.kernel.org; linux-mmc at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
>> >> Chikkature Rajashekar, Madhusudhan; Adrian Hunter; Tony Lindgren
>> >> Subject: Re: [PATCH v8 1/2] sDMA: descriptor autoloading feature
>> >>
>> >> [Long sections have been trimmed to the context of the discussion]
>> >> On Wed, May 5, 2010 at 3:02 PM, Shilimkar, Santosh
>> >> <santosh.shilimkar@ti.com> wrote:
>> >> >> -----Original Message-----
>> >> >> +static int dma_sglist_set_phy_params(struct omap_dma_sglist_node *sghead,
>> >> >> + ? ? ? ? ? ? dma_addr_t phyaddr, int nelem)
>> >> >> +{
>> >> >> + ? ? struct omap_dma_sglist_node *sgcurr, *sgprev;
>> >> >> + ? ? dma_addr_t elem_paddr = phyaddr;
>> >> >> +
>> >> >> + ? ? for (sgprev = sghead;
>> >> >> + ? ? ? ? ? ? sgprev < sghead + nelem;
>> >> >> + ? ? ? ? ? ? sgprev++) {
>> >> >> +
>> >> >> + ? ? ? ? ? ? sgcurr = sgprev + 1;
>> >> >> + ? ? ? ? ? ? sgprev->next = sgcurr;
>> >> >> + ? ? ? ? ? ? elem_paddr += (int)sizeof(*sgcurr);
>> >> >> + ? ? ? ? ? ? sgprev->next_desc_add_ptr = elem_paddr;
>> >> >> +
>> >> >> + ? ? ? ? ? ? switch (sgcurr->desc_type) {
>> >> >> + ? ? ? ? ? ? case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE1:
>> >> >> + ? ? ? ? ? ? ? ? ? ? omap_dma_list_set_ntype(sgprev, 1);
>> >> >> + ? ? ? ? ? ? ? ? ? ? break;
>> >> >> +
>> >> >> + ? ? ? ? ? ? case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE2a:
>> >> >> + ? ? ? ? ? ? /* intentional no break */
>> >> >> + ? ? ? ? ? ? case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE2b:
>> >> >> + ? ? ? ? ? ? ? ? ? ? omap_dma_list_set_ntype(sgprev, 2);
>> >> >> + ? ? ? ? ? ? ? ? ? ? break;
>> >> >> +
>> >> >> + ? ? ? ? ? ? case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE3a:
>> >> >> + ? ? ? ? ? ? ? ? ? ? /* intentional no break */
>> >> >> + ? ? ? ? ? ? case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE3b:
>> >> >> + ? ? ? ? ? ? ? ? ? ? omap_dma_list_set_ntype(sgprev, 3);
>> >> >> + ? ? ? ? ? ? ? ? ? ? break;
>> >> >> +
>> >> >> + ? ? ? ? ? ? default:
>> >> >> + ? ? ? ? ? ? ? ? ? ? return -EINVAL;
>> >> >> +
>> >> >> + ? ? ? ? ? ? }
>> >> > Are we supporting all the descriptor types. I think only type2a is
>> >> > supported. In that case please add FIXME, or WARN message here.
>> >>
>> >> From DMA perspective, all are supported - no restrictions. Only I have
>> >> not figured
>> >> out how to use type 2b and type 3b descriptors. It's not the fault of
>> >> DMA driver or
>> >> specification :-) It's actually upto the client to select the right type.
>> > OK. Then the question which I wanted to ask.
>> > For TX, 2b should have been better choice than 2a isn't it?
>>
>> Not much of a difference (as the space allocation is common), but I
>> couldn't get 2b working correctly.
>> Will try that once I get some clarification from hardware team.
> Add a FIXME then with description in the code so that it's not forgotten once the code
> is merged.
OK. I am assuming the FIXME has to be in MMC driver, not here.
