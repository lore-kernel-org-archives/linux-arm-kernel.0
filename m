From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 7 Dec 2017 13:31:36 +0100
Subject: [RFC] Improving udelay/ndelay on platforms where that is possible
In-Reply-To: <CAD=FV=VKEz9jvJaD2KTitH=2G+wb42RXHyRVKi4-zrypAu9jSA@mail.gmail.com>
References: <d3f42f35-8175-58f6-78b7-3331efe64da2@sigmadesigns.com>
 <CA+55aFzy9=RtFRuJhFbF+PL_PCrkZsKtAKrq6WJo1z9eW9gLSA@mail.gmail.com>
 <20171031165629.GF9463@n2100.armlinux.org.uk>
 <CA+55aFwDquBXt_EYT3JFoWkeFsZTym5qUXig-DePXXzm07uABw@mail.gmail.com>
 <CAD=FV=V3n0gjzpL860V6cgf8JVh5pmoL+i0t63Oot19T2afTPw@mail.gmail.com>
 <20171101092618.GN9463@n2100.armlinux.org.uk>
 <CAD=FV=VKEz9jvJaD2KTitH=2G+wb42RXHyRVKi4-zrypAu9jSA@mail.gmail.com>
Message-ID: <20171207123136.GB24547@atrey.karlin.mff.cuni.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> On Wed, Nov 1, 2017 at 2:26 AM, Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
> > On Tue, Oct 31, 2017 at 05:23:19PM -0700, Doug Anderson wrote:
> >> Hi,
> >>
> >> On Tue, Oct 31, 2017 at 10:45 AM, Linus Torvalds
> >> <torvalds@linux-foundation.org> wrote:
> >> > So I'm very much open to udelay improvements, and if somebody sends
> >> > patches for particular platforms to do particularly well on that
> >> > platform, I think we should merge them. But ...
> >>
> >> If I'm reading this all correctly, this sounds like you'd be willing
> >> to merge <https://patchwork.kernel.org/patch/9429841/>.  This makes
> >> udelay() guaranteed not to underrun on arm32 platforms.
> >
> > That's a mis-representation again.  It stops a timer-based udelay()
> > possibly underrunning by one tick if we are close to the start of
> > a count increment.  However, it does nothing for the loops_per_jiffy
> > udelay(), which can still underrun.
> >
> > My argument against merging that patch is that with it merged, we get
> > (as you say) a udelay() that doesn't underrun _when using a timer_
> > but when we end up using the loops_per_jiffy udelay(), we're back to
> > the old problem.
> >
> > My opinion is that's bad, because it encourages people to write drivers
> > that rely on udelay() having "good" behaviour, which it is not guaranteed
> > to have.  So, they'll specify a delay period of exactly what they want,
> > and their drivers will then fail when running on systems that aren't
> > using a timer-based udelay().
> 
> IMHO the current udelay is broken in an off-by-one way and it's easy
> to fix.  Intentionally leaving a bug in the code seems silly.  This
> seems to by what Linus is saying with his statement that "(a) platform
> code could try to make their udelay/ndelay() be as good as it can be
> on a particular platform".
> 
> So no matter the rest of the discussions, we should land that.  If you
> disagree then I'm happy to re-post that patch straight to Linus later
> this week since it sounds as if he'd take it.

Did this get fixed in any way? Russell having crazy arguments for
keeping kernel buggy should not be good enough reason to keep the
bugs...

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
