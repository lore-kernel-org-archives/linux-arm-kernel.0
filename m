From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 04 Feb 2014 19:40:18 +0100
Subject: [ath9k-devel] [PATCH 1/3] ath9k: Fix build error on ARM
In-Reply-To: <1391531796.2538.21.camel@joe-AO722>
References: <1391483274-20331-1-git-send-email-sujith@msujith.org>
 <CAOpc7mFQZ3efZda0cC28BLATqRDJ99BRNu=ezQq8wa+dyFyOvA@mail.gmail.com>
 <1391531796.2538.21.camel@joe-AO722>
Message-ID: <3469296.SINb5BZOG8@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 04 February 2014 08:36:36 Joe Perches wrote:
> On Tue, 2014-02-04 at 08:03 +0100, Holger Schurig wrote:
> > Joe, look in linux/arch/arm/include/asm/delay.h. The macro udelay
> > cannot handle large values because of lost-of-precision.
> > 
> > IMHO udelay on ARM is broken, because it also cannot work with fast
> > ARM processors (where bogomips >= 3355, which is in sight now). It's
> > just not broken enought that someone did something against it ...   so
> > the current kludge is good enought.
> 
> Maybe something like this would be better?
> 

I actually like the fact that we get link errors for insane 'udelay'
times. In most cases it's a driver bug because we shouldn't keep
the CPU busy for an eternity in the kernel (and call msleep() instead).
For the rare cases where mdelay makes sense, we also want to add
a comment to the code explaining why msleep cannot be used.

	Arnd
