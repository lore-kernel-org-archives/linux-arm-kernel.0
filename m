From: vinod.koul@intel.com (Vinod Koul)
Date: Fri, 9 Dec 2016 22:47:27 +0530
Subject: Tearing down DMA transfer setup after DMA client has finished
In-Reply-To: <6ce1ea97-1d68-2203-c7b4-73315e801655@laposte.net>
References: <5846B237.8060409@free.fr> <yw1xwpfd2o9f.fsf@unicorn.mansr.com>
 <20161207164341.GX6408@localhost>
 <yw1xr35j1yd5.fsf@unicorn.mansr.com>
 <20161208103921.GC6408@localhost>
 <91b0d10c-1bc2-c3e1-4088-f4ad9adcd6c0@free.fr>
 <20161208163755.GH6408@localhost>
 <yw1xy3zqxt7x.fsf@unicorn.mansr.com>
 <20161209065955.GJ6408@localhost>
 <6ce1ea97-1d68-2203-c7b4-73315e801655@laposte.net>
Message-ID: <20161209171727.GK6408@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 09, 2016 at 11:25:57AM +0100, Sebastian Frias wrote:
> 
> What concrete solution do you propose?

I have already proposed two solutions.

A) Request a channel only when you need it. Obviously we can't do virtual
channels with this (though we should still use virt-channels framework).
The sbox setup and teardown can be done as part of channel request and
freeup. PL08x already does this.

Downside is that we can only have as many consumers at a time as channels.

I have not heard any technical reason for not doing this apart from drivers
grab the channel at probe, which is incorrect and needs to be fixed
irrespective of the problem at hand.

This is my preferred option.

B) Create a custom driver specific API. This API for example:
	sbox_setup(bool enable, ...)
can be called by client to explicitly setup and clear up the sbox setting.

This way we can have transactions muxed.

I have not heard any arguments on why we shouldn't do this except Russell's
comment that A) solves this.

> Alternatively, one can think of the current issue (i.e.: the fact that the IRQ
> arrives "too soon") in a different way.
> Instead of thinking the IRQ indicates "transfer complete", it is indicating "ready
> to accept another command", which in practice (and with proper API support) can
> translate into efficient queuing of DMA operations.

That IMO is a better understanding of this issue. But based on discussion, I
think the issue is that submitting next transaction cannot be done until
sbox is setup (as a consequence torn down for previous). Tear down can be
down only when client knows that transfer is done, from dma controller data
has been pushed and in-flight.


-- 
~Vinod
