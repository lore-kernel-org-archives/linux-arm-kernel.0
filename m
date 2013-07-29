From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 29 Jul 2013 20:46:58 +0800
Subject: [PATCH] DMAEngine: sirf: let the users be able to pause and
 resume specific buffer
In-Reply-To: <20130729121715.GI24642@n2100.arm.linux.org.uk>
References: <1372927373-17407-1-git-send-email-Baohua.Song@csr.com>
 <CAGsJ_4wOdDMku-pNWiH-DoS_v39PfFwNYcU4T1Thsd-+L9A8AQ@mail.gmail.com>
 <20130729060819.GE29095@intel.com>
 <CAGsJ_4yVxAJc0UNTFMM1yjKQh6=xv12qPYpnUFZ=wmzrdpUOXQ@mail.gmail.com>
 <20130729121715.GI24642@n2100.arm.linux.org.uk>
Message-ID: <CAGsJ_4zRZ96L8ezQVyz6LQ8VgBCExML6RF_3DtTQR+ntsJHnZg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/7/29 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Mon, Jul 29, 2013 at 03:20:31PM +0800, Barry Song wrote:
>> 2013/7/29 Vinod Koul <vinod.koul@intel.com>:
>> > The above can be done by
>> > a) have two buffers:
>> >         - prepare first and submit, and start
>> >         - while first is ongoing, prepare second and start
>> >         - first is completed, so you start processing that while second is
>> >           getting DMAed
>> >         - when processing is completed, submit first again
>> >         - when second is completed, start processing that and submit that once
>> >           proocessed
>> >
>> > b) have multiple buffers, A, B, C & D and redo above schema.
>>
>> yes, that is the original idea for multiple buffer management for DMA.
>>
>> the reason which pushed us to the ping-pong pause is that we don't
>> need to issue software dma descriptor every time for every buffer as
>> hardware can do that.
>
> If your DMA engine is correctly implemented (and this only works for
> correctly implemented DMA engines), what you can do is:
>
> - at the start of the transfer, prepare, submit and issue two buffers,
>   each with a callback.
> - when the first callback happens
>   - that buffer has been transferred.
>   - you can now do whatever you need with that data.
>   - prepare, submit and issue the next buffer
>
> This means the DMA engine always has a buffer available to it, so if
> your CPU is fast enough, you can keep the transfer going without the
> DMA channel ever stopping or having to be paused.  If your CPU isn't
> fast enough to keep up, the DMA engine will stop at the end of the
> last queued and issued buffer automatically.
>

yes, suppose there are 4 buffers, we can issue all of buffer 0,1,2,3
at first. if buffer 0 has been read when buffer 3 is transferred,
buffer0 must have been issued again.
so that will keep buffers always alive if cpu is fast enough.

> Bonus points if you have implemented the "move to next buffer" correctly
> too, so that the hardware can do a continuous transfer without having to
> stop and wait between the buffers (provided of course that the next
> transfer is compatible with the previous.)

-barry
