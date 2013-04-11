From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Thu, 11 Apr 2013 11:54:21 +0200
Subject: [PATCH v2] pinctrl: Add pinctrl-s3c24xx driver
In-Reply-To: <3973166.f1dd7C8GWR@amdc1227>
References: <201304110116.41525.heiko@sntech.de>
 <201304111132.05009.heiko@sntech.de> <3973166.f1dd7C8GWR@amdc1227>
Message-ID: <201304111154.22073.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 11. April 2013, 11:43:19 schrieb Tomasz Figa:
> On Thursday 11 of April 2013 11:32:03 Heiko St?bner wrote:
> > Am Donnerstag, 11. April 2013, 10:54:45 schrieb Tomasz Figa:
> > > Hi Heiko,
> > > 
> > > As previously, generally looks good to me, but see my comments inline.
> > > 
> > > On Thursday 11 of April 2013 01:16:41 Heiko St?bner wrote:
> > > > The s3c24xx pins follow a similar pattern as the other Samsung SoCs
> > > > and can therefore reuse the already introduced infrastructure.
> > > > 
> > > > The s3c24xx SoCs have one design oddity in that the first 4 external
> > > > interrupts do not reside in the eint pending register but in the main
> > > > interrupt controller instead. We solve this by forwarding the
> > > > external interrupt from the main controller into the irq domain of
> > > > the pin bank. The masking/acking of these interrupts is handled in
> > > > the same way.
> > > > 
> > > > Furthermore the S3C2412/2413 SoCs contain another oddity in that they
> > > > keep the same 4 eints in the main interrupt controller and eintpend
> > > > register and requiring ack operations to happen in both. To solve
> > > > this a ctrl_type enum is introduced which can keep the type of
> > > > controller
> > > 
> > > Hmm, I think you forgot to edit the commit message, since we decided to
> > > replace ctrl_type with another compatible string.
> > 
> > One should not do these things after midnight :-) [true for most of the
> > other mistakes below too].
> > 
> > > > in the samsung_pin_ctrl struct for later retrieval.
> > > > 
> > > > The ctrl_type enum contains only S3C24XX and S3C2412 types, as the
> > > > eint-speciality is currently the only use-case. But it can be expaned
> > > > if other SoCs gain special handling requirements later on.
> > > > 
> > > > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > > > ---
> > > > changes since v1:
> > > > 
> > > > - address comments from Tomasz Figa:
> > > >   * split handling functions for eints 0-3 for s3c2412 and all others
> > > >   * change the handling for s3c2412 eints 0-3 in that they now use
> > > >   
> > > >     chained_irq_* for the outer parent interrupt
> > > 
> > > OK, so you finally decided to use the way I suggested. Have you managed
> > > to do some testing on a S3C2412?
> > 
> > Nope, after pondering everything a bit more ... your description just
> > sounded more plausible :-) . I only have access to s3c2416 and s3c2450
> > boards, so everything else is just done according to datasheets and in
> > the hope of it being correct. S3C2412 is really the only familiy member
> > having the 4 eints in both registers.
> > 
> > Also the (reworked) legacy eint code also uses this scheme ... so at
> > least now both are either correct or wrong. We will only know if someone
> > with a s3c2412 comes along at some point :-) .
> 
> That's why I was wondering whether it is possible to get a board with
> S3C2412 or 13 somewhere. The Logitech controller would be pretty
> interesting, but is it still possible to get it? (Btw. Is it mach-jive in
> the kernel?)

The squeezebox controller is still available in some shops, but the prices 
their asking (>=160 EUR for the controller alone) are in no relation to the 
age and "power" of the hardware. And yes they're the jive mach.
