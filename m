From: joe@perches.com (Joe Perches)
Date: Sun, 08 Apr 2012 22:02:29 -0700
Subject: [PATCH] dma: pl330: fix a couple of compilation warnings
In-Reply-To: <CAOesGMgav3iqqNBtc1DccKKvRSpnNnDaCZmKBsdHj4feq-ns_A@mail.gmail.com>
References: <1333919920-25481-1-git-send-email-olof@lixom.net>
 <1333921246.2508.8.camel@joe2Laptop>
 <CAOesGMgav3iqqNBtc1DccKKvRSpnNnDaCZmKBsdHj4feq-ns_A@mail.gmail.com>
Message-ID: <1333947749.4172.4.camel@joe2Laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2012-04-08 at 16:24 -0700, Olof Johansson wrote:
> On Sun, Apr 8, 2012 at 2:40 PM, Joe Perches <joe@perches.com> wrote:
> > On Sun, 2012-04-08 at 14:18 -0700, Olof Johansson wrote:
> >> Move a couple of tests and do a minor refactor to avoid:
> > []
> >> diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
> > []
> >> @@ -2926,8 +2928,9 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
> >>       INIT_LIST_HEAD(&pd->channels);
> >>
> >>       /* Initialize channel parameters */
> >> -     num_chan = max(pdat ? pdat->nr_valid_peri : (u8)pi->pcfg.num_peri,
> >> -                     (u8)pi->pcfg.num_chan);
> >> +     num_chan = max_t(int, pdat ? pdat->nr_valid_peri :
> >> +                                  pi->pcfg.num_peri,
> >> +                           pi->pcfg.num_chan);
> >>       pdmac->peripherals = kzalloc(num_chan * sizeof(*pch), GFP_KERNEL);
> >
> > Few trivial things:
> >
> > There's no error checking for a malloc failure
> > This should probably be kcalloc
> 
> Yes, this driver could do with further cleanups, congratulations on
> your observations.
> 
> All of that is completely unrelated to this patch. Feel free to submit
> your own changes to clean up the driver further.

No thanks.  It's adjacent to the lines you modify
which is the only reason I noticed.  You might
also notice any patch I submit against the current
tree would conflict with your changes.

It'd be better if you actually fix problems with
the code and not simply make compiler warnings be
silenced when the problem is fundamentally that
the compiler is needs improvements.
