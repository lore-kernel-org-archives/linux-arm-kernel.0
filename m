From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 19 Dec 2014 18:50:00 +0100
Subject: [PATCH v2 3/4] mmc: sunxi: Convert MMC driver to the standard
 clock phase API
In-Reply-To: <CAGb2v64iWS65t31JP_YRTigGBi5+eaJX60s7nNjv87gt2aojXw@mail.gmail.com>
References: <1418765936-12542-1-git-send-email-maxime.ripard@free-electrons.com>
 <1418765936-12542-4-git-send-email-maxime.ripard@free-electrons.com>
 <CAGb2v64iWS65t31JP_YRTigGBi5+eaJX60s7nNjv87gt2aojXw@mail.gmail.com>
Message-ID: <20141219175000.GM4820@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 17, 2014 at 12:17:36PM +0800, Chen-Yu Tsai wrote:
> >         /* determine delays */
> >         if (rate <= 400000) {
> > -               oclk_dly = 0;
> > -               sclk_dly = 7;
> > +               oclk_dly = 180;
> > +               sclk_dly = 42;
> 
> 42 seems like an odd number. Maybe 45?

If the rate is at 400kHz, that means that the clock in muxed from the
24M, with a divider of 60.

That means that we can outphase the clocks only by a multiple of 6
(360 / 60). 7 * 6 = 42.

Depending on how the rounding goes, 45 might work too, but if we wan't
to be conservative, 42 doesn't change anything, 45 does.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141219/ed8963eb/attachment-0001.sig>
