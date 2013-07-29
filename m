From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 29 Jul 2013 15:20:31 +0800
Subject: [PATCH] DMAEngine: sirf: let the users be able to pause and
 resume specific buffer
In-Reply-To: <20130729060819.GE29095@intel.com>
References: <1372927373-17407-1-git-send-email-Baohua.Song@csr.com>
 <CAGsJ_4wOdDMku-pNWiH-DoS_v39PfFwNYcU4T1Thsd-+L9A8AQ@mail.gmail.com>
 <20130729060819.GE29095@intel.com>
Message-ID: <CAGsJ_4yVxAJc0UNTFMM1yjKQh6=xv12qPYpnUFZ=wmzrdpUOXQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/7/29 Vinod Koul <vinod.koul@intel.com>:
> On Mon, Jul 29, 2013 at 10:14:24AM +0800, Barry Song wrote:
>> 2013/7/4 Barry Song <Baohua.Song@csr.com>
> well the submitter didn't cc me. So this wasnt in my INBOX!

Vinod, i must did some misoperation. sorry for that.

>
>> >
>> > From: Qipan Li <Qipan.Li@csr.com>
>> >
>> > this patch adds a buffer_index in pause and resume entries, then users
>> > can pause and resume a buffer they want, but don't pause the whole dma.
>> >
>> > a typical application scenerios is Ping-Pang in two buffers:
> typo, pong                              ^^^^^^^^^
>> > at the beginning, we enable buf1 and buf2 to receive dma data, after
>> > buf1 is full, we pause buf1 and handle the data in this buffer to avoid
>> > overflow in buf1. but at the same time, dma is still tranferring in buf2.
>> > once we have finished data process in buf1, we enable buf1 again.
>> > this will maximize the chance of dma transferring. users pause buf1 by:
>> > dmaengine_device_control(sirfport->rx_dma_chan, DMA_PAUSE, 1);
>> > users pause buf2 by:
>> > dmaengine_device_control(sirfport->rx_dma_chan, DMA_PAUSE, 2);
>> > users can still pause the whole dma transferring by dmaengine_pause().
> Well this is odd, the second arg is not supposed to be valid for PAUSE op. And
> PAUSE means you pause the whole channel.
>
> The above can be done by
> a) have two buffers:
>         - prepare first and submit, and start
>         - while first is ongoing, prepare second and start
>         - first is completed, so you start processing that while second is
>           getting DMAed
>         - when processing is completed, submit first again
>         - when second is completed, start processing that and submit that once
>           proocessed
>
> b) have multiple buffers, A, B, C & D and redo above schema.

yes, that is the original idea for multiple buffer management for DMA.

the reason which pushed us to the ping-pong pause is that we don't
need to issue software dma descriptor every time for every buffer as
hardware can do that.
so we went to a pause for buffers which have been issued by hardware
and stop buffer overflow.

>
> Since patch is not the right approach and doesnt use API correctly NAK from me on that

the original idea is actually extending the DMA pause API insteading
of using current PAUSE pf the whole link. i got a little worried about
the patch too, guys have a long history for ping-pong pause even
before using DMAEngine framework.

if your answer is definite no, let's move to your way which makes more senses.

>
> ~Vinod

-barry
