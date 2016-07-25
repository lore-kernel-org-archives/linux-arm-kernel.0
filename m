From: maxime.ripard@free-electrons.com (maxime.ripard at free-electrons.com)
Date: Mon, 25 Jul 2016 11:45:42 +0200
Subject: [PATCH 4/5] input: touchscreen: support Allwinner SoCs'
 touchscreen
In-Reply-To: <20160721064140.GA17658@dtor-ws>
References: <1469003351-15263-1-git-send-email-quentin.schulz@free-electrons.com>
 <1469003351-15263-5-git-send-email-quentin.schulz@free-electrons.com>
 <20160721062950.GB5993@lukather> <20160721064140.GA17658@dtor-ws>
Message-ID: <20160725094542.GI7419@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dmitry,

On Wed, Jul 20, 2016 at 11:41:40PM -0700, Dmitry Torokhov wrote:
> On Thu, Jul 21, 2016 at 08:29:50AM +0200, Maxime Ripard wrote:
> > On Wed, Jul 20, 2016 at 10:29:10AM +0200, Quentin Schulz wrote:
> > > +	irq = regmap_irq_get_virq(sunxi_gpadc_mfd_dev->regmap_irqc, irq);
> > > +	ret = devm_request_any_context_irq(&pdev->dev, irq,
> > > +					   sunxi_gpadc_tp_up_irq_handler, 0,
> > > +					   "tp_up", info);
> > > +	if (ret < 0) {
> > > +		dev_err(&pdev->dev,
> > > +			"could not request TP_UP_PENDING interrupt: %d\n", ret);
> > > +		goto err;
> > > +	}
> > 
> > You enable the interrupts...
> > 
> > > +	info->tp_up_irq = irq;
> > > +	disable_irq(irq);
> > > +
> > > +	ret = input_register_device(input);
> > > +	if (ret) {
> > > +		dev_err(&pdev->dev, "failed to register input device\n");
> > > +		goto err;
> > > +	}
> > 
> > ... but your driver isn't registered yet. How does input_report and
> > input_sync behave in such a case?
> 
> This is explicitly allowed:
> 
> "
> ...
>  * NOTE: input_event() may be safely used right after input device was
>  * allocated with input_allocate_device(), even before it is registered
>  * with input_register_device(), but the event will not reach any of the
>  * input handlers. Such early invocation of input_event() may be used
>  * to 'seed' initial state of a switch or initial position of absolute
>  * axis, etc.
>  */
> "

Good to know. Still, it feels like it should be handled explicitly,
instead of relying on the fact that we only call input_event in our
handler and that it works that way.

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160725/12bb33b2/attachment.sig>
