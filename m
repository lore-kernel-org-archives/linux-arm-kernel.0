From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 19 Aug 2016 18:58:47 +0200
Subject: [RFC 00/17] clk: Add per-controller locks to fix deadlocks
In-Reply-To: <20160819144640.GM21682@localhost.localdomain>
References: <1471354514-24224-1-git-send-email-k.kozlowski@samsung.com>
 <65703100-1e16-6c34-babe-40e630180688@samsung.com>
 <20160819144640.GM21682@localhost.localdomain>
Message-ID: <20160819165847.GA7100@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 19, 2016 at 03:46:40PM +0100, Charles Keepax wrote:
> On Tue, Aug 16, 2016 at 03:51:10PM +0200, Krzysztof Kozlowski wrote:
> > On 08/16/2016 03:34 PM, Krzysztof Kozlowski wrote:
> > > Hi,
> > > 
> > > RFC, please, do not apply, maybe except patch #1 which is harmless.
> > > 
> > > 
> > > Introduction
> > > ============
> > > The patchset brings new entity: clock controller representing a hardware
> > > block.  The clock controller comes with its own prepare lock which
> > > is used then in many places.  The idea is to fix the deadlock mentioned
> > > in commit 10ff4c5239a1 ("i2c: exynos5: Fix possible ABBA deadlock by keeping
> > > I2C clock prepared") and commit 34e81ad5f0b6 ("i2c: s3c2410: fix ABBA deadlock
> > > by keeping clock prepared").
> > > 
> > 
> > Damn, I forgot to describe the overall idea. :) It is mentioned in patch
> > 15 but probably not many will have enough of patience to reach it.
> > 
> > The locking idea
> > ================
> > Clock controllers representing different hardware blocks, will contain
> > its own prepare lock which protects the clocks inside controller.  The
> > hierarchy itself is protected by global lock.
> > 
> > In prepare path, the global prepare lock is removed.  This is direct
> > solution for the deadlock.
> > 
> > Clock hierarchy imposes also hierarchy between controllers so when a
> > prepare happens, also parents have to be locked.
> > 
> > Following locking design was chosen:
> > 1. For prepare/unprepare paths: lock only clock controller and its
> >    parents.
> > 2. For recalc rates paths: lock global lock, the controller and its
> >    children.
> > 3. For reparent paths: lock entire tree up down (children and parents)
> >    and the global lock as well.
> > 
> > 
> > In each case of traversing the clock hierarchy, the locking of
> > controllers is always from children to parents.
> > 
> > 
> > Best regards,
> > Krzysztof
> 
> I have been playing with these patches on my Arndale board and
> they certainly do seem to resolve the interaction issues I have
> been SPI and the clocking framework, which is awesome and lets me
> sensibly add the clocking framework into our codec drivers. I will
> keep investigating and for what its worth have a little more
> detailed look through the code.

I am really happy to hear it!

Along with other Samsung guys from Poland we really spent a lot of time
figuring out all the locking cases, possible scenarios and new issues
which could come out of it.

I am glad that it solves also other people's cases, not only ours!

Certainly there is a lot of things to improve in the patchset. Probably
merging the new "clock controller" entity into clock provider makes
sense.

Best regards,
Krzysztof
