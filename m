From: David.Laight@ACULAB.COM (David Laight)
Date: Wed, 26 Mar 2014 09:55:46 +0000
Subject: [PATCH 3/3] net: hisilicon: new hip04 ethernet driver
In-Reply-To: <4392030.XayIa35sfH@wuerfel>
References: <1395670496-17381-1-git-send-email-zhangfei.gao@linaro.org>
 <21873900.AIOr1ryy37@wuerfel>
 <CAGVrzcZNM2gUHqq2m2jcaqs-AoWKo_DszYu5ozs2vTR6kFY0kA@mail.gmail.com>
 <4392030.XayIa35sfH@wuerfel>
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D0F6E9407@AcuExch.aculab.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann
> On Tuesday 25 March 2014 10:16:28 Florian Fainelli wrote:
> >
> > Ok, well that's really unfortunate, to achieve the best of everything,
> > the workaround should probably look like:
> >
> > - keep reclaiming TX buffers in ndo_start_xmit() in case you push more
> > packets to the NICs than your timer can free
> > - reclaim TX buffers in NAPI poll() context for "symetrical" workloads
> > where e.g: TCP ACKs received allow you to complete TX buffers
> > - have a timer like you suggest which should help with transmit only
> > workloads at a slow rate
> 
> Yes, that is what I was thinking, but with orphaning the tx skbs,
> we can probably be a little smarter. Note that in order to check
> the state of the queue, we have to do a read from uncached memory,
> since the hardware also doesn't support cache coherent DMA.
> We don't want to do that too often.

Possibly you can check for all the pending transmits having
completed - the most likely case. Instead of checking them
individually?

You should limit the number of tx bytes as well as the number
of tx frames - buffering a ring full of large frames subverts
some of the algorithms higher up the stack.

	David
