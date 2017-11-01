From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 1 Nov 2017 09:26:18 +0000
Subject: [RFC] Improving udelay/ndelay on platforms where that is possible
In-Reply-To: <CAD=FV=V3n0gjzpL860V6cgf8JVh5pmoL+i0t63Oot19T2afTPw@mail.gmail.com>
References: <d3f42f35-8175-58f6-78b7-3331efe64da2@sigmadesigns.com>
 <CA+55aFzy9=RtFRuJhFbF+PL_PCrkZsKtAKrq6WJo1z9eW9gLSA@mail.gmail.com>
 <20171031165629.GF9463@n2100.armlinux.org.uk>
 <CA+55aFwDquBXt_EYT3JFoWkeFsZTym5qUXig-DePXXzm07uABw@mail.gmail.com>
 <CAD=FV=V3n0gjzpL860V6cgf8JVh5pmoL+i0t63Oot19T2afTPw@mail.gmail.com>
Message-ID: <20171101092618.GN9463@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 31, 2017 at 05:23:19PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Tue, Oct 31, 2017 at 10:45 AM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> > So I'm very much open to udelay improvements, and if somebody sends
> > patches for particular platforms to do particularly well on that
> > platform, I think we should merge them. But ...
> 
> If I'm reading this all correctly, this sounds like you'd be willing
> to merge <https://patchwork.kernel.org/patch/9429841/>.  This makes
> udelay() guaranteed not to underrun on arm32 platforms.

That's a mis-representation again.  It stops a timer-based udelay()
possibly underrunning by one tick if we are close to the start of
a count increment.  However, it does nothing for the loops_per_jiffy
udelay(), which can still underrun.

My argument against merging that patch is that with it merged, we get
(as you say) a udelay() that doesn't underrun _when using a timer_
but when we end up using the loops_per_jiffy udelay(), we're back to
the old problem.

My opinion is that's bad, because it encourages people to write drivers
that rely on udelay() having "good" behaviour, which it is not guaranteed
to have.  So, they'll specify a delay period of exactly what they want,
and their drivers will then fail when running on systems that aren't
using a timer-based udelay().

If we want udelay() to have this behaviour, it needs to _always_ have
this behaviour irrespective of the implementation.  So that means
the loops_per_jiffy version also needs to be fixed in the same way,
which IMHO is impossible.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
