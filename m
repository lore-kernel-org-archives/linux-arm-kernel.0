From: lost.distance@yahoo.com (Paul Parsons)
Date: Fri, 30 Mar 2012 22:13:16 +0100 (BST)
Subject: How to add GPIO outputs to the PXA2xx MFP configuration?
In-Reply-To: <4F75F497.50909@compulab.co.il>
Message-ID: <1333141996.98835.YahooMailClassic@web29014.mail.ird.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

--- On Fri, 30/3/12, Igor Grinberg <grinberg@compulab.co.il> wrote:
> On 03/30/12 18:52, Paul Parsons
> wrote:
> > --- On Fri, 30/3/12, Igor Grinberg <grinberg@compulab.co.il>
> wrote:
> >> On 03/30/12 18:06, Paul Parsons wrote:
> >>> --- On Fri, 30/3/12, Igor Grinberg <grinberg@compulab.co.il>
> >> wrote:
> >>>> On 03/28/12 20:12, Paul Parsons
> >>>> wrote:
> >>>>> On PXA2xx platforms, the MFP API
> (described in
> >>>> Documentation/arm/pxa/mfp.txt)
> >>>>> provides values for the following:
> >>>>>
> >>>>> 1. GPIO inputs (e.g. GPIO105_GPIO).
> >>>>> 2. Alternate function inputs (e.g.
> >> GPIO105_CIF_DD_1).
> >>>>> 3. Alternate function outputs (e.g.
> >>>> GPIO105_KP_MKOUT_2).
> >>>>>
> >>>>> It does not provide values for GPIO
> outputs
> >> (i.e. AF0
> >>>> outputs).
> >>>>>
> >>>>> One cannot use the macro used by the
> MFP API
> >> internally
> >>>> - MFP_CFG_OUT() - to
> >>>>> define new GPIO output values, since
> that macro
> >> is
> >>>> forbidden in platform code.
> >>>>>
> >>>>> Without the ability to add GPIO outputs
> to the
> >> MFP
> >>>> configuration, it is not
> >>>>> possible to drive GPIO outputs high
> during
> >> sleep mode.
> >>>>>
> >>>>> This would be useful, for example, on
> the
> >> hx4700
> >>>> platform, where driving the
> >>>>> infrared powerdown GPIO 105 high during
> sleep
> >> mode
> >>>> would save some mA.
> >>>>>
> >>>>> So my question is: what method should
> one use
> >> to add
> >>>> GPIO outputs to the MFP
> >>>>> configuration?
> >>>>>
> >>>>> One possible method, namely manually
> defining
> >> values in
> >>>> the platform code:
> >>>>>
> >>>>>? ? ? MFP_PIN_GPIO105 |
> >> MFP_AF0 |
> >>>> MFP_DIR_OUT | MFP_LPM_DRIVE_HIGH,
> >>>>
> >>>> Have you tried:
> >>>> GPIO105_GPIO | MFP_LPM_DRIVE_HIGH,
> >>>> ?
> >>>>
> >>>> This way it works on other boards.
> >>>
> >>> Hello Igor,
> >>>
> >>> GPIO105_GPIO expands to a GPIO input -
> >> MFP_CFG_IN(GPIO105, AF0) -
> >>> not an output.
> >>
> >> Yeah, I know... but read in mfp-pxa2xx.h, lines
> 6-20:
> >> /*
> >>? * the following MFP_xxx bit definitions in
> mfp.h are
> >> re-used for pxa2xx:
> >>? *
> >>? *? MFP_PIN(x)
> >>? *? MFP_AFx
> >>? *? MFP_LPM_DRIVE_{LOW, HIGH}
> >>? *? MFP_LPM_EDGE_x
> >>? *
> >>? * other MFP_x bit definitions will be
> ignored
> >>? *
> >>? * and adds the below two bits specifically
> for pxa2xx:
> >>? *
> >>? * bit? ???23 -
> Input/Output (PXA2xx
> >> specific)
> >>? * bit? ???24 - Wakeup
> Enable(PXA2xx
> >> specific)
> >>? */
> >>
> >> This means, that there is no difference between:
> MFP_CFG_IN
> >> and MFP_CFG_OUT for PXA2xx.
> > 
> > The mfp-pxa2xx.c code says otherwise.
> 
> That's just great... outdated documentation...
> 
> > It uses the MFP direction bit
> > to set the GPDR registers on entering sleep mode:
> > 
> >? ? 353??? static int
> pxa2xx_mfp_suspend(void)
> >? ? 354??? {
> >? ? 355??? ???
> int i;
> >? ? ? ???...
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
> > gpdr_lpm[] is initialized at startup to the current
> GPDR values, and
> > thereafter is updated by the value of the MFP_DIR_OUT
> bit in calls to
> > __mfp_config_gpio().
> 
> static int __mfp_config_gpio(unsigned gpio, unsigned long
> c)
> {
> ??? unsigned long gafr, mask =
> GPIO_bit(gpio);
> ??? int bank = gpio_to_bank(gpio);
> ??? int uorl = !!(gpio & 0x10); /*
> GAFRx_U or GAFRx_L ? */
> ??? int shft = (gpio & 0xf) << 1;
> ??? int fn = MFP_AF(c);
> ??? int is_out = (c & MFP_DIR_OUT) ? 1 :
> 0;
> 
> [...]
> 
> ??? /* alternate function and direction at
> low power mode */
> ??? switch (c & MFP_LPM_STATE_MASK) {
> ??? case MFP_LPM_DRIVE_HIGH:
> ??? ??? PGSR(bank) |= mask;
> ??? ??? is_out = 1;
> ??? ??? break;
> ??? case MFP_LPM_DRIVE_LOW:
> ??? ??? PGSR(bank) &=
> ~mask;
> ??? ??? is_out = 1;
> ??? ??? break;
> 
> And in the lines above, it gets overridden by
> MFP_LPM_DRIVE_*,
> or am I missing something?

No, that looks to be the case: the LPM states DRIVE_HIGH and DRIVE_LOW
override the sleep mode direction. I completely missed that.

> [...]
> 
> ??? if (is_out ^
> gpio_desc[gpio].dir_inverted)
> ??? ??? gpdr_lpm[bank] |=
> mask;
> ??? else
> ??? ??? gpdr_lpm[bank] &=
> ~mask;
> 
> 
> So, I think,
> GPIO105_GPIO | MFP_LPM_DRIVE_HIGH,
> as I've proposed in my first email, should still work for
> you.

Yes it should. Thanks.

Regards,
Paul
