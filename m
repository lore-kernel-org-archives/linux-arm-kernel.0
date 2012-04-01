From: lost.distance@yahoo.com (Paul Parsons)
Date: Sun, 1 Apr 2012 18:56:34 +0100 (BST)
Subject: [PATCH] ARM: pxa: mfp: Force gpio direction for
 MFP_LPM_KEEP_OUTPUT
In-Reply-To: <4F7848DE.2080605@compulab.co.il>
Message-ID: <1333302994.55909.YahooMailClassic@web29020.mail.ird.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Igor,

--- On Sun, 1/4/12, Igor Grinberg <grinberg@compulab.co.il> wrote:
> On 04/01/12 13:56, Paul Parsons
> wrote:
> > Hello Igor,
> > 
> > --- On Sun, 1/4/12, Igor Grinberg <grinberg@compulab.co.il>
> wrote:
> >> Hi Paul,
> >>
> >> On 03/31/12 15:20, Paul Parsons wrote:
> >>> Some MFP configurations specify
> MFP_LPM_KEEP_OUTPUT to
> >> preserve the gpio output
> >>> value (HIGH or LOW) during sleep mode. For
> example:
> >>>
> >>>? ? ? GPIO72_GPIO |
> >> MFP_LPM_KEEP_OUTPUT,
> >>>
> >>> Unfortunately MFP_LPM_KEEP_OUTPUT makes no
> special
> >> provision for setting the
> >>> sleep mode gpio direction, unlike
> MFP_LPM_DRIVE_HIGH
> >> and MFP_LPM_DRIVE_LOW.
> >>> Consequently MFP configurations of the form:
> >>>
> >>>? ? ? GPIO<n>_GPIO |
> >> MFP_LPM_KEEP_OUTPUT,
> >>>
> >>> will set the sleep mode gpio direction to
> INPUT.
> >>>
> >>> This patch forces the sleep mode gpio direction
> to
> >> OUTPUT in cases where
> >>> MFP_LPM_KEEP_OUTPUT was specified. This brings
> >> MFP_LPM_KEEP_OUTPUT into line
> >>> with MFP_LPM_DRIVE_HIGH and MFP_LPM_DRIVE_LOW.
> >>>
> >>> Signed-off-by: Paul Parsons <lost.distance@yahoo.com>
> >>> ---
> >>>
> >>> diff --git a/arch/arm/mach-pxa/mfp-pxa2xx.c
> >> b/arch/arm/mach-pxa/mfp-pxa2xx.c
> >>> index b0a8428..3b443199 100644
> >>> --- a/arch/arm/mach-pxa/mfp-pxa2xx.c
> >>> +++ b/arch/arm/mach-pxa/mfp-pxa2xx.c
> >>> @@ -96,6 +96,9 @@ static int
> __mfp_config_gpio(unsigned
> >> gpio, unsigned long c)
> >>>? ? ? ?
> ???break;
> >>>? ? ???}
> >>>???
> >>> +? ? if (c &
> MFP_LPM_KEEP_OUTPUT)
> >>> +? ? ? ? is_out = 1;
> >>> +
> >>
> >> MFP_LPM_KEEP_OUTPUT does not meant to be used to
> setup the
> >> mfp config,
> > 
> > As far as I can see, MFP_LPM_KEEP_OUTPUT is *only* used
> to setup the
> > mfp config:
> > 
> > % xzcat linux-3.4-rc1.tar.xz | fgrep -a
> MFP_LPM_KEEP_OUTPUT
> > ??? GPIO13_GPIO |
> MFP_LPM_KEEP_OUTPUT,??? /*
> CORGI_GPIO_LED_ORANGE */
> > ??? GPIO38_GPIO |
> MFP_LPM_KEEP_OUTPUT,??? /* CORGI_GPIO_CHRG_ON
> */
> > ??? GPIO43_GPIO |
> MFP_LPM_KEEP_OUTPUT,??? /*
> CORGI_GPIO_CHRG_UKN */
> > #define MFP_LPM_KEEP_OUTPUT??? (0x1
> << 25)
> > ??? /* set corresponding PGSR bit of
> those marked MFP_LPM_KEEP_OUTPUT */
> > ??? ??? if
> ((gpio_desc[i].config & MFP_LPM_KEEP_OUTPUT) &&
> > % 
> 
> How can you be certain that you don't break corgi, with the
> proposed patch?

On corgi, the three GPIOs configured as MFP_LPM_KEEP_OUTPUT:
    CORGI_GPIO_LED_ORANGE
    CORGI_GPIO_CHRG_ON
    CORGI_GPIO_CHRG_UKN
are all used as outputs.

> >> but for pins that have been configured for output
> by
> >> gpio_direction_out().
> >> (Hint: *_KEEP_*).
> > 
> > MFP_LPM_KEEP_OUTPUT only takes effect when the system
> enters sleep mode,
> > at which point the GPIO directions (GPDR registers) are
> forced from the
> > values privately stored in gpdr_lpm[].
> 
> Correct, but with your patch, the direction will be forced
> to output,
> but the value will be undefined...

The values will be defined in pxa2xx_mfp_suspend() when it sets the PGSR
registers. Or at least they will be on corgi and hx4700, but see below...

> > As far as I can tell MFP_LPM_KEEP_OUTPUT has no direct
> connection to
> > gpio_direction_output().
> 
> Well, it has... in the pxa2xx_mfp_suspend() function you've
> pasted below.
> 
> > 
> >> Also, I don't think this is a good idea, because
> the patch
> >> allows a pin
> >> be configured as output, but does not forces a
> value
> >> (high/low)
> >> and this is not safe.
> > 
> > A value does not need to be provided until the system
> enters sleep mode,
> > at which point the value is provided via the PGSR
> registers.
> 
> Yes, but you don't force the PGSR to be set...
> and that is the problem.

OK, see below...

> >? ? 353??? static int
> pxa2xx_mfp_suspend(void)
> >? ? 354??? {
> >? ? 355??? ???
> int i;
> >? ? 356??? 
> >? ? 357??? ???
> /* set corresponding PGSR bit of those marked
> MFP_LPM_KEEP_OUTPUT */
> >? ? 358??? ???
> for (i = 0; i < pxa_last_gpio; i++) {
> >? ? 359??? ???
> ??? if ((gpio_desc[i].config &
> MFP_LPM_KEEP_OUTPUT) &&
> >? ? 360??? ???
> ??? ? ? (GPDR(i) &
> GPIO_bit(i))) {
> 
> Look at the check above...
> the PGSR only gets set for the GPIOs configured to output
> (presumably by gpio_direction_output() function).

OK, I understand your objection here.

My feeling is that the (GPDR(i) & GPIO_bit(i)) test is unwanted because
the current state of GPDR (via gpio_direction_output()) does not apply in
sleep mode, yet for some reason it is being allowed to prevent the
setting of PGSR in the case of GPIO inputs.

Consequently the (GPDR(i) & GPIO_bit(i)) test should be removed.

> >? ? 361??? ???
> ??? ??? if (GPLR(i) &
> GPIO_bit(i))
> >? ? 362??? ???
> ??? ??? ???
> PGSR(gpio_to_bank(i)) |= GPIO_bit(i);
> >? ? 363??? ???
> ??? ??? else
> >? ? 364??? ???
> ??? ??? ???
> PGSR(gpio_to_bank(i)) &= ~GPIO_bit(i);
> >? ? 365??? ???
> ??? }
> >? ? 366??? ???
> }
> >? ? 367??? 
> >? ? 368??? ???
> for (i = 0; i <= gpio_to_bank(pxa_last_gpio); i++) {
> >? ? 369??? 
> >? ? ? ???...
> >? ? 375??? ???
> ??? GPDR(i * 32) = gpdr_lpm[i];
> >? ? 376??? ???
> }
> >? ? 377??? ???
> return 0;
> >? ? 378??? }
> > 
> > However looking at pxa2xx_mfp_suspend() more closely it
> is true that the
> > GPDR registers are set before the PGSR values take
> effect (when the
> > processor enters sleep mode).
> > That is no different from MFP_LPM_DRIVE_HIGH or
> MFP_LPM_DRIVE_LOW though.
> 
> Well, it is different, because the in case of
> MFP_LPM_DRIVE_*,
> the PGSR is set in the __mfp_config_gpio() function and has
> a _known value_.

KEEP_OUTPUT does the same where GPIOs are configured as outputs, as is
the case with corgi and hx4700.
Your valid objection is for cases where GPIOs are configured as inputs.
So I presume that removing the (GPDR(i) & GPIO_bit(i)) test will satisfy
your objection.

> > So the presumption must be that the GPIOs configured as
> DRIVE_HIGH,
> > DRIVER_LOW and now KEEP_OUTPUT already have a valid
> direction and value
> > set at the point the GPDR registers are forced.
> 
> Yes. That is exactly my point here.
> MFP_LPM_DRIVE_* has the value determined and set.
> MFP_LPM_KEEP_OUTPUT does not, but with your patch it will
> effectively
> force the GPIO to be output in sleep mode, but with no value
> set!

Only in cases where the GPIO is used as an input in normal mode but
configured to be an output in sleep mode.
Removing the (GPDR(i) & GPIO_bit(i)) test addresses that case.

> >> Why can't you use:
> >> GPIO<n>_GPIO | MFP_LPM_DRIVE_<level>
> >> ?
> > 
> > The hx4700 has a couple of charging GPIOs which we want
> to keep HIGH or
> > LOW during sleep mode:
> > 
> > % fgrep MFP_LPM_KEEP_OUTPUT arch/arm/mach-pxa/hx4700.c
> > ??? GPIO72_GPIO |
> MFP_LPM_KEEP_OUTPUT,??? /* BQ24022_nCHARGE_EN
> */
> > ??? GPIO96_GPIO |
> MFP_LPM_KEEP_OUTPUT,??? /* BQ24022_ISET2 */
> > % 
> 
> I still, can't understand, why MFP_LPM_DRIVE_* does not do
> the job for you...
> What's the real problem with using MFP_LPM_DRIVE_*?
> Can't you specify it for those GPIO72/96?

The feeling was that if the unit was charging in normal mode then it
should remain charging in sleep mode, and if it wasn't then it should
remain not charging.
Actually that's an interim solution until the bootloader can take control
of sleep mode charging, but we're not there yet.

Regards,
Paul
