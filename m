From: snitzer@redhat.com (Mike Snitzer)
Date: Tue, 8 Dec 2015 12:10:13 -0500
Subject: dm verity: use sector_div for division
In-Reply-To: <2666833.eM84rj4CYY@wuerfel>
References: <2666833.eM84rj4CYY@wuerfel>
Message-ID: <20151208171013.GA4263@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 08 2015 at 10:42am -0500,
Arnd Bergmann <arnd@arndb.de> wrote:

> The dm verity sec implementation uses do_div for dividing a sector_t,
> which is slower than necessary when sector_t is a 32-bit type, and
> we now get a warning for this case:
> 
> include/asm-generic/div64.h:224:22: warning: passing argument 1 of '__div64_32' from incompatible pointer type [-Wincompatible-pointer-types]
> drivers/md/dm-verity-fec.c:725:6: note: in expansion of macro 'do_div'
>   if (do_div(f->rounds, f->rsn))
> 
> This changes the code to use sector_div instead, which does the
> right thing and avoids the warning.

Thanks, I'll fold this in.

(Btw, I did review this use of do_div(): but only to answer whether there
was potential for a 64bit divide.  I concluded do_div() was fine but didn't
look to see the data type for f->rounds was actually sector_t.)
