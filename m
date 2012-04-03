From: lost.distance@yahoo.com (Paul Parsons)
Date: Tue, 3 Apr 2012 13:30:58 +0100 (BST)
Subject: [PATCH] ARM: pxa: mfp: Force gpio direction for
 MFP_LPM_KEEP_OUTPUT
In-Reply-To: <4F7AAE48.4030909@compulab.co.il>
Message-ID: <1333456258.38206.YahooMailClassic@web29003.mail.ird.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Igor,

--- On Tue, 3/4/12, Igor Grinberg <grinberg@compulab.co.il> wrote:
> On 04/02/12 16:33, Paul Parsons
> wrote:
> > Hello Igor,
> > 
> 
> [...] Remove the unreadable stuff...
> 
> >>>>> On corgi, the three GPIOs configured
> as
> >>>> MFP_LPM_KEEP_OUTPUT:
> >>>>>? ?
> ???CORGI_GPIO_LED_ORANGE
> >>>>>? ?
> ???CORGI_GPIO_CHRG_ON
> >>>>>? ?
> ???CORGI_GPIO_CHRG_UKN
> >>>>> are all used as outputs.
> >>>>
> >>>> Have you verified it, because currently
> >> MFP_LPM_KEEP_OUTPUT
> >>>> does not do a direction configuration...
> and IMO,
> >> it should
> >>>> not!
> >>>
> >>> Yes, all 3 GPIOs are configured as outputs:
> >>> CORGI_GPIO_LED_ORANGE in
> drivers/leds/leds-gpio.c
> >>> CORGI_GPIO_CHRG_ON in
> arch/arm/mach-pxa/corgi_pm.c
> >>> CORGI_GPIO_CHRG_UKN in
> arch/arm/mach-pxa/corgi_pm.c
> >>
> >> Good, then they will be kept output also in the
> suspend
> >> mode,
> >> as for current implementation.
> 
> Now I can see that it will not... because of the below
> line:
> GPDR(i * 32) = gpdr_lpm[i];
> 
> in the pxa2xx_mfp_suspend() function.#

Which is precisely the issue this patch addresses, namely to force
the gpdr_lpm[] direction to output for KEEP_OUTPUT configurations.

> 
> [...] remove unreadable stuff...
> 
> >>>
> >>> Do you agree that KEEP_OUTPUT, DRIVE_HIGH and
> DRIVE_LOW
> >> should all be
> >>> consistent in being either optional or
> mandatory sleep
> >> mode
> >>> configurations?
> >>
> >> No, according to current implementation (and IMO,
> it is
> >> _not_ a bug):
> >> DRIVE_HIGH and DRIVE_LOW are mandatory,
> >> KEEP_OUTPUT is optional.
> >>
> >>>
> >>>>
> >>>>> yet for some reason it is being allowed
> to
> >> prevent the
> >>>>> setting of PGSR in the case of GPIO
> inputs.
> >>>>
> >>>> Because, the PGSR is valid only for GPIO
> outputs!
> >>>> and has nothing to do with inputs.
> >>>
> >>> I know, it makes no sense to specify
> KEEP_OUTPUT,
> >> DRIVE_HIGH or DRIVE_LOW
> >>> for GPIO inputs.
> >>
> >> That's the point, that it does make sense for
> certain
> >> cases,
> >> when you want the GPIO to be bidirectional, but
> output in
> >> suspend.
> >> This allows certain flexibility.
> >>
> >>> But since DRIVE_HIGH or DRIVE_LOW currently
> don't
> >> prevent that,
> >>
> >> Don't prevent what?
> > 
> > Don't prevent a GPIO input being changed to an output
> when entering
> > suspend().
> 
> Why should they prevent that? In case of bidirectional GPIOs
> it is
> perfectly fine.

I didn't say they should prevent that. I said they don't prevent
that, thereby allowing the direction of an input gpio to be changed
to output before the PGSR value is applied.

> 
> > 
> > By the way, there is still the issue of DRIVE_HIGH and
> DRIVE_LOW
> > forcing the GPIO direction to output in
> pxa2xx_mfp_suspend()
> > *before* the PGSR values take effect. Surely a bug?
> 
> No, the order is not important as the final setting is done
> by the h/w
> during the suspend transition.

No, the GPIO direction is changed by software, not hardware.
Hardware suspend does not change the GPIO direction, it only
drives the GPIO values from the PGSR registers.

Thus there is a definite window between the direction being changed
by software and the PGSR value being driven by hardware.

Within that window, the output values are indeterminate, at least
as far as the suspend software is concerned.

So unless valid output values have already been programmed onto
those input GPIOs beforehand, this direction/PGSR window is a bug.

