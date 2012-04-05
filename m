From: samgandhi9@gmail.com (Sam Gandhi)
Date: Thu, 5 Apr 2012 06:02:25 -0700
Subject: Using GPMI-NAND driver on iMX28 using 3.4-rc1?
In-Reply-To: <1333628861.31825.22.camel@vkoul-udesk3>
References: <CAOdLEarFOdmDBS0iDmafLeBU=NNWxWjejTvJ-eEkQjRO12+VYg@mail.gmail.com>
 <20120404070157.GB24930@pengutronix.de>
 <CAOdLEaqXyvHzTRSq2=RquZLqEO6kMEp11rjKJ+UtSqtF4nr-EA@mail.gmail.com>
 <20120404183314.GF17187@pengutronix.de>
 <CAOdLEaoboQowyx3T9ONjv-Y3q1JfFRb4ahS8CNrzeJi3N8Dczg@mail.gmail.com>
 <CAOMZO5AsbFDXHs3JRLC5=1MjZ7QrxciqV25xpZQL1Yvk3boQmw@mail.gmail.com>
 <CAOdLEaoEDr7fnswwV-Gs8tZF9Zj-RFnRa9Z=eqRFd0==OgV10Q@mail.gmail.com>
 <CAOMZO5AoFnM=cCR-kS4A1k2xY_bRd9+gN1p9bFxdyPS2-UdbkQ@mail.gmail.com>
 <4F7D3DB8.6080009@freescale.com>
 <CAOdLEaoy8ARS=awimR6fN8EcX+FrqxaSr3VUG3rP3zrNLOf+Gw@mail.gmail.com>
 <1333628861.31825.22.camel@vkoul-udesk3>
Message-ID: <CAOdLEaqceT5u=N5Jx-BApXiTGPUoDAwmgs6qxKwipm_ac3nFeg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vinod,

On Thu, Apr 5, 2012 at 5:27 AM, Vinod Koul <vinod.koul@linux.intel.com> wrote:
> On Thu, 2012-04-05 at 05:03 -0700, Sam Gandhi wrote:
>> 2012/4/4 Huang Shijie <b32955@freescale.com>:
>> > Hi All:
>> >> On Wed, Apr 4, 2012 at 7:07 PM, Sam Gandhi<samgandhi9@gmail.com> ?wrote:
>> >>
>> >>> I reverted that commit and I still see following ?error!
>> >> Huang,
>> >>
>> >> Are you able to use gpmi on mx28 running 3.4-rc1?
>> >>
>> > I also meet the same problem today.
>> >
>> >
>> >>> flash_erase /dev/mtd1 0 0
>> >>> Erasing 1------------[ cut here ]------------
>> >>> kernel BUG at /home/sam/linux/drivers/dma/dmaengine.h:53!
>> > the mxs-dma has added some patches about the cookie.
>> > The bug is in the dmaengine.h.
>> >
>> > So let more people know this bug.
>> >
>> > BR
>> > Huang Shijie
>> >
>> >
>> FWIW, Just a data point.
>>
>> I coverted BUG_ON in dmaengine.h to printk as shown below. With this
>> change I was able to format nand, create UBI partition. I have been
>> running UBI torture test called integck on my board that does lot of
>> I/O, mounting/unmounting of filesystem for close to 8 hour now without
>> crash. But I do see those printks. I haven't followed logic of
>> tx->cookie well enough to figure out what the appropriate change
>> should be. Note this is with commit
>> 00292bbf769620dea923dbd906afd88955f7ea19 reverted in my tree.
>>
>> Cookie 0 ?completed 102118268 DMA_MIN 1
>> Cookie 0 ?completed 102120401 DMA_MIN 1
>> Cookie 0 ?completed 102237726 DMA_MIN 1
>>
>> git diff drivers/dma/dmaengine.h
>> diff --git a/drivers/dma/dmaengine.h b/drivers/dma/dmaengine.h
>> index 17f983a..3d10a70 100644
>> --- a/drivers/dma/dmaengine.h
>> +++ b/drivers/dma/dmaengine.h
>> @@ -50,7 +50,11 @@ static inline dma_cookie_t dma_cookie_assign(struct
>> dma_async_tx_descriptor *tx)
>> ? */
>> ?static inline void dma_cookie_complete(struct dma_async_tx_descriptor *tx)
>> ?{
>> - ? ? ? BUG_ON(tx->cookie < DMA_MIN_COOKIE);
>> + ? ? ? if ( tx->cookie < DMA_MIN_COOKIE)
>> + ? ? ? ? ? ? ? printk(KERN_ERR "Cookie %d, ?completed %d DMA_MIN %d
>> ",tx->cookie,
>> + ? ? ? ? ? ? ? tx->chan->completed_cookie,
>> + ? ? ? ? ? ? ? DMA_MIN_COOKIE);
>> + ? ? ? /* BUG_ON(tx->cookie < DMA_MIN_COOKIE); */
>> ? ? ? ? tx->chan->completed_cookie = tx->cookie;
>> ? ? ? ? tx->cookie = 0;
>> ?}
> This means you are trying to mark a cookie complete when it is already
> marked so!, hence dmaengine screams.
> The bug is is mxs-dma.
> Let me know if below fixes it (assuming you are not using cyclic API,
> that would need fixup as well)
>
> diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
> index c81ef7e..5ddd84e 100644
> --- a/drivers/dma/mxs-dma.c
> +++ b/drivers/dma/mxs-dma.c
> @@ -399,6 +399,10 @@ static struct dma_async_tx_descriptor
> *mxs_dma_prep_slave_sg(
> ? ? ? ? ? ? ? ?ccw->bits &= ~CCW_DEC_SEM;
> ? ? ? ?} else {
> ? ? ? ? ? ? ? ?idx = 0;
> + ? ? ? ? ? ? ? /* assign cookie here,
> + ? ? ? ? ? ? ? ?* hopefully for above case we dont need it
> + ? ? ? ? ? ? ? ?*/
> + ? ? ? ? ? ? ? dma_cookie_assign(&mxs_chan->desc);
> ? ? ? ?}
>
> ? ? ? ?if (direction == DMA_TRANS_NONE) {
>
I applied your suggested change and don't hit the BUG_ON in
dmaengine.h with this change UBI torture test has run for last 30 min
or so I will let it run for a day. [ I will let mxs-dma authors
comment if this is a right change.. ]

-Sam
