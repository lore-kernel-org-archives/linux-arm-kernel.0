From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 03 Apr 2014 10:35:11 +0200
Subject: [PATCH 3/3] net: hisilicon: new hip04 ethernet driver
In-Reply-To: <CAMj5BkgfwE1hHpVeqH9WRitwCB30x3c4w0qw7sXT3PiOV-QcPQ@mail.gmail.com>
References: <1396358832-15828-1-git-send-email-zhangfei.gao@linaro.org>
 <4698724.S4F2PxkdOH@wuerfel>
 <CAMj5BkgfwE1hHpVeqH9WRitwCB30x3c4w0qw7sXT3PiOV-QcPQ@mail.gmail.com>
Message-ID: <7201300.YltrNpx6X5@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 03 April 2014 14:24:25 Zhangfei Gao wrote:
> On Wed, Apr 2, 2014 at 11:49 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Wednesday 02 April 2014 10:04:34 David Laight wrote:
> >> What you need to avoid is reads from uncached memory.
> >> It may well beneficial for the tx reclaim code to first
> >> check whether all the transmits have completed (likely)
> >> instead of testing each descriptor in turn.
> >
> > Good point, reading from noncached memory is actually the
> > part that matters. For slow networks (e.g. 10mbit), checking if
> > all of the descriptors have finished is not quite as likely to succeed
> > as for fast (gbit), especially if the timeout is set to expire
> > before all descriptors have completed.
> >
> > If it makes a lot of difference to performance, one could use
> > a binary search over the outstanding descriptors rather than looking
> > just at the last one.
> >
> 
> I am afraid, there may no simple way to check whether all transmits completed.

Why can't you do the trivial change that David suggested above? It
sounds like a three line change to your current code. No need to do
the binary change at first, just see what difference it makes.

> Still want enable the cache coherent feature first.
> Then two benefits:
> 1. dma buffer cacheable.
> 2. descriptor can directly use cacheable memory, so the performance
> concern here may be solved accordingly.
> 
> So how about using this version as first version, while tuning the
> performance in the next step.
> Currently, the gbit interface can reach 420M bits/s in iperf, and the
> 100M interface can reach 94M bits/s.

It sounds like a very simple thing to try and you'd know immediately
if it helps or not.

Besides, you still have to change the other two issues I mentioned
regarding the tx reclaim, so you can do all three at once.

	Arnd
