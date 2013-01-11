From: olof@lixom.net (Olof Johansson)
Date: Fri, 11 Jan 2013 11:53:31 -0800
Subject: [PATCH 0/2 v2] at91/ssc: fixes on ASoC tree for 3.8
In-Reply-To: <20130111193948.GA8677@opensource.wolfsonmicro.com>
References: <cover.1357912706.git.nicolas.ferre@atmel.com>
 <CAOesGMhhSkrvP7X=y8qmdMKKXZ694+1+ZXY3y6HK1E85qaN5sQ@mail.gmail.com>
 <20130111193948.GA8677@opensource.wolfsonmicro.com>
Message-ID: <20130111195331.GA2533@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 11, 2013 at 07:39:49PM +0000, Mark Brown wrote:
> On Fri, Jan 11, 2013 at 10:52:19AM -0800, Olof Johansson wrote:
> > On Fri, Jan 11, 2013 at 6:08 AM, Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
> > 
> > > This material was designed to enter Mark's fixes queue, but as discussed with
> > > Olof, we can imagine merging everything through arm-soc or split the series (of
> > > 2 patches) and let them progress upstream separated (option that I do not like
> > > even if I know that the consequences are not so dramatic).
> > > So please, Olof, if you feel confortable with this series, tell us what you
> > > prefer and we will make our best to make this material go forward...
> 
> > You're setting yourself up for awkward merges. The driver change is
> > strongly dependent on the device tree change by failing probe unless
> > the device tree update is there, while before this patch, it still
> > worked.
> 
> This is partly my fault for getting grumpy about adding the bolier plate
> code without error checking - overall Linus' change to do the get in the
> core seems like the most sane approach here.
> 
> > But to be honest, I don't think this is a fix, it's a feature that you
> > just didn't include in time for the merge window. I don't really see
> > them as appropriate 3.8 material at this point.
> 
> Jean-Christophe has been most insistent that pinctrl support is now
> manadatory for all AT91 systems using device tree. 

That's a noble goal but enforcing it early gives everyone a lot of pain, and
quite honestly doesn't make sense. During transition it's better to be lenient
and allow both old and new methods (without breakage), unless it causes
significant extra churn.

> Unfortunately
> pinctrl support for AT91 only came in during the merge window and it
> seems like it's sadly been impossible to do what seemd like the obvious
> thing and add the pinctrl bindings to the DT prior to the merge down so
> now we've got this mess.  I believe the way the pinctrl conversion was
> done renders the audio driver non-functional without this series.

The problem is that at91 tries to do too much in a single release, and then do
nothing in several releases after. If there was a steadier trickle of code
coming in, then these kind of complex dependencies wouldn't show up all at
once, and could be handled with much less overhead for everyone else involved.
:(

> 
> > So, nack on this series. Please make the driver change non-dependent
> > on the new dtsi contents, and merge that through the ASoC tree. Then
> > the dtsi update can go through arm-soc, and later on you can make it
> > mandatory.
> 
> Like I say I'm not thrilled about ignoring the return code TBH, nor am I
> thrilled with the way this has been handled overall.  That said, the
> current series does seem like the best of a bad job - as I understand it
> we need something like this in v3.8 to make the driver functional.

To be honest, if Atmel can't figure out how to merge a complete feature
without causing intentional regressions during the merge window, and plan
on brokenness to be fixed as late as in -rc4, then they deserve to have
a broken platform. Unfortunately the victim of that is end users, and we
don't want to leave them hanging. This really can't become a trend though.

Sigh. Feel free to add:

Reluctantly-acked-by: Olof Johansson <olof@lixom.net>

to the patches when you apply them (based on IRC discussion, might as
well take both through ASoC).


-Olof
