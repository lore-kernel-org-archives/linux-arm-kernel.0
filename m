From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Mon, 22 Oct 2012 09:11:18 +0200
Subject: [PATCH 2/3] PWM: vt8500: Update vt8500 PWM driver support
In-Reply-To: <1350888712.3592.11.camel@gitbox>
References: <1350643135-13197-1-git-send-email-linux@prisktech.co.nz>
 <1350643135-13197-2-git-send-email-linux@prisktech.co.nz>
 <20121022063423.GA17181@avionic-0098.mockup.avionic-design.de>
 <1350888712.3592.11.camel@gitbox>
Message-ID: <20121022071118.GA30026@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 22, 2012 at 07:51:52PM +1300, Tony Prisk wrote:
> Replies to your comments inline:
> 
> On Mon, 2012-10-22 at 08:34 +0200, Thierry Reding wrote:
> ...
> > > -static int __devinit pwm_probe(struct platform_device *pdev)
> > > +static const struct of_device_id vt8500_pwm_dt_ids[] = {
> > > +	{ .compatible = "via,vt8500-pwm", },
> > > +	{ /* Sentinel */ }
> > > +};
> > > +
> > > +static int __devinit vt8500_pwm_probe(struct platform_device *pdev)
> > 
> > Since you're changing this line anyway, maybe you should drop __devinit
> > (and __devexit for the .remove() callback). HOTPLUG is always enabled
> > nowadays and will go away eventually, in which case these will need to
> > be removed anyway.
> 
> Will do. I must say the inconstancy among comments is rather
> frustrating. In another patch I sent out a few days ago (completely
> unrelated to this), I told to add __devexit to a remove() function :\

This is a rather recent development, so maybe not everyone knows about
it yet. You can look at the following commit for the details:

	45f035ab9b8f45aaf1eb2213218b7e9c14af3fc2

It's been in linux-next for about 6 weeks and has also gone into
3.7-rc1.

> > >  {
> > >  	struct vt8500_chip *chip;
> > > -	struct resource *r;
> > > +	struct device_node *np = pdev->dev.of_node;
> > >  	int ret;
> > >  
> > > +	if (!np) {
> > > +		dev_err(&pdev->dev, "invalid devicetree node\n");
> > > +		return -EINVAL;
> > > +	}
> > > +
> > 
> > This effectively makes DT support mandatory. Shouldn't you be adding a
> > "depends on OF" into the Kconfig section in that case?
> This driver depends on ARCH_VT8500, which only supports DT so a
> dependency on OF seemed redundant. If you think its still necessary, let
> me know and I'll add it anyway.

Okay, in that case you don't need another dependency. I've recently seen
comments about the check for !np being unnecessary because it can't be
NULL if you depend on OF. I suppose there's some truth in it but to be
honest I haven't made up my mind about it yet.

> > >  	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
> > >  	if (chip == NULL) {
> > >  		dev_err(&pdev->dev, "failed to allocate memory\n");
> > > @@ -123,26 +144,32 @@ static int __devinit pwm_probe(struct platform_device *pdev)
> > >  	chip->chip.ops = &vt8500_pwm_ops;
> > >  	chip->chip.base = -1;
> > >  	chip->chip.npwm = VT8500_NR_PWMS;
> > > +	chip->clk = of_clk_get(np, 0);
> > 
> > I thought this was supposed to work transparently across OF and !OF
> > configurations by using just clk_get() or devm_clk_get()? I guess that
> > if the driver depends on OF, then this would be moot, but we should
> > probably stick to the standard usage anyway.
> > 
> > Furthermore, of_clk_get() doesn't seem to be managed, so you'd need to
> > add explicit clk_put() in the error cleanup paths. One more argument in
> > favour of using devm_clk_get() instead.
> 
> Hmm good point. I stuck with of_ functions because its an OF only driver
> and it seemed 'backward' to mix old code with new. It does pose the
> question of 'why have of_clk_get() if existing functions work better'.

I think wherever possible you should use the generic calls, since they
are (usually) explicitly designed to work with OF and non-OF and you
never know what your driver might end up being used for. Then again, if
the driver is VT8500 specific and VT8500 doesn't support anything but
device-tree I suppose using the of_*() functions would be okay. Maybe
adding devm_of_clk_get() would be a worthwhile addition.

You should also consider that other people may look at your driver as a
reference and may end up using the OF-only variants even if their driver
is used in non-DT setups. I'm not sure how valid that argument is,
though, since code review is supposed to catch those mistakes.

[...]
> > > -MODULE_LICENSE("GPL");
> > > +MODULE_DESCRIPTION("VT8500 PWM Driver");
> > > +MODULE_AUTHOR("Tony Prisk <linux@prisktech.co.nz>");
> > > +MODULE_LICENSE("GPL v2");
> > 
> > IANAL, but I think you need the approval of all authors of this code
> > before changing the license. But I see that the file header actually
> > says that this code is GPL v2, so maybe this change could be considered
> > a bugfix. =)
> 
> This is something I've already discussed with Alexey in regards to all
> the existing drivers he has in mainline. Since I have taken over as
> maintainer on this platform I have corrected the licenses as patch's
> have gone through. As you pointed out, it was already GPLv2 in the
> header, this is just a 'bugfix'.

Okay, works for me.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121022/8cdd3267/attachment.sig>