> 
> > 
> >> DRIVE_HIGH and DRIVE_LOW allow you to do
> >> what
> >> ever you want with the GPIO in runtime, but have it
> strictly
> >> configured
> >> for the suspend.
> >>
> >>> the
> >>> presumption must be that GPIOs configured as
> DRIVE_HIGH
> >> or DRIVE_LOW are
> >>> being used as outputs. Likewise for
> KEEP_OUTPUT?
> >>
> >> KEEP_OUTPUT only affects the GPIOs configured for
> output in
> >> runtime
> >> and let you keep the last output value.
> >>
> >>>
> >>>>
> >>>>>
> >>>>> Consequently the (GPDR(i) &
> GPIO_bit(i))
> >> test
> >>>> should be removed.
> >>>>
> >>>> No, absolutely not!
> >>>> This will change the meaning of the
> >> MFP_LPM_KEEP_OUTPUT
> >>>> symbol!
> >>>
> >>> Only if you interpret KEEP_OUTPUT as an
> optional sleep
> >> mode configuration.
> >>
> >> That what the current implementation does and IMO,
> it is the
> >> right thing.
> >>
> >>>
> >>>> I have a feeling that you are trying to
> solve a
> >> problem that
> >>>> does not exist!
> >>>
> >>> The problem is that MFP configurations of the
> form:
> >>>? ? ? GPIO<n>_GPIO |
> >> MFP_LPM_KEEP_OUTPUT,
> >>> will always set the sleep mode gpio direction
> to
> >> INPUT.
> >>> That is the case with corgi and would also be
> the case
> >> with hx4700.
> >>> That is the problem which needs to be solved.
> >>
> >> Yes, it is just there is no h/w MFP in PXA2xx and
> all the
> >> stuff done in s/w.
> >> That is the reason it is a bit mess.
> > 
> > It's more than a mess: it's broken, per the current
> corgi configuration.
> 
> Ok. Indeed it looks broken even with my meaning of
> KEEP_OUTPUT,
> because of the line that sets all GPDRs to gpdr_lpm values
> in
> pxa2xx_mfp_suspend() function.
> 
> > 
> >> IMO, the cleanest solution would be to have
> >> GPIO<n>_GPIO_OUT for each
> >> GPIO that needs to be configured as output instead
> of
> >> breaking the
> >> already fragile MFP logic.
> > 
> > And similarly fix the corgi configuration.
> 
> Please, check the attached patch.
> It should not change the meaning of KEEP_OUTPUT, but fix the
> bug.

Yes, that fixes the KEEP_OUTPUT bug.

It would be beneficial if someone could formally document the precise
meaning of KEEP_OUTPUT.

The direction/PGSR window bug is still present though.

I'm starting to think it would be better for pxa2xx_mfp_suspend()
to not touch GPDR at all, ever. Thus outputs would remain outputs,
inputs would remain inputs. That would solve the latter bug and
simplify PXA2xx MFP, but at the cost of making DRIVE_HIGH/DRIVE_LOW
conditional like KEEP_OUTPUT.

It would be beneficial if someone could formally document the precise
meaning of DRIVE_HIGH/DRIVE_LOW.

> 
> [...] remove unreadable stuff...
> 
> >>>>> The feeling was that if the unit was
> charging
> >> in normal
> >>>> mode then it
> >>>>> should remain charging in sleep mode,
> and if it
> >> wasn't
> >>>> then it should
> >>>>> remain not charging.
> >>>>
> >>>> Ok, finally we are talking about a real
> problem...
> >>>> I see...
> >>>> IMO, the best solution will be to add a
> generic
> >>>> GPIOx_GPIO_OUT
> >>>> (as already proposed by Haojian) definition
> (where
> >> x is the
> >>>> required GPIO number)for your used GPIOs
> and use it
> >> in MFP
> >>>> config
> >>>> structure for hx4700 along with
> >> MFP_LPM_KEEP_OUTPUT.
> >>>>
> >>>>
> >>>> Another solution would be (though a bit
> hackish):
> >>>> GPIOx_GPIO | MFP_LPM_DRIVE_LOW |
> >> MFP_LPM_KEEP_OUTPUT
> >>>>
> >>>> The above should work for you as you would
> expect -
> >> will set
> >>>> the GPIO
> >>>> to be output low by default, then you will
> >> reconfigure it to
> >>>> the
> >>>> appropriate level from your charger driver
> and the
> >> new level
> >>>> will be used
> >>>> by the existing logic in
> pxa2xx_mfp_suspend().
> >>>
> >>> Those solutions are fair enough.
> >>> Can we first answer the question of whether
> >> KEEP_OUTPUT, DRIVE_HIGH and
> >>> DRIVE_LOW are optional or mandatory sleep mode
> >> configurations. That may
> >>> determine the way forward.
> >>
> >> Well for the DRIVE_HIGH and DRIVE_LOW, the names
> speak for
> >> them selfs -
> >>
> MultiFunctionalPin_LowPowerManager_DRIVE_<HIGH|LOW>
> >> and there is no
> >> questions arise.
> >> For the MFP_LPM_KEEP_OUTPUT - is PXA2xx specific,
> apparently
> >> it is
> >> confusing and probably has to have a comment
> explaining the
> >> meaning.
> >>
> >> From git log:
> >> ---------------cut---------------------
> >> commit 1106143d7ab43ba07678c88c85417df219354ae8
> >> Author: Eric Miao <eric.y.miao@gmail.com>
> >> Date:???Mon Jan 11 21:25:15 2010
> +0800
> >>
> >>? ???[ARM] pxa: add
> MFP_LPM_KEEP_OUTPUT flag to pin
> >> config
> >>? ???
> >>? ???Some pins are expected to
> keep their last
> >> level during suspend, and
> >>? ???introduce
> MFP_LPM_KEEP_OUTPUT for this.
> >>? ???
> >>? ???Signed-off-by: Eric Miao
> <eric.y.miao@gmail.com>
> >> ---------------cut---------------------
> >>
> >> The key words above are: "keep their last level".
> > 
> > Which is exactly what would have happened with my
> patch, since all
> > cases of KEEP_OUTPUT were indeed being applied to
> outputs only.
> 
> No, your patch will change also the inputs to outputs.
> Because "last level" does not apply to input pins.

My point was that KEEP_OUTPUT configurations are only applied to
GPIOs used as outputs. So no directions would be changed in practice.

Regards,
Paul
