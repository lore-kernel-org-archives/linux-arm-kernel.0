From: w@1wt.eu (Willy Tarreau)
Date: Mon, 18 Nov 2013 11:51:50 +0100
Subject: [BUG,REGRESSION?] 3.11.6+,3.12: GbE iface rate drops to few KB/s
In-Reply-To: <20131118112601.65feb708@skate>
References: <8761s0cqhh.fsf@natisbad.org>
 <slrnl83jr5.49f.xiyou.wangcong@linux-6brj.site> <87y54u59zq.fsf@natisbad.org>
 <20131112083633.GB10318@1wt.eu> <87a9hagex1.fsf@natisbad.org>
 <20131112100126.GB23981@1wt.eu> <87vbzxd473.fsf@natisbad.org>
 <20131113072257.GB10591@1wt.eu> <20131117141940.GA18569@1wt.eu>
 <20131118112601.65feb708@skate>
Message-ID: <20131118105150.GA26398@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Mon, Nov 18, 2013 at 11:26:01AM +0100, Thomas Petazzoni wrote:
> I haven't read the entire discussion yet, but do you guys have
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/clk/mvebu?id=1022c75f5abd3a3b25e679bc8793d21bedd009b4
> applied? It got merged recently, and it fixes a number of networking
> problems on Armada 370.

No, because my version was even older than the code which introduced this
issue :-)

The main issue is related to something we discussed once ago which surprized
both of us, the use of a Tx timer to release the Tx descriptors. I remember
I considered that it was not a big issue because the flush was also done in
the Rx path (thus on ACKs) but I can't find trace of this code so my analysis
was wrong. Thus we can hit some situations where we fill the descriptors
before filling the link.

Ideally we should have a Tx IRQ. At the very least we should call the tx
refill function in mvneta_poll() I believe. I can try to do it but I'd
rather have the Tx IRQ working instead.

Regards,
Willy
