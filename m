From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 2 Jun 2015 16:41:26 +0200
Subject: [PATCH 0/8] ARM: mvebu: Add support for RAID6 PQ offloading
In-Reply-To: <CAPcyv4i06Mwis_CSrKV1Yo6crD1vrjb9it6RtYdtwbgOOY9a4g@mail.gmail.com>
References: <1431445063-20226-1-git-send-email-maxime.ripard@free-electrons.com>
 <CAPcyv4gshyaji2HarAeOg3XOiNnmGwnSOMuFGWpuDu8ZTGg=jw@mail.gmail.com>
 <20150513091733.GW10961@lukather>
 <CAPcyv4jv=xWHbrO=rKhnWt9zFn8vkhS2J5mJiCBKKwESdUk5tg@mail.gmail.com>
 <20150518091454.GP4004@lukather>
 <CAPcyv4jbW=B_mYfx5HfKckLYeWctfC-9jYeDf0Z1APvQZfHj6Q@mail.gmail.com>
 <20150526094511.GP8557@lukather>
 <CAPcyv4i06Mwis_CSrKV1Yo6crD1vrjb9it6RtYdtwbgOOY9a4g@mail.gmail.com>
Message-ID: <20150602144126.GZ23777@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 26, 2015 at 09:31:03AM -0700, Dan Williams wrote:
> > If you mean, "give me a hand, you can start there", then yeah, I can
> > do that.
> >
> >> I'm not happy about not having had the time to do this rework myself.
> >> Linux is better off with this api deprecated.
> >
> > You're not talking about deprecating it, you're talking about removing
> > it entirely.
> 
> True, and adding more users makes that removal more difficult.  I'm
> willing to help out on the design and review for this work, I just
> can't commit to doing the implementation and testing.
> 
> I think it looks something like this:
> 
> At init time the raid456 driver probes for offload resources It can
> discover several scenarios:
> 
> 1/ "the ioatdma case": raid channels that have all the necessary
> operations (copy, xor/pq, xor/pq check).  In this case we'll never
> need to perform a channel switch.  Potentially the cpu never touches
> the stripe cache in this case and we can maintain a static dma mapping
> for the entire lifespan of a struct stripe_head.
> 
> 2/ "the channel switch case":  All the necessary offload resources are
> available but span multiple devices.  In this case we need to wait for
> channel1 to complete an operation before channel2 can start.  This
> case is complicated by the fact that different channels may need their
> own dma mappings.  In the simplest case channels can share the same
> mapping and raid456 needs to wait for channel completions.  I think we
> can do a better job than the async_tx api here as raid456 should
> probably poll for completions after each stripe processing batch.
> Taking an interrupt per channel-switch event seems like excessive
> overhead.
> 
> 3/ "the co-op case": We have a xor/pq offload resource, but copy and
> check operations require the cpu to touch the stripe cache.  In this
> case we need to use the dma_sync_*_for_cpu()/dma_sync_*_for_device()
> to pass buffers back and forth between device and cpu ownership.  This
> shares some of the complexity of waiting for completions with scenario
> 2.
> 
> Which scenario does your implementation fall into?  Maybe we can focus
> on that one and leave the other scenarios for other dmaengine
> maintainers to jump in an implement?

>From my limited understanding of RAID and PQ computations, it would be
3 with a twist.

Our hardware controller supports xor and PQ, but the checks and
recovering data is not supported (we're not able to offload async_mult
and async_sum_product).

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150602/54ee2b65/attachment.sig>
