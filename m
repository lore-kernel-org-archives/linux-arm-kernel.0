From: jszhang@marvell.com (Jisheng Zhang)
Date: Wed, 27 Apr 2016 18:25:16 +0800
Subject: [RESEND PATCH v2 7/7] usb: xhci: plat: add vbus regulator control
In-Reply-To: <20160427095738.GG3217@sirena.org.uk>
References: <1461675460-2295-1-git-send-email-jszhang@marvell.com>
 <1461675460-2295-8-git-send-email-jszhang@marvell.com>
 <87bn4vpq7j.fsf@intel.com>	<20160427095738.GG3217@sirena.org.uk>
Message-ID: <20160427182516.36bd5fb5@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Mark,

On Wed, 27 Apr 2016 10:57:39 +0100 Mark Brown wrote:

> On Wed, Apr 27, 2016 at 08:37:20AM +0300, Felipe Balbi wrote:
> > Jisheng Zhang <jszhang@marvell.com> writes:  
> 
> > > +	vbus = devm_regulator_get(&pdev->dev, "vbus");  
> 
> > devm_regulator_get_optional() ??  
> 
> Does USB work without a VBUS?  Unless the answer is yes then I'd expect
> this to be just a normal regulator_get().

Per spec no. But the vbus may be transparent to SW on some platforms, so I
think devm_regulator_get_optional() is better.

> 
> >   
> > > +	if (PTR_ERR(vbus) == -ENODEV) {
> > > +		vbus = NULL;
> > > +	} else if (IS_ERR(vbus)) {
> > > +		ret = PTR_ERR(vbus);
> > > +		goto disable_clk;
> > > +	} else if (vbus) {
> > > +		ret = regulator_enable(vbus);
> > > +		if (ret) {
> > > +			dev_err(&pdev->dev,
> > > +				"failed to enable usb vbus regulator: %d\n",
> > > +				ret);
> > > +			goto disable_clk;
> > > +		}
> > > +	}  
> 
> This is all completely broken unless the supply is optional.

The supply is optional.

Thanks for your review,
Jisheng
