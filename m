From: computersforpeace@gmail.com (Brian Norris)
Date: Sun, 3 Apr 2016 23:51:34 -0700
Subject: [PATCH v2] mtd: avoid stack overflow in MTD CFI code
In-Reply-To: <10357051.EVa2c1MaZl@wuerfel>
References: <1456748436-522413-1-git-send-email-arnd@arndb.de>
 <2259988.Lj3BC6sPv6@wuerfel> <20160318174419.GA70362@google.com>
 <10357051.EVa2c1MaZl@wuerfel>
Message-ID: <20160404065134.GD13995@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 18, 2016 at 09:25:23PM +0100, Arnd Bergmann wrote:
> On Friday 18 March 2016 10:44:19 Brian Norris wrote:
> > FWIW, I took a little look at this, and I can reproduce this myself. I
> > can get a large frame size on at least 2 of the 3 functions you report.
> > I think most of the gain you get with this patch is due to the Kconfig
> > change (MTD_COMPLEX_MAPPINGS) because it forces an extra level of
> > indirection. The other changes seem to give a modest decrease in size,
> > though it's less clear why exactly.
> > 
> > Anyway, I think the problem isn't primarily with anything you're
> > touching here exactly, but with the fact that we're putting several
> > copies of the 'map_word' typedef on the stack, and doing assignment to
> > it as if it's a typical variable. But with MAP_WIDTH_32, this is a
> > 32-byte object, and I assume that these (too) long functions are
> > introducing enough complexity that the compiler has to have several
> > copies of them. To properly fix all this, it seems like the code could
> > use some more attention, and not just the superficial changes here.
> > 
> > Anyway, I'm interested if you have any more thoughts on this. If you
> > still think this is worthwhile, I can probably just take it. (It looks
> > OK, despite the above comments.)
> 
> I'd like to get this fixed in one way or another, but I'm not
> particularly attached to my specific workaround.
> 
> If you don't think anyone will be able to reduce the number of
> map_word instances on the stack, please add my patch so at least
> we get rid of the warning and make it less likely to hit the bug.

OK, pushed to l2-mtd.git.

> An alternative might be to optionally move the map_word_and/clr/or/...
> operations out of line for large sizes of map_word, so we don't
> have all instances on the stack at once.

Hmm, I guess given the right amount of macro magic, it might be possible
to do this while still remaining optimal for small word sizes. But I'm
not sure anyone is really tackling these sorts of things on these
ancient drivers.

Brian
