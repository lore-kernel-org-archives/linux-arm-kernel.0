From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Mon, 23 Jul 2012 11:22:04 +0200
Subject: [PATCH 1/2] PWM: ECAP: PWM driver support for ECAP APWM.
In-Reply-To: <518397C60809E147AF5323E0420B992E3E971530@DBDE01.ent.ti.com>
References: <1342172102-30363-1-git-send-email-avinashphilip@ti.com>
 <1342172102-30363-2-git-send-email-avinashphilip@ti.com>
 <20120723065235.GA23797@avionic-0098.mockup.avionic-design.de>
 <518397C60809E147AF5323E0420B992E3E971530@DBDE01.ent.ti.com>
Message-ID: <20120723092204.GA8607@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 23, 2012 at 09:10:09AM +0000, Philip, Avinash wrote:
> On Mon, Jul 23, 2012 at 12:22:35, Thierry Reding wrote:
> > On Fri, Jul 13, 2012 at 03:05:01PM +0530, Philip, Avinash wrote:
> > > +	/*
> > > +	 * Enable 'Free run Time stamp counter mode' to start counter
> > > +	 * and  'APWM mode' to enable APWM output
> > > +	 */
> > > +	reg_val = readw(pc->mmio_base + ECCTL2);
> > > +	reg_val |= ECCTL2_TSCTR_FREERUN | ECCTL2_APWM_MODE;
> > 
> > You already set the APWM_MODE bit in .config(), why is it needed here
> > again? Seeing that .disable() clears the bit as well, perhaps leaving it
> > clear in .config() is the better option.
> 
> Clearing APWM mode in .disable() ensures PWM low output (i.e., PWM pin = low 
> in idle state).
> 
> The Period & Compare registers are updated from Shadow registers (CAP1 & CAP2)
> During PWM configuration. To enable loading from Shadow registers, APWM mode 
> should be set.
> The same is done in .config().

My point was that if you do it in .enable(), then why do you still set
it in .config()? Since the sequence is typically .config() followed by
.enable(), setting the bit in both seems redundant. It should be enough
to load the registers during .enable(), right?

> > > +	pc->chip.dev = &pdev->dev;
> > > +	pc->chip.ops = &ecap_pwm_ops;
> > > +	pc->chip.base = -1;
> > > +	pc->chip.npwm = 1;
> > 
> > The cover letter mentions that the AM335x has 3 instances of the ECAP.
> > Is there any chance that they can be unified in one driver instance
> > (i.e. .npwm = 3?).
> 
> No. All instances have separate resources (clocks, memory ..).
> 
> > 
> > > +
> > > +	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ecap_reg");
> > > +	if (r == NULL) {
> > 
> > You use "if (!ptr)" everywhere else, maybe you should make this
> > consistent?
> Ok
> > Also the platform_get_resource_byname() is really only
> > useful for devices that have several register regions associated with
> > them. I don't know your hardware in detail, but I doubt that a PWM
> > device has more than one register region.
> 
> In fact PWM Module has 4 different register space (eCAP, eHRPWM, eQEP & 
> Common Config space). So I need to use platform_get_resource_byname()

Above you say that all instances have separate resources, so how come
you need to specify 4 register spaces? The eCAP registers should clearly
be passed to the eCAP device, while the eHRPWM registers should go to
the eHRPWM device.

My point is that if you need to refer to the register region by name,
then the driver should clearly be using more than a single region.
Neither the eCAP nor eHRPWM do that.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120723/768d1fc6/attachment.sig>
