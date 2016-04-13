From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 13 Apr 2016 17:16:12 +0200
Subject: [RESEND 08/11] pwm: sti: Add support for PWM Capture IRQs
In-Reply-To: <20160413100521.GP8094@x1>
References: <1456932729-9667-1-git-send-email-lee.jones@linaro.org>
 <1456932729-9667-9-git-send-email-lee.jones@linaro.org>
 <20160412103521.GD18882@ulmo.ba.sec> <20160413100521.GP8094@x1>
Message-ID: <20160413151612.GB29509@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 13, 2016 at 11:05:21AM +0100, Lee Jones wrote:
> On Tue, 12 Apr 2016, Thierry Reding wrote:
> 
> > On Wed, Mar 02, 2016 at 03:32:06PM +0000, Lee Jones wrote:
> > [...]
> > > diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
[...]
> > > +
> > > +		regmap_read(pc->regmap,
> > > +			    PWM_CPT_VAL(channel), &d->snapshot[d->index]);
> > > +
> > > +		switch (d->index) {
> > > +		case 0:
> > > +		case 1:
> > > +			regmap_read(pc->regmap, PWM_CPT_EDGE(channel), &reg);
> > > +			reg ^= PWM_CPT_EDGE_MASK;
> > > +			regmap_write(pc->regmap, PWM_CPT_EDGE(channel), reg);
> > > +
> > > +			d->index++;
> > > +			break;
> > > +		case 2:
> > > +			regmap_write(pc->regmap,
> > > +				     PWM_CPT_EDGE(channel), CPT_EDGE_DISABLED);
> > > +			wake_up(&d->wait);
> > > +			break;
> > > +		default:
> > > +			dev_err(dev, "Internal error\n");
> > > +		}
> > > +
> > > +		clear_bit(channel, (unsigned long int *)&cpt_int_stat);
> > 
> > clear_bit() is a little unusual to use on regular data types, as
> > evidenced by the need for the goofy cast here.
> 
> It's just a bit neater (and provides locking) than manually bit
> twiddling using bitwise operators.  What do you suggest?

I think the cast indicates that you're mixing unrelated interfaces. Also
looking at patch 9/11 it seems like you'll need extra locking to protect
against concurrent accesses in the interrupt handler and the ->capture()
implementation anyway, so might as well use that lock for this access.

> > > @@ -371,7 +447,7 @@ static int sti_pwm_probe(struct platform_device *pdev)
> > >  	struct sti_pwm_chip *pc;
> > >  	struct resource *res;
> > >  	unsigned int chan;
> > > -	int ret;
> > > +	int ret, irq;
> > >  
> > >  	pc = devm_kzalloc(dev, sizeof(*pc), GFP_KERNEL);
> > >  	if (!pc)
> > > @@ -392,6 +468,19 @@ static int sti_pwm_probe(struct platform_device *pdev)
> > >  	if (IS_ERR(pc->regmap))
> > >  		return PTR_ERR(pc->regmap);
> > >  
> > > +	irq = platform_get_irq(pdev, 0);
> > > +	if (irq < 0) {
> > > +		dev_err(&pdev->dev, "Failed to obtain IRQ\n");
> > > +		return -ENODEV;
> > > +	}
> > 
> > I think you need to propagate the return value of platform_get_irq()
> > here.
> 
> Yes, could do.  Although, I think we could go either way:
> 
> $ git grep -A5 platform_get_irq | grep "return ret\|return irq" | wc -l
> 176
> $ git grep -A5 platform_get_irq | grep "return -EINVAL\|-ENODEV\|-ENXIO" | wc -l
> 256
> 
> Happy to change it though.

I think all the latter are really wrong. Looking at the implementation
of platform_get_irq() there are a number of error codes that it can
return (-EPROBE_DEFER amongst them), so collapsing them all into an
-EINVAL, -ENODEV or -ENXIO is very wrong.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160413/f76e36c9/attachment-0001.sig>
