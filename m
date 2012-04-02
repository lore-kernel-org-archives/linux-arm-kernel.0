From: lost.distance@yahoo.com (Paul Parsons)
Date: Mon, 2 Apr 2012 14:33:28 +0100 (BST)
Subject: [PATCH] ARM: pxa: mfp: Force gpio direction for
 MFP_LPM_KEEP_OUTPUT
In-Reply-To: <4F799F33.4070507@compulab.co.il>
Message-ID: <1333373608.57077.YahooMailClassic@web29002.mail.ird.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Igor,

--- On Mon, 2/4/12, Igor Grinberg <grinberg@compulab.co.il> wrote:
> On 04/02/12 14:30, Paul Parsons
> wrote:
> > Hello Igor,
> > 
> > --- On Mon, 2/4/12, Igor Grinberg <grinberg@compulab.co.il>
> wrote:
> >> Hi Paul,
> >>
> >> Can you, please, configure your mailer to _not_
> wrap the
> >> text?
> >> It is rally hard to read it after a few replies...
> >>
> >> On 04/01/12 20:56, Paul Parsons wrote:
> >>> Hello Igor,
> >>>
> >>> --- On Sun, 1/4/12, Igor Grinberg <grinberg@compulab.co.il>
> >> wrote:
> >>>> On 04/01/12 13:56, Paul Parsons
> >>>> wrote:
> >>>>> Hello Igor,
> >>>>>
> >>>>> --- On Sun, 1/4/12, Igor Grinberg
> <grinberg@compulab.co.il>
> >>>> wrote:
> >>>>>> Hi Paul,
> >>>>>>
> >>>>>> On 03/31/12 15:20, Paul Parsons
> wrote:
> >>>>>>> Some MFP configurations
> specify
> >>>> MFP_LPM_KEEP_OUTPUT to
> >>>>>> preserve the gpio output
> >>>>>>> value (HIGH or LOW) during
> sleep mode.
> >> For
> >>>> example:
> >>>>>>>
> >>>>>>>? ? 
> >>? ? GPIO72_GPIO |
> >>>>>> MFP_LPM_KEEP_OUTPUT,
> >>>>>>>
> >>>>>>> Unfortunately
> MFP_LPM_KEEP_OUTPUT makes
> >> no
> >>>> special
> >>>>>> provision for setting the
> >>>>>>> sleep mode gpio direction,
> unlike
> >>>> MFP_LPM_DRIVE_HIGH
> >>>>>> and MFP_LPM_DRIVE_LOW.
> >>>>>>> Consequently MFP configurations
> of the
> >> form:
> >>>>>>>
> >>>>>>>? ? 
> >>? ? GPIO<n>_GPIO |
> >>>>>> MFP_LPM_KEEP_OUTPUT,
> >>>>>>>
> >>>>>>> will set the sleep mode gpio
> direction
> >> to
> >>>> INPUT.
> >>>>>>>
> >>>>>>> This patch forces the sleep
> mode gpio
> >> direction
> >>>> to
> >>>>>> OUTPUT in cases where
> >>>>>>> MFP_LPM_KEEP_OUTPUT was
> specified. This
> >> brings
> >>>>>> MFP_LPM_KEEP_OUTPUT into line
> >>>>>>> with MFP_LPM_DRIVE_HIGH and
> >> MFP_LPM_DRIVE_LOW.
> >>>>>>>
> >>>>>>> Signed-off-by: Paul Parsons
> <lost.distance@yahoo.com>
> >>>>>>> ---
> >>>>>>>
> >>>>>>> diff --git
> >> a/arch/arm/mach-pxa/mfp-pxa2xx.c
> >>>>>> b/arch/arm/mach-pxa/mfp-pxa2xx.c
> >>>>>>> index b0a8428..3b443199 100644
> >>>>>>> ---
> a/arch/arm/mach-pxa/mfp-pxa2xx.c
> >>>>>>> +++
> b/arch/arm/mach-pxa/mfp-pxa2xx.c
> >>>>>>> @@ -96,6 +96,9 @@ static int
> >>>> __mfp_config_gpio(unsigned
> >>>>>> gpio, unsigned long c)
> >>>>>>>? ? ?
> ???
> >>>>? ???break;
> >>>>>>>? ? ?
> ???}
> >>>>>>>? ???
> >>>>>>> +? ? if (c &
> >>>> MFP_LPM_KEEP_OUTPUT)
> >>>>>>> +? ? ? ?
> is_out =
> >> 1;
> >>>>>>> +
> >>>>>>
> >>>>>> MFP_LPM_KEEP_OUTPUT does not meant
> to be
> >> used to
> >>>> setup the
> >>>>>> mfp config,
> >>>>>
> >>>>> As far as I can see,
> MFP_LPM_KEEP_OUTPUT is
> >> *only* used
> >>>> to setup the
> >>>>> mfp config:
> >>>>>
> >>>>> % xzcat linux-3.4-rc1.tar.xz | fgrep
> -a
> >>>> MFP_LPM_KEEP_OUTPUT
> >>>>>? ? ? GPIO13_GPIO |
> >>>> MFP_LPM_KEEP_OUTPUT,? ? /*
> >>>> CORGI_GPIO_LED_ORANGE */
> >>>>>? ? ? GPIO38_GPIO |
> >>>> MFP_LPM_KEEP_OUTPUT,? ? /*
> >> CORGI_GPIO_CHRG_ON
> >>>> */
> >>>>>? ? ? GPIO43_GPIO |
> >>>> MFP_LPM_KEEP_OUTPUT,? ? /*
> >>>> CORGI_GPIO_CHRG_UKN */
> >>>>> #define MFP_LPM_KEEP_OUTPUT?
> ? (0x1
> >>>> << 25)
> >>>>>? ? ? /* set
> corresponding
> >> PGSR bit of
> >>>> those marked MFP_LPM_KEEP_OUTPUT */
> >>>>>? ? ? ? ? if
> >>>> ((gpio_desc[i].config &
> MFP_LPM_KEEP_OUTPUT)
> >> &&
> >>>>> % 
> >>>>
> >>>> How can you be certain that you don't break
> corgi,
> >> with the
> >>>> proposed patch?
> >>>
> >>> On corgi, the three GPIOs configured as
> >> MFP_LPM_KEEP_OUTPUT:
> >>>? ? ? CORGI_GPIO_LED_ORANGE
> >>>? ? ? CORGI_GPIO_CHRG_ON
> >>>? ? ? CORGI_GPIO_CHRG_UKN
> >>> are all used as outputs.
> >>
> >> Have you verified it, because currently
> MFP_LPM_KEEP_OUTPUT
> >> does not do a direction configuration... and IMO,
> it should
> >> not!
> > 
> > Yes, all 3 GPIOs are configured as outputs:
> > CORGI_GPIO_LED_ORANGE in drivers/leds/leds-gpio.c
> > CORGI_GPIO_CHRG_ON in arch/arm/mach-pxa/corgi_pm.c
> > CORGI_GPIO_CHRG_UKN in arch/arm/mach-pxa/corgi_pm.c
> 
> Good, then they will be kept output also in the suspend
> mode,
> as for current implementation.
> 
> > 
> >>
> >>>
> >>>>>> but for pins that have been
> configured for
> >> output
> >>>> by
> >>>>>> gpio_direction_out().
> >>>>>> (Hint: *_KEEP_*).
> >>>>>
> >>>>> MFP_LPM_KEEP_OUTPUT only takes effect
> when the
> >> system
> >>>> enters sleep mode,
> >>>>> at which point the GPIO directions
> (GPDR
> >> registers) are
> >>>> forced from the
> >>>>> values privately stored in gpdr_lpm[].
> >>>>
> >>>> Correct, but with your patch, the direction
> will be
> >> forced
> >>>> to output,
> >>>> but the value will be undefined...
> >>>
> >>> The values will be defined in
> pxa2xx_mfp_suspend() when
> >> it sets the PGSR
> >>> registers. Or at least they will be on corgi
> and
> >> hx4700, but see below...
> >>
> >> No, they will not, because the direction can be
> input...
> >>
> >>>
> >>>>> As far as I can tell
> MFP_LPM_KEEP_OUTPUT has no
> >> direct
> >>>> connection to
> >>>>> gpio_direction_output().
> >>>>
> >>>> Well, it has... in the
> pxa2xx_mfp_suspend()
> >> function you've
> >>>> pasted below.
> >>>>
> >>>>>
> >>>>>> Also, I don't think this is a good
> idea,
> >> because
> >>>> the patch
> >>>>>> allows a pin
> >>>>>> be configured as output, but does
> not
> >> forces a
> >>>> value
> >>>>>> (high/low)
> >>>>>> and this is not safe.
> >>>>>
> >>>>> A value does not need to be provided
> until the
> >> system
> >>>> enters sleep mode,
> >>>>> at which point the value is provided
> via the
> >> PGSR
> >>>> registers.
> >>>>
> >>>> Yes, but you don't force the PGSR to be
> set...
> >>>> and that is the problem.
> >>>
> >>> OK, see below...
> >>>
> >>>>>? ? ? 353? ?
> static
> >> int
> >>>> pxa2xx_mfp_suspend(void)
> >>>>>? ? ? 354? ? {
> >>>>>? ? ?
> 355???
> >>? ? 
> >>>> int i;
> >>>>>? ? ? 356? ? 
> >>>>>? ? ?
> 357???
> >>? ? 
> >>>> /* set corresponding PGSR bit of those
> marked
> >>>> MFP_LPM_KEEP_OUTPUT */
> >>>>>? ? ?
> 358???
> >>? ? 
> >>>> for (i = 0; i < pxa_last_gpio; i++) {
> >>>>>? ? ?
> 359???
> >>? ? 
> >>>>? ? ? if
> ((gpio_desc[i].config
> >> &
> >>>> MFP_LPM_KEEP_OUTPUT) &&
> >>>>>? ? ?
> 360???
> >>? ? 
> >>>>? ? ? ? ? (GPDR(i)
> >> &
> >>>> GPIO_bit(i))) {
> >>>>
> >>>> Look at the check above...
> >>>> the PGSR only gets set for the GPIOs
> configured to
> >> output
> >>>> (presumably by gpio_direction_output()
> function).
> >>>
> >>> OK, I understand your objection here.
> >>>
> >>> My feeling is that the (GPDR(i) &
> GPIO_bit(i)) test
> >> is unwanted because
> >>> the current state of GPDR (via
> gpio_direction_output())
> >> does not apply in
> >>> sleep mode,
> >>
> >> It gets copied to PGSR in the pxa2xx_mfp_suspend()
> and
> >> therefore it does apply!
> >> That is exactly the meaning of
> MFP_LPM_KEEP_OUTPUT:
> >> _If_ the pin is output, then _keep_ it output with
> the
> >> _runtime_ value.
> > 
> > OK, I see, your interpretation is that
> MFP_LPM_KEEP_OUTPUT is optional:
> > it should not apply if the pin is an input at the time
> > pxa2xx_mfp_suspend() is called.
> > My interpretation was that MFP_LPM_KEEP_OUTPUT is
> mandatory: it always
> > applies regardless of the current pin direction,
> exactly like
> > MFP_LPM_DRIVE_HIGH and MFP_LPM_DRIVE_LOW.
> > 
> > If your interpretation is correct then DRIVE_HIGH and
> DRIVE_LOW will
> > likewise need to check the state of GPDR at the time
> > pxa2xx_mfp_suspend() is called.
> > If my interpretation is correct then having KEEP_OUTPUT
> ignore the state
> > of GPDR in pxa2xx_mfp_suspend() is the correct thing to
> do.
> > 
> > Do you agree that KEEP_OUTPUT, DRIVE_HIGH and DRIVE_LOW
> should all be
> > consistent in being either optional or mandatory sleep
> mode
> > configurations?
> 
> No, according to current implementation (and IMO, it is
> _not_ a bug):
> DRIVE_HIGH and DRIVE_LOW are mandatory,
> KEEP_OUTPUT is optional.
> 
> > 
> >>
> >>> yet for some reason it is being allowed to
> prevent the
> >>> setting of PGSR in the case of GPIO inputs.
> >>
> >> Because, the PGSR is valid only for GPIO outputs!
> >> and has nothing to do with inputs.
> > 
> > I know, it makes no sense to specify KEEP_OUTPUT,
> DRIVE_HIGH or DRIVE_LOW
> > for GPIO inputs.
> 
> That's the point, that it does make sense for certain
> cases,
> when you want the GPIO to be bidirectional, but output in
> suspend.
> This allows certain flexibility.
> 
> > But since DRIVE_HIGH or DRIVE_LOW currently don't
> prevent that,
> 
> Don't prevent what?

Don't prevent a GPIO input being changed to an output when entering
suspend().

By the way, there is still the issue of DRIVE_HIGH and DRIVE_LOW
forcing the GPIO direction to output in pxa2xx_mfp_suspend()
*before* the PGSR values take effect. Surely a bug?

> DRIVE_HIGH and DRIVE_LOW allow you to do
> what
> ever you want with the GPIO in runtime, but have it strictly
> configured
> for the suspend.
> 
> > the
> > presumption must be that GPIOs configured as DRIVE_HIGH
> or DRIVE_LOW are
> > being used as outputs. Likewise for KEEP_OUTPUT?
> 
> KEEP_OUTPUT only affects the GPIOs configured for output in
> runtime
> and let you keep the last output value.
> 
> > 
> >>
> >>>
> >>> Consequently the (GPDR(i) & GPIO_bit(i))
> test
> >> should be removed.
> >>
> >> No, absolutely not!
> >> This will change the meaning of the
> MFP_LPM_KEEP_OUTPUT
> >> symbol!
> > 
> > Only if you interpret KEEP_OUTPUT as an optional sleep
> mode configuration.
> 
> That what the current implementation does and IMO, it is the
> right thing.
> 
> > 
> >> I have a feeling that you are trying to solve a
> problem that
> >> does not exist!
> > 
> > The problem is that MFP configurations of the form:
> >? ???GPIO<n>_GPIO |
> MFP_LPM_KEEP_OUTPUT,
> > will always set the sleep mode gpio direction to
> INPUT.
> > That is the case with corgi and would also be the case
> with hx4700.
> > That is the problem which needs to be solved.
> 
> Yes, it is just there is no h/w MFP in PXA2xx and all the
> stuff done in s/w.
> That is the reason it is a bit mess.

It's more than a mess: it's broken, per the current corgi configuration.

> IMO, the cleanest solution would be to have
> GPIO<n>_GPIO_OUT for each
> GPIO that needs to be configured as output instead of
> breaking the
> already fragile MFP logic.

And similarly fix the corgi configuration.

> 
> > 
> >>
> >>>
> >>>>>? ? ?
> 361???
> >>? ? 
> >>>>? ? ? ? ? if
> (GPLR(i)
> >> &
> >>>> GPIO_bit(i))
> >>>>>? ? ?
> 362???
> >>? ? 
> >>>>? ? ? ? ?
> ???
> >>>> PGSR(gpio_to_bank(i)) |= GPIO_bit(i);
> >>>>>? ? ?
> 363???
> >>? ? 
> >>>>? ? ? ? ? else
> >>>>>? ? ?
> 364???
> >>? ? 
> >>>>? ? ? ? ?
> ???
> >>>> PGSR(gpio_to_bank(i)) &= ~GPIO_bit(i);
> >>>>>? ? ?
> 365???
> >>? ? 
> >>>>? ? ? }
> >>>>>? ? ?
> 366???
> >>? ? 
> >>>> }
> >>>>>? ? ? 367? ? 
> >>>>>? ? ?
> 368???
> >>? ? 
> >>>> for (i = 0; i <=
> gpio_to_bank(pxa_last_gpio);
> >> i++) {
> >>>>>? ? ? 369? ? 
> >>>>>? ? ? ?
> ???...
> >>>>>? ? ?
> 375???
> >>? ? 
> >>>>? ? ? GPDR(i * 32) =
> >> gpdr_lpm[i];
> >>>>>? ? ?
> 376???
> >>? ? 
> >>>> }
> >>>>>? ? ?
> 377???
> >>? ? 
> >>>> return 0;
> >>>>>? ? ? 378? ? }
> >>>>>
> >>>>> However looking at pxa2xx_mfp_suspend()
> more
> >> closely it
> >>>> is true that the
> >>>>> GPDR registers are set before the PGSR
> values
> >> take
> >>>> effect (when the
> >>>>> processor enters sleep mode).
> >>>>> That is no different from
> MFP_LPM_DRIVE_HIGH
> >> or
> >>>> MFP_LPM_DRIVE_LOW though.
> >>>>
> >>>> Well, it is different, because the in case
> of
> >>>> MFP_LPM_DRIVE_*,
> >>>> the PGSR is set in the __mfp_config_gpio()
> function
> >> and has
> >>>> a _known value_.
> >>>
> >>> KEEP_OUTPUT does the same where GPIOs are
> configured as
> >> outputs, as is
> >>> the case with corgi and hx4700.
> >>> Your valid objection is for cases where GPIOs
> are
> >> configured as inputs.
> >>> So I presume that removing the (GPDR(i) &
> >> GPIO_bit(i)) test will satisfy
> >>> your objection.
> >>
> >> again, no, because it will change the meaning of
> the
> >> MFP_LPM_KEEP_OUTPUT symbol!
> >>
> >>>
> >>>>> So the presumption must be that the
> GPIOs
> >> configured as
> >>>> DRIVE_HIGH,
> >>>>> DRIVER_LOW and now KEEP_OUTPUT already
> have a
> >> valid
> >>>> direction and value
> >>>>> set at the point the GPDR registers
> are
> >> forced.
> >>>>
> >>>> Yes. That is exactly my point here.
> >>>> MFP_LPM_DRIVE_* has the value determined
> and set.
> >>>> MFP_LPM_KEEP_OUTPUT does not, but with your
> patch
> >> it will
> >>>> effectively
> >>>> force the GPIO to be output in sleep mode,
> but with
> >> no value
> >>>> set!
> >>>
> >>> Only in cases where the GPIO is used as an
> input in
> >> normal mode but
> >>> configured to be an output in sleep mode.
> >>> Removing the (GPDR(i) & GPIO_bit(i)) test
> addresses
> >> that case.
> >>
> >> No, because, if the GPIO is input, you will
> configure it for
> >> output
> >> and set some arbitrary value that is seen on the
> input!
> >> This is bad!
> >>
> >>>
> >>>>>> Why can't you use:
> >>>>>> GPIO<n>_GPIO |
> >> MFP_LPM_DRIVE_<level>
> >>>>>> ?
> >>>>>
> >>>>> The hx4700 has a couple of charging
> GPIOs which
> >> we want
> >>>> to keep HIGH or
> >>>>> LOW during sleep mode:
> >>>>>
> >>>>> % fgrep MFP_LPM_KEEP_OUTPUT
> >> arch/arm/mach-pxa/hx4700.c
> >>>>>? ? ? GPIO72_GPIO |
> >>>> MFP_LPM_KEEP_OUTPUT,? ? /*
> >> BQ24022_nCHARGE_EN
> >>>> */
> >>>>>? ? ? GPIO96_GPIO |
> >>>> MFP_LPM_KEEP_OUTPUT,? ? /*
> BQ24022_ISET2
> >> */
> >>>>> % 
> >>>>
> >>>> I still, can't understand, why
> MFP_LPM_DRIVE_* does
> >> not do
> >>>> the job for you...
> >>>> What's the real problem with using
> >> MFP_LPM_DRIVE_*?
> >>>> Can't you specify it for those GPIO72/96?
> >>>
> >>> The feeling was that if the unit was charging
> in normal
> >> mode then it
> >>> should remain charging in sleep mode, and if it
> wasn't
> >> then it should
> >>> remain not charging.
> >>
> >> Ok, finally we are talking about a real problem...
> >> I see...
> >> IMO, the best solution will be to add a generic
> >> GPIOx_GPIO_OUT
> >> (as already proposed by Haojian) definition (where
> x is the
> >> required GPIO number)for your used GPIOs and use it
> in MFP
> >> config
> >> structure for hx4700 along with
> MFP_LPM_KEEP_OUTPUT.
> >>
> >>
> >> Another solution would be (though a bit hackish):
> >> GPIOx_GPIO | MFP_LPM_DRIVE_LOW |
> MFP_LPM_KEEP_OUTPUT
> >>
> >> The above should work for you as you would expect -
> will set
> >> the GPIO
> >> to be output low by default, then you will
> reconfigure it to
> >> the
> >> appropriate level from your charger driver and the
> new level
> >> will be used
> >> by the existing logic in pxa2xx_mfp_suspend().
> > 
> > Those solutions are fair enough.
> > Can we first answer the question of whether
> KEEP_OUTPUT, DRIVE_HIGH and
> > DRIVE_LOW are optional or mandatory sleep mode
> configurations. That may
> > determine the way forward.
> 
> Well for the DRIVE_HIGH and DRIVE_LOW, the names speak for
> them selfs -
> MultiFunctionalPin_LowPowerManager_DRIVE_<HIGH|LOW>
> and there is no
> questions arise.
> For the MFP_LPM_KEEP_OUTPUT - is PXA2xx specific, apparently
> it is
> confusing and probably has to have a comment explaining the
> meaning.
> 
> From git log:
> ---------------cut---------------------
> commit 1106143d7ab43ba07678c88c85417df219354ae8
> Author: Eric Miao <eric.y.miao@gmail.com>
> Date:???Mon Jan 11 21:25:15 2010 +0800
> 
> ? ? [ARM] pxa: add MFP_LPM_KEEP_OUTPUT flag to pin
> config
> ? ? 
> ? ? Some pins are expected to keep their last
> level during suspend, and
> ? ? introduce MFP_LPM_KEEP_OUTPUT for this.
> ? ? 
> ? ? Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
> ---------------cut---------------------
> 
> The key words above are: "keep their last level".

Which is exactly what would have happened with my patch, since all
cases of KEEP_OUTPUT were indeed being applied to outputs only.

> 
> > 
> >>
> >>> Actually that's an interim solution until the
> >> bootloader can take control
> >>> of sleep mode charging, but we're not there
> yet.
> >>
> >> still you don't want the turn on/off of the charger
> in the
> >> suspend sequence,
> >> so IMO, it must also be fixed in Linux.
> >> But, please, don't change the meaning of
> >> MFP_LPM_KEEP_OUTPUT!
> >> Because, currently it is safe to use it also with
> inputs
> >> and we don't want to break this assumption.

Regards,
Paul
