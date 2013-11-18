From: David.Laight@ACULAB.COM (David Laight)
Date: Mon, 18 Nov 2013 10:09:53 -0000
Subject: [BUG,REGRESSION?] 3.11.6+,3.12: GbE iface rate drops to few KB/s
In-Reply-To: <20131117141940.GA18569@1wt.eu>
References: <8761s0cqhh.fsf@natisbad.org>
 <slrnl83jr5.49f.xiyou.wangcong@linux-6brj.site> <87y54u59zq.fsf@natisbad.org>
 <20131112083633.GB10318@1wt.eu> <87a9hagex1.fsf@natisbad.org>
 <20131112100126.GB23981@1wt.eu> <87vbzxd473.fsf@natisbad.org>
 <20131113072257.GB10591@1wt.eu> <20131117141940.GA18569@1wt.eu>
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B742A@saturn3.aculab.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I wonder if we can call mvneta_txq_done() from the IRQ handler, which would
> cause some recycling of the Tx descriptors when receiving the corresponding
> ACKs.
> 
> Ideally we should enable the Tx IRQ, but I still have no access to this
> chip's datasheet despite having asked Marvell several times in one year
> (Thomas has it though).
> 
> So it is fairly possible that in your case you can't fill the link if you
> consume too many descriptors. For example, if your server uses TCP_NODELAY
> and sends incomplete segments (which is quite common), it's very easy to
> run out of descriptors before the link is full.

Or you have a significant number of active tcp connections.

Even if there were no requirement to free the skb quickly you still
need to take a 'tx done' interrupt when the link is transmit rate limited.
There are scenarios when there is no receive traffic - eg asymmetric
routing, but testable with netperf UDP transmits.

	David
