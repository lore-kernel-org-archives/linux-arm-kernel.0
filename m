From: joe@perches.com (Joe Perches)
Date: Wed, 05 Feb 2014 05:04:54 -0800
Subject: [ath9k-devel] [PATCH 1/3] ath9k: Fix build error on ARM
In-Reply-To: <20140205124127.GP26684@n2100.arm.linux.org.uk>
References: <1391483274-20331-1-git-send-email-sujith@msujith.org>
 <1391483274-20331-2-git-send-email-sujith@msujith.org>
 <1391484878.2538.11.camel@joe-AO722>
 <21232.24855.201543.400943@gargle.gargle.HOWL>
 <CAOpc7mFQZ3efZda0cC28BLATqRDJ99BRNu=ezQq8wa+dyFyOvA@mail.gmail.com>
 <1391531796.2538.21.camel@joe-AO722>
 <20140205115035.GO26684@n2100.arm.linux.org.uk>
 <1391603566.2538.63.camel@joe-AO722>
 <20140205124127.GP26684@n2100.arm.linux.org.uk>
Message-ID: <1391605494.2538.68.camel@joe-AO722>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-02-05 at 12:41 +0000, Russell King - ARM Linux wrote:
> On Wed, Feb 05, 2014 at 04:32:46AM -0800, Joe Perches wrote:
> > Apparently, people just convert stupidly large udelay()s
> > to mdelay and not be bothered.
> 
> And that's the correct answer.  Having udelay(10000) rather than mdelay(10)
> is a sign that they weren't paying that much attention when writing the
> code.

Not really.

Look at the code that brought this up in the first place.

On Tue, 2014-02-04 at 08:37 +0530, Sujith Manoharan wrote:
> From: Sujith Manoharan <c_manoha@qca.qualcomm.com>
> 
> Use mdelay instead of udelay to fix this error:
> 
> ERROR: "__bad_udelay" [drivers/net/wireless/ath/ath9k/ath9k_hw.ko] undefined!
[]
diff --git a/drivers/net/wireless/ath/ath9k/hw.c b/drivers/net/wireless/ath/ath9k/hw.c
[]
> @@ -1316,7 +1316,7 @@ static bool ath9k_hw_set_reset(struct ath_hw *ah, int type)
>  	if (AR_SREV_9300_20_OR_LATER(ah))
>  		udelay(50);
>  	else if (AR_SREV_9100(ah))
> -		udelay(10000);
> +		mdelay(10);
>  	else
>  		udelay(100);
>  
> 
> >     if (AR_SREV_9300_20_OR_LATER(ah))
> >             udelay(50);
> >     else if (AR_SREV_9100(ah))
> > -           udelay(10000);
> > +           mdelay(10);
> >     else
> >             udelay(100);

One chip needs a larger delay than the others.

It's not so much not paying attention as not
knowing ARM is broken for large udelay().
