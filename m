From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 5 Feb 2014 14:21:26 +0000
Subject: [ath9k-devel] [PATCH 1/3] ath9k: Fix build error on ARM
In-Reply-To: <1391608993.2538.74.camel@joe-AO722>
References: <1391484878.2538.11.camel@joe-AO722>
 <21232.24855.201543.400943@gargle.gargle.HOWL>
 <CAOpc7mFQZ3efZda0cC28BLATqRDJ99BRNu=ezQq8wa+dyFyOvA@mail.gmail.com>
 <1391531796.2538.21.camel@joe-AO722>
 <20140205115035.GO26684@n2100.arm.linux.org.uk>
 <1391603566.2538.63.camel@joe-AO722>
 <20140205124127.GP26684@n2100.arm.linux.org.uk>
 <1391605494.2538.68.camel@joe-AO722>
 <20140205133956.GQ26684@n2100.arm.linux.org.uk>
 <1391608993.2538.74.camel@joe-AO722>
Message-ID: <20140205142126.GR26684@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 05, 2014 at 06:03:13AM -0800, Joe Perches wrote:
> On Wed, 2014-02-05 at 13:39 +0000, Russell King - ARM Linux wrote:
> > On Wed, Feb 05, 2014 at 05:04:54AM -0800, Joe Perches wrote:
> > > On Wed, 2014-02-05 at 12:41 +0000, Russell King - ARM Linux wrote:
> > > > On Wed, Feb 05, 2014 at 04:32:46AM -0800, Joe Perches wrote:
> > > > > Apparently, people just convert stupidly large udelay()s
> > > > > to mdelay and not be bothered.
> > > > 
> > > > And that's the correct answer.  Having udelay(10000) rather than mdelay(10)
> > > > is a sign that they weren't paying that much attention when writing the
> > > > code.
> > > 
> > > Not really.
> []
> > > It's not so much not paying attention as not
> > > knowing ARM is broken for large udelay().
> > 
> > And now read my suggestion about how to avoid the "not knowing" problem. :)
> 
> I'd read it already.  I didn't and don't disagree.

Please explain /why/ you don't agree.

> I still think adding a #warning on large static udelay()s
> would be sensible.  Maybe adding another option like
> #define UDELAY_TOO_BIG_I_KNOW_ALREADY_DONT_BOTHER_ME
> guard to avoid seeing the #warning when there's no other
> option.

How does that help?  It's /not/ a warning situation - if you ask for
udelay(10000) on ARM, you will /not/ get a 10ms delay.  You'll instead
get something much shorter because the arithmetic will overflow.

Now, you could argue that maybe ARM's udelay() implementation should
know about this and implement a loop around the underlying udelay()
implementation to achieve it, and I might agree with you - but I
don't for one very simple reason: we /already/ have such an
implementation.  It's called mdelay():

#ifndef mdelay
#define mdelay(n) (\
        (__builtin_constant_p(n) && (n)<=MAX_UDELAY_MS) ? udelay((n)*1000) : \
        ({unsigned long __ms=(n); while (__ms--) udelay(1000);}))
#endif

So, the right answer is /not/ do duplicate this, but to /use/ the
appropriate facilities provided by the kernel.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
