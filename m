From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 16 Apr 2015 11:47:46 +0200
Subject: some question about writel implement in arm platform
In-Reply-To: <CADUS3onDbAJQHnKvVavf_+nYTU1zncEu6pvSZAr=sztqgyZ6wA@mail.gmail.com>
References: <CADUS3om64T1pfRqo7nRAVcnj7SKUR2jt4ZsYBcHrgpa7Zb1pkw@mail.gmail.com>
 <3810108.M3CSfEDqyN@wuerfel>
 <CADUS3onDbAJQHnKvVavf_+nYTU1zncEu6pvSZAr=sztqgyZ6wA@mail.gmail.com>
Message-ID: <2505138.CuSGrDpcOa@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 16 April 2015 16:06:16 yoma sophian wrote:
> 
> 2015-04-16 14:19 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
> > On Thursday 16 April 2015 13:28:41 yoma sophian wrote:
> >> hi all:
> >> the implementation of writel in ARM is writel_relaxed() with barrier
> >> before (DSB + outer cache sync).
> >>
> >> if the memory is device memory, shall we still need outer cache sync?
> >
> > Yes.
> Take my platform for example, I use Cortex A9 with PL310 L2 cache controller.
> if the memory is device memory, that mean it is un-cacheable why we
> still need to out sync off the PL310 buffer in writel operation?

The l2 sync is to ensure that prior memory writes are visible to a DMA
master that gets triggered by the writel.

If your device is not a DMA master, or the operation is unrelated to
DMA, you can use writel_relaxed().

	Arnd
