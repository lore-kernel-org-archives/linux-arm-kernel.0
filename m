From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 18 Nov 2013 09:58:38 -0800
Subject: [BUG,REGRESSION?] 3.11.6+,3.12: GbE iface rate drops to few KB/s
In-Reply-To: <20131118105150.GA26398@1wt.eu>
References: <8761s0cqhh.fsf@natisbad.org>
 <slrnl83jr5.49f.xiyou.wangcong@linux-6brj.site>
 <87y54u59zq.fsf@natisbad.org> <20131112083633.GB10318@1wt.eu>
 <87a9hagex1.fsf@natisbad.org> <20131112100126.GB23981@1wt.eu>
 <87vbzxd473.fsf@natisbad.org> <20131113072257.GB10591@1wt.eu>
 <20131117141940.GA18569@1wt.eu> <20131118112601.65feb708@skate>
 <20131118105150.GA26398@1wt.eu>
Message-ID: <CAGVrzca=L1XxrFXJH03iYOjY3LttQ_dvYgOHdavz_8W+iL6iWw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Willy, Thomas,

2013/11/18 Willy Tarreau <w@1wt.eu>:
> Hi Thomas,
>
> On Mon, Nov 18, 2013 at 11:26:01AM +0100, Thomas Petazzoni wrote:
>> I haven't read the entire discussion yet, but do you guys have
>> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/clk/mvebu?id=1022c75f5abd3a3b25e679bc8793d21bedd009b4
>> applied? It got merged recently, and it fixes a number of networking
>> problems on Armada 370.
>
> No, because my version was even older than the code which introduced this
> issue :-)
>
> The main issue is related to something we discussed once ago which surprized
> both of us, the use of a Tx timer to release the Tx descriptors. I remember
> I considered that it was not a big issue because the flush was also done in
> the Rx path (thus on ACKs) but I can't find trace of this code so my analysis
> was wrong. Thus we can hit some situations where we fill the descriptors
> before filling the link.

So long as you are using TCP this works because the ACKs will somehow
create an artificial "forced" completion of your transmitted SKBs, how
about an UDP streamer use case? In that case you will quickly fill up
all of your descriptors and have to wait for the descriptors to be
freed by the 10ms timer. I do not think this is desirable at all, and
this will requite very large UDP sender socket buffers. I remember
asking Thomas what was the reason for not using the TX completion IRQ
during the first incarnation of the driver, but I do not quite
remember what was the answer.

If the original mvneta driver authors fears where that TX completion
could generate too many IRQs, they should use netif_stop_queue() /
netif_wake_queue() and mask off/on interrupts appropriately to slow
down the pace of TX interrupts.

>
> Ideally we should have a Tx IRQ. At the very least we should call the tx
> refill function in mvneta_poll() I believe. I can try to do it but I'd
> rather have the Tx IRQ working instead.

Right, actually you should do both, free transmitted SKBs from your
NAPI poll callback and from the TX completion IRQ to ensure SKBs are
freed up in time no matter what workload/use case is being used.
-- 
Florian
