From: computersforpeace@gmail.com (Brian Norris)
Date: Fri, 18 Mar 2016 10:44:19 -0700
Subject: [PATCH v2] mtd: avoid stack overflow in MTD CFI code
In-Reply-To: <2259988.Lj3BC6sPv6@wuerfel>
References: <1456748436-522413-1-git-send-email-arnd@arndb.de>
 <20160304212159.GA55664@google.com> <2259988.Lj3BC6sPv6@wuerfel>
Message-ID: <20160318174419.GA70362@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 05, 2016 at 12:25:24AM +0100, Arnd Bergmann wrote:
> On Friday 04 March 2016 13:21:59 Brian Norris wrote:
> > 
> > Looking a little closer at this... why do we need the changes to
> > include/linux/mtd/map.h again? It should be fine to leave these
> > definitions as-is, right? They don't contribute to the large stack
> > usage, do they?
> > 
> > Maybe I'm just missing something obvious, so please do enlighten 
> > 
> 
> It's been a while since I created the patch, and the originally
> failing configuration currently doesn't produce this (probably
> because something else changed). I remember that it was something
> rather subtle, but don't exactly remember what happened.
> 
> I've reverted the patch now, trying to reproduce it on my
> randconfig setup, but I might not be able to get back to you
> in the next week while I'm traveling.

FWIW, I took a little look at this, and I can reproduce this myself. I
can get a large frame size on at least 2 of the 3 functions you report.
I think most of the gain you get with this patch is due to the Kconfig
change (MTD_COMPLEX_MAPPINGS) because it forces an extra level of
indirection. The other changes seem to give a modest decrease in size,
though it's less clear why exactly.

Anyway, I think the problem isn't primarily with anything you're
touching here exactly, but with the fact that we're putting several
copies of the 'map_word' typedef on the stack, and doing assignment to
it as if it's a typical variable. But with MAP_WIDTH_32, this is a
32-byte object, and I assume that these (too) long functions are
introducing enough complexity that the compiler has to have several
copies of them. To properly fix all this, it seems like the code could
use some more attention, and not just the superficial changes here.

Anyway, I'm interested if you have any more thoughts on this. If you
still think this is worthwhile, I can probably just take it. (It looks
OK, despite the above comments.)

Brian
