From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Mon, 23 Jul 2012 15:37:04 +0200
Subject: [PATCH 1/2] PWM: ECAP: PWM driver support for ECAP APWM.
In-Reply-To: <518397C60809E147AF5323E0420B992E3E971887@DBDE01.ent.ti.com>
References: <1342172102-30363-1-git-send-email-avinashphilip@ti.com>
 <1342172102-30363-2-git-send-email-avinashphilip@ti.com>
 <20120723065235.GA23797@avionic-0098.mockup.avionic-design.de>
 <518397C60809E147AF5323E0420B992E3E971530@DBDE01.ent.ti.com>
 <20120723092204.GA8607@avionic-0098.mockup.avionic-design.de>
 <518397C60809E147AF5323E0420B992E3E971887@DBDE01.ent.ti.com>
Message-ID: <20120723133704.GB21254@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 23, 2012 at 12:44:38PM +0000, Philip, Avinash wrote:
> On Mon, Jul 23, 2012 at 14:52:04, Thierry Reding wrote:
> > On Mon, Jul 23, 2012 at 09:10:09AM +0000, Philip, Avinash wrote:
> > > On Mon, Jul 23, 2012 at 12:22:35, Thierry Reding wrote:
> > > > On Fri, Jul 13, 2012 at 03:05:01PM +0530, Philip, Avinash wrote:
> > > > > +	/*
> > > > > +	 * Enable 'Free run Time stamp counter mode' to start counter
> > > > > +	 * and  'APWM mode' to enable APWM output
> > > > > +	 */
> > > > > +	reg_val = readw(pc->mmio_base + ECCTL2);
> > > > > +	reg_val |= ECCTL2_TSCTR_FREERUN | ECCTL2_APWM_MODE;
> > > > 
> > > > You already set the APWM_MODE bit in .config(), why is it needed here
> > > > again? Seeing that .disable() clears the bit as well, perhaps leaving it
> > > > clear in .config() is the better option.
> > > 
> > > Clearing APWM mode in .disable() ensures PWM low output (i.e., PWM pin = low 
> > > in idle state).
> > > 
> > > The Period & Compare registers are updated from Shadow registers (CAP1 & CAP2)
> > > During PWM configuration. To enable loading from Shadow registers, APWM mode 
> > > should be set.
> > > The same is done in .config().
> > 
> > My point was that if you do it in .enable(), then why do you still set
> > it in .config()? Since the sequence is typically .config() followed by
> > .enable(), setting the bit in both seems redundant. It should be enough
> > to load the registers during .enable(), right?
> 
> Consider scenarios where .enable() can be called without calling .config().
> Example I just need to stop the pwm signal momentarily and re-enable.
> In this case, .config() need not be called. So, APWM mode bit needs to be 
> set in .enable()
> 
> Now, considering .config() followed by .enable().
> Currently in PWM driver, the CAP1 & CAP2 registers is copied to shadow 
> Registers (CAP3 & CAP4) by hardwaare in .config(). This requires APWM
> mode bit to be set. 
> 
> The same can be done in .enable() also. However, we again need to pass 
> the pwm parameters (period & duty cycle values) to the .enable(). 
> We don't want to duplicate this parameter passing. 
> To avoid this we enable the APWM mode bit in both .config() & .enable().

That's weird. I assumed that the values written to the shadow registers
would automatically be copied to the active registers on each new PWM
period. If I understand correctly what you're saying, however, the eCAP
requires the APWM bit to be set in order to write the shadow registers
at all.

> > > > > +	pc->chip.dev = &pdev->dev;
> > > > > +	pc->chip.ops = &ecap_pwm_ops;
> > > > > +	pc->chip.base = -1;
> > > > > +	pc->chip.npwm = 1;
> > > > 
> > > > The cover letter mentions that the AM335x has 3 instances of the ECAP.
> > > > Is there any chance that they can be unified in one driver instance
> > > > (i.e. .npwm = 3?).
> > > 
> > > No. All instances have separate resources (clocks, memory ..).
> > > 
> > > > 
> > > > > +
> > > > > +	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ecap_reg");
> > > > > +	if (r == NULL) {
> > > > 
> > > > You use "if (!ptr)" everywhere else, maybe you should make this
> > > > consistent?
> > > Ok
> > > > Also the platform_get_resource_byname() is really only
> > > > useful for devices that have several register regions associated with
> > > > them. I don't know your hardware in detail, but I doubt that a PWM
> > > > device has more than one register region.
> > > 
> > > In fact PWM Module has 4 different register space (eCAP, eHRPWM, eQEP & 
> > > Common Config space). So I need to use platform_get_resource_byname()
> > 
> > Above you say that all instances have separate resources, so how come
> > you need to specify 4 register spaces? The eCAP registers should clearly
> > be passed to the eCAP device, while the eHRPWM registers should go to
> > the eHRPWM device.
> > 
> > My point is that if you need to refer to the register region by name,
> > then the driver should clearly be using more than a single region.
> > Neither the eCAP nor eHRPWM do that.
> 
> On AM335x SoC, this common config space is shared by the other 3 
> modules (eCAP, eHRPWM, eQEP).
> However, on Davinci platform don't have any common config space.
> 
> So from driver reusability view, usage of platform_get_resource_byname() 
> is better choice.

I don't quite see how you would be able to reuse the driver in that
case. The driver that you posted uses only one memory region, so the
platform device that you instantiate for the driver to bind to only
gets the one region through the .resource and .num_resources fields.

How is that going to work?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120723/62e6b9c8/attachment.sig>
