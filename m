From: jassisinghbrar@gmail.com (jassi brar)
Date: Wed, 16 Sep 2009 11:24:47 +0900
Subject: [PATCH 4/7] S3C64XX DMA: S3C2410_DMAF_CIRCULAR disable
In-Reply-To: <20090916002832.GN13508@trinity.fluff.org>
References: <1253008882-7587-1-git-send-email-jassi.brar@samsung.com>
	<20090916002832.GN13508@trinity.fluff.org>
Message-ID: <1b68c6790909151924u5b1abe5ayaf5377ac57ede69@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 16, 2009 at 9:28 AM, Ben Dooks <ben-linux@fluff.org> wrote:
> On Tue, Sep 15, 2009 at 07:01:22PM +0900, Jassi wrote:
>> S3C2410_DMAF_CIRCULAR requires that we don't free buffer
>> resources after TC-IRQ because we will revisit the buffer.
>> During simple long term playback/capture, like movie-play,
>> this may block those resources(kmem/dma_pool) unncessarily.
>> This is especially a problem since we allocate them in IRQ
>> context.
>> For now, we disable the option and free buff resources after
>> it's TC-IRQ. Also, chan->curr will point to the active buffer
>> while chan->next is rendered useless.
>
> This would have been better changing the sound driver and ensuring
> it does not allocate as much memory for buffering audio.
>
> The whole point of the circular buffer is it is allocated once and
> then used until the end of playback. If what you are saying is right,
> and resources are running out then somewhere either the SoC layer is
> losing them or between the DMA and the I2S driver we are losing
> buffers. This points to a bug in the resource management of one of
> them.
Please correct if any of the following is wrong as per the existing code:-
In DMA driver:-
   1) A 'struct s3c64xx_dma_buff' and a 'struct pl080s_lli' is allocated
 during every call to s3c2410_dma_enqueue.
    2) These resources are freed only when s3c64xx_dma_ctrl(FLUSH)
 is called by the dma client.

 In Dma Client Driver(I2S):-
   1) DMA is aquired and setup once before active continuous use
       and s3c2410_dma_enqueue is called as many times as the client
has some data to transfer, without any other call to dma driver.
   2) Unless there is some suspend/resume or pause/play event,
s3c64xx_dma_ctrl(FLUSH) may only be called after playback/capture ends.

Now consider the situation when we didn't set the CIRCULAR flag.
During this time the buffer resources are simply piling up without being
ever reused. Note that the playback maybe of many hours and at
some point dma_pool_alloc(and later kzalloc) will start returning NULL.

Besides,
a) The dma driver doesn't free those resource even for
Non-CIRCULAR flagged requests.
b) Only I2S driver makes use of the DMA driver(curently). To make
use of the feature(which is available only in 64xx dma driver) the 64xx
i2s driver will have to break from 24xx drivers(which we want to unify
ultimately?) and ALSA already provides a buffer looping mechanism.
