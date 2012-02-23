From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 23 Feb 2012 13:37:19 +0000
Subject: [PATCH] i.MX31: mxc-rnga: implement waiting for data in driver
In-Reply-To: <4F43AC8D.5090508@hale.at>
References: <1329826410-21739-1-git-send-email-michael.thalmeier@hale.at>
 <CAOMZO5BGVa0HRKqv9nKQUy9iGnQ3FV_6OnguMyk3rAinaJkb6w@mail.gmail.com>
 <4F43AC8D.5090508@hale.at>
Message-ID: <201202231337.20052.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 21 February 2012, Michael Thalmeier wrote:
> On 2012-02-21 14:29, Fabio Estevam wrote:
> 
> > On Tue, Feb 21, 2012 at 10:13 AM, Michael Thalmeier
> > <michael.thalmeier@hale.at> wrote:
> > 
> >> -static int mxc_rnga_data_present(struct hwrng *rng)
> >> +static int mxc_rnga_data_present(struct hwrng *rng, int wait)
> > 
> > This looks good, but ...
> > 
> >>  {
> >> -       int level;
> >> +       int level, i;
> >>        void __iomem *rng_base = (void __iomem *)rng->priv;
> >>
> >> -       /* how many random numbers is in FIFO? [0-16] */
> >> -       level = ((__raw_readl(rng_base + RNGA_STATUS) &
> >> -                       RNGA_STATUS_LEVEL_MASK) >> 8);
> >> +       for (i = 0; i < 20; i++) {
> > 
> > Why the magic "20" here?
> > 
> > It would be better to add a proper timeout mechanism instead, such as
> > time_after(jiffies, timeout)
> > 
> I am absolutely with you.
> The point is only that this is the behaviour of nearly all hw_random
> drivers, and I basically just copied it over into this driver.

Hmm, I guess they are all wrong then ;-)

It would be nice to move the retry loop into common code where it
would be easier to change.

Note that comparing jiffies is not going to help here because the
maximum delay in the loop is less than a jiffy.

	Arnd
