From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 26 Sep 2014 17:02:04 +0200
Subject: [PATCH v3 11/12] mmc: sunxi: Convert MMC driver to the standard
 clock phase API
In-Reply-To: <3992138.y6J8TjIuMq@pagira.o2s.ch>
References: <1410466706-27386-1-git-send-email-maxime.ripard@free-electrons.com>
 <1410466706-27386-12-git-send-email-maxime.ripard@free-electrons.com>
 <3992138.y6J8TjIuMq@pagira.o2s.ch>
Message-ID: <20140926150204.GT15315@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 26, 2014 at 04:27:10PM +0200, David Lanzend?rfer wrote:
> Hello
> > Now that we have proper support to use the generic phase API in our clock
> > driver, switch the MMC driver to use it.
> > [...]
> >  	/* determine delays */
> >  	if (rate <= 400000) {
> > -		oclk_dly = 0;
> > -		sclk_dly = 7;
> > +		oclk_dly = 180;
> > +		sclk_dly = 42;
> > [...]
> How did you calculate the actual phase values from the original parameters?

Like shown in the clock driver. 0 is always a 180 deg phase shift, and
any other value is the number of the parent clock cycle to outphase
the clock of.

the clock out phase is calculating using:

phase = 360 * interval / period.

with period = 1 / (parent_freq / divider)
and interval = reg / parent_freq

which makes

phase = 360 * (reg / parent_freq) * (parent_freq / divider)

If we simplify by removing the parent_freq, we end up with

phase = 360 * reg / divider, which makes it rather trivial to
calculate.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140926/6476fba8/attachment.sig>
