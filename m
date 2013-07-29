From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 29 Jul 2013 20:49:10 +0800
Subject: [PATCH] DMAEngine: sirf: let the users be able to pause and
 resume specific buffer
In-Reply-To: <20130729113507.GJ29095@intel.com>
References: <1372927373-17407-1-git-send-email-Baohua.Song@csr.com>
 <CAGsJ_4wOdDMku-pNWiH-DoS_v39PfFwNYcU4T1Thsd-+L9A8AQ@mail.gmail.com>
 <20130729120830.GH24642@n2100.arm.linux.org.uk>
 <20130729113507.GJ29095@intel.com>
Message-ID: <CAGsJ_4wZR=YO3caD8YTURTwZXSkVYLPVENgJiuH0a46vZcvDdA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/7/29 Vinod Koul <vinod.koul@intel.com>:
> On Mon, Jul 29, 2013 at 01:08:30PM +0100, Russell King - ARM Linux wrote:
>> On Mon, Jul 29, 2013 at 10:14:24AM +0800, Barry Song wrote:
>> > 2013/7/4 Barry Song <Baohua.Song@csr.com>
>> > >
>> > > From: Qipan Li <Qipan.Li@csr.com>
>> > >
>> > > this patch adds a buffer_index in pause and resume entries, then users can
>> > > pause and resume a buffer they want, but don't pause the whole dma.
>> > >
>> > > a typical application scenerios is Ping-Pang in two buffers: at the
>> > > beginning, we enable buf1 and buf2 to receive dma data, after buf1 is
>> > > full, we pause buf1 and handle the data in this buffer to avoid overflow
>> > > in buf1. but at the same time, dma is still tranferring in buf2.  once we
>> > > have finished data process in buf1, we enable buf1 again.  this will
>> > > maximize the chance of dma transferring. users pause buf1 by:
>> > > dmaengine_device_control(sirfport->rx_dma_chan, DMA_PAUSE, 1); users pause
>> > > buf2 by: dmaengine_device_control(sirfport->rx_dma_chan, DMA_PAUSE, 2);
>> > > users can still pause the whole dma transferring by dmaengine_pause().
>> > >
>> > > Signed-off-by: Qipan Li <Qipan.Li@csr.com> Signed-off-by: Barry Song
>> > > <Baohua.Song@csr.com> --- drivers/dma/sirf-dma.c | 102
>> > > ++++++++++++++++++++++++++++++++++++++----------- 1 file changed, 80
>> > > insertions(+), 22 deletions(-)
>> >
>> > Hi Vinod, as we still have some other patches of dma clients depending on
>> > this, would you give some comments about it?
>>
>> You at least need to write up some documentation about this new feature - you
>> need to describe exactly how this argument relates to a set of queued DMA
>> descriptor(s) and its semantics with respect to those queued descriptors.
> As I commented earlier today, I dont think we need this way. This can also be
> achieved with submitting descriptors after the buffer has been processed.

we submit all buffers together at the beginning, once one buffer is
right handled by cpu after dma transfers, we issue it again.

>
>> From the looks of this patch, it has nothing to do with any particular
>> queued descriptor, but you're exposing internal knowledge of the SiRF
>> DMA engine.
> More than dmaengine its the way of modelling here which seems to be the issue
>
> ~Vinod
> --
-barry
