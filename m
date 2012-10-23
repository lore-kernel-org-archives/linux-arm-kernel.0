From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Tue, 23 Oct 2012 11:22:47 +0200
Subject: [PATCH 2/3] PWM: vt8500: Update vt8500 PWM driver support
In-Reply-To: <1350981706.20938.7.camel@gitbox>
References: <1350643135-13197-1-git-send-email-linux@prisktech.co.nz>
 <1350643135-13197-2-git-send-email-linux@prisktech.co.nz>
 <20121022063423.GA17181@avionic-0098.mockup.avionic-design.de>
 <1350888712.3592.11.camel@gitbox> <1350889747.3592.17.camel@gitbox>
 <20121022072448.GB30026@avionic-0098.mockup.avionic-design.de>
 <1350891382.3592.22.camel@gitbox>
 <20121022080414.GB4931@avionic-0098.mockup.avionic-design.de>
 <1350981706.20938.7.camel@gitbox>
Message-ID: <20121023092247.GA13220@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 23, 2012 at 09:41:46PM +1300, Tony Prisk wrote:
> On Mon, 2012-10-22 at 10:04 +0200, Thierry Reding wrote:
> > On Mon, Oct 22, 2012 at 08:36:22PM +1300, Tony Prisk wrote:
> > > On Mon, 2012-10-22 at 09:24 +0200, Thierry Reding wrote:
> > > > On Mon, Oct 22, 2012 at 08:09:07PM +1300, Tony Prisk wrote:
> > > > > On Mon, 2012-10-22 at 19:51 +1300, Tony Prisk wrote:
> > > > > > > 
> > > > > > > >  	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
> > > > > > > >  	if (chip == NULL) {
> > > > > > > >  		dev_err(&pdev->dev, "failed to allocate memory\n");
> > > > > > > > @@ -123,26 +144,32 @@ static int __devinit pwm_probe(struct platform_device *pdev)
> > > > > > > >  	chip->chip.ops = &vt8500_pwm_ops;
> > > > > > > >  	chip->chip.base = -1;
> > > > > > > >  	chip->chip.npwm = VT8500_NR_PWMS;
> > > > > > > > +	chip->clk = of_clk_get(np, 0);
> > > > > > > 
> > > > > > > I thought this was supposed to work transparently across OF and !OF
> > > > > > > configurations by using just clk_get() or devm_clk_get()? I guess that
> > > > > > > if the driver depends on OF, then this would be moot, but we should
> > > > > > > probably stick to the standard usage anyway.
> > > > > > > 
> > > > > > > Furthermore, of_clk_get() doesn't seem to be managed, so you'd need to
> > > > > > > add explicit clk_put() in the error cleanup paths. One more argument in
> > > > > > > favour of using devm_clk_get() instead.
> > > > > > 
> > > > > > Hmm good point. I stuck with of_ functions because its an OF only driver
> > > > > > and it seemed 'backward' to mix old code with new. It does pose the
> > > > > > question of 'why have of_clk_get() if existing functions work better'.
> > > > > 
> > > > > Was about to fix this but noticed why it wasn't like this to start
> > > > > with :)
> > > > > 
> > > > > struct clk *devm_clk_get(struct device *dev, const char *id);
> > > > > struct clk *of_clk_get(struct device_node *np, int index);
> > > > > 
> > > > > devm_clk_get requires me to 'get' the clock by name. arch-vt8500 (and I
> > > > > believe a lot of other arch's) don't enforce names for clocks defined in
> > > > > devicetree, therefore there is no way for me to know what name the clk
> > > > > has unless I include in the binding that the clock must be named 'xxx'.
> > > > 
> > > > I thought clk_get() was supposed to return the first clock specified in
> > > > DT if you pass NULL as the consumer name. I haven't tested this though.
> > > > And I haven't looked at the code.
> > > > 
> > > > > of_clk_get retrieves it by the dt-node + index, so it doesn't care as
> > > > > long as its the 1st clock listed.
> > > > 
> > > > So the usual way to do this, I believe, is:
> > > > 
> > > > 	clocks = <&clk_foo>;
> > > > 	clock-names = "foo";
> > > > 
> > > > Then use:
> > > > 
> > > > 	clk = devm_clk_get(&pdev->dev, "foo");
> > > > 
> > > > And as I said above, I was under the impression that the default would
> > > > be to use the first clock if NULL was specified instead of "foo".
> > > > 
> > > > Thierry
> > > 
> > > clock-names is an optional property (as defined in
> > > bindings/clock/clock-bindings.txt) so relying on it is .. well,
> > > unreliable.
> > > 
> > > What you say makes sense, but it means the binding document has to make
> > > an optional property into a required property simply to use an 'old'
> > > function when a new function would 'work' (granted not as well, as you
> > > pointed out) without requiring the optional property.
> > 
> > Okay, I've just checked the core clock code, and indeed if you run
> > clk_get() with con_id set to NULL, you'll eventually call of_clk_get()
> > with index == 0. That's exactly what you want, right? The only setup
> > where this won't work out is if you need to handle multiple clocks, in
> > which case I think it would make sense to make the clock-names property
> > mandatory. But for this driver that won't be necessary, since it will
> > never use a second clock, right?
> > 
> > > Your subsystem - your rules. Let me know if I've managed to sway you or
> > > not :)
> > 
> > I'd rather persuade you than force the issue. =)
> > 
> > Thierry
> 
> Further to the discussion, my preference is still for of_clk_get()
> (although I've changed the patch anyway as you saw because it makes no
> difference in this case) :)
> 
> clk_get(x, NULL) and devm_clk_get(x, NULL) both seems like 'hacks' to
> allow platforms to convert to DT without having to update all their
> drivers first. It only allows the first (default) clock, as your pointed
> out. Getting a 2nd... clock relies on an optional property in DT (which
> again, seems like it is there to support 'old' drivers) which allows you
> to request clocks by name.
> 
> of_clk_get() on the other hand seems like a properly native DT function.
> You don't need to know anything about the clock, as long as the correct
> clock is specified in the correct order as documented by the binding.
> Relying on 'pre-OF' code for a OF-only driver also seems
> counter-intuitive.

I do agree with those arguments. What I was saying is that for drivers
which aren't DT only, of_clk_get() is not an option and that maybe
others would be encouraged by the example to not use the generic APIs
even if their driver could be used in non-DT setups. But maybe I'm
worrying needlessly.

That said, maybe somebody with a broader view of things like Arnd
(Cc'ed) could share his thoughts.

> Granted of_clk_get() doesn't provide the 'garbage-collection' of
> devm_get_clk() but I think that is just an arguement to needing
> of_devm_clk_get().

That can be remedied by adding a corresponding function, so the argument
doesn't really count.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121023/cecc2bf5/attachment-0001.sig>
