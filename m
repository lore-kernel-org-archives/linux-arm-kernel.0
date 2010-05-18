From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Tue, 18 May 2010 10:59:27 +0900
Subject: [PATCH 2/6] S3C: DMA: Add api driver for PL330
In-Reply-To: <20100517084021.GC6684@trinity.fluff.org>
References: <1274060104-14224-1-git-send-email-jassi.brar@samsung.com>
	<1274060139-14290-1-git-send-email-jassi.brar@samsung.com>
	<20100517084021.GC6684@trinity.fluff.org>
Message-ID: <AANLkTik76NKK3tOeFSDoRK5MrT8pd68yn78I0ZO4KTNd@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 17, 2010 at 5:40 PM, Ben Dooks <ben-linux@fluff.org> wrote:
> On Mon, May 17, 2010 at 10:35:39AM +0900, Jassi Brar wrote:

>> +/*
>> + * The platforms just need to provide this info
>> + * to the S3C DMA API driver for PL330.
>
> would be heklpful to describe what this information actually
> means, including how it helps to configure the hardware appropriately.

Ok

......

>> +struct s3c_pl330_dmac {
>> + ? ? struct pl330_info *pi;
>> + ? ? /* Number of channels currently busy */
>> + ? ? unsigned busy_chan;
>> + ? ? /* To attach to the global list of DMACs */
>> + ? ? struct list_head node;
>> + ? ? /* List of IDs of peripherals this DMAC can work with */
>> + ? ? enum dma_ch *peri;
>> + ? ? /* Pool to quickly allocate xfers for all channels in the dmac */
>> + ? ? struct kmem_cache *kmcache;
>> +};
>
> I would prefer to see kerneldoc style documentation for this
> if possible.
Ok.

......

>> + ? ? ch = kmalloc(sizeof(*ch), GFP_KERNEL);
>> + ? ? /* Return silently to work with other channels */
>> + ? ? if (!ch)
>> + ? ? ? ? ? ? return;
>> +
>> + ? ? ch->id = id;
>> + ? ? ch->dmac = NULL;
>> +
>
> should you init the list entry before adding it?
sorry, I am unable to see any problem with what I do.
Am I overlooking something?

.....

>> +/*
>> + * Measure of suitability of 'dmac' handling 'ch'
>> + *
>> + * 0 indicates 'dmac' can not handle 'ch' either
>> + * because it is not supported by the hardware or
>> + * because all dmac channels are currently busy.
>> + *
>> + * >0 vlaue indicates 'dmac' has the capability.
>> + * The bigger the value the more suitable the dmac.
>> + */
>> +typedef u8 suit;
>> +#define MAX_SUIT ? ? 255
>> +#define MIN_SUIT ? ? 0
>
> hmm, would oprfer to see this as a simple integer.
Ok.

......

>> + ? ? /* If there was only one node left */
>> + ? ? if (t == xfer)
>> + ? ? ? ? ? ? ch->xfer_head = NULL;
>> + ? ? else if (ch->xfer_head == xfer)
>> + ? ? ? ? ? ? ch->xfer_head = t;
>> +
>> + ? ? list_del(&xfer->node);
>> +}
>
> couldn't xfer_head be infered from the transfer list?
Not if we are to support S3C2410_DMAF_CIRCULAR.

thanks
