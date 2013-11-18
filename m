From: eric.dumazet@gmail.com (Eric Dumazet)
Date: Mon, 18 Nov 2013 09:13:28 -0800
Subject: [BUG,REGRESSION?] 3.11.6+,3.12: GbE iface rate drops to few KB/s
In-Reply-To: <20131118085407.25dadcaf@samsung-9>
References: <8761s0cqhh.fsf@natisbad.org>
 <slrnl83jr5.49f.xiyou.wangcong@linux-6brj.site>
 <87y54u59zq.fsf@natisbad.org> <20131112083633.GB10318@1wt.eu>
 <87a9hagex1.fsf@natisbad.org> <20131112100126.GB23981@1wt.eu>
 <87vbzxd473.fsf@natisbad.org> <20131113072257.GB10591@1wt.eu>
 <20131117141940.GA18569@1wt.eu> <20131118112601.65feb708@skate>
 <20131118104448.GI16823@kw.sim.vm.gnt> <20131118085407.25dadcaf@samsung-9>
Message-ID: <1384794808.8604.76.camel@edumazet-glaptop2.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2013-11-18 at 08:54 -0800, Stephen Hemminger wrote:
> On Mon, 18 Nov 2013 11:44:48 +0100
> Simon Guinot <simon.guinot@sequanux.org> wrote:

> > c9eeec26 tcp: TSQ can use a dynamic limit
> > 
> 
> But without that patch there was a performance regression for high speed
> interfaces whihc was caused by TSQ. 10G performance dropped to 8G

Yes, this made sure we could feed more than 2 TSO packets on TX ring.

But decreasing minimal amount of queuing from 128KB to ~1ms of the
current rate did not please NIC which can have a big delay between
ndo_start_xmit() and actual skb freeing (TX completion)

So
http://git.kernel.org/cgit/linux/kernel/git/davem/net.git/commit/?id=98e09386c0ef4dfd48af7ba60ff908f0d525cdee

restored this minimal amount of buffering, and let the bigger amount for
40Gb NICs ;)
