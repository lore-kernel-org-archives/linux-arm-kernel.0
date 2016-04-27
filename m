From: broonie@kernel.org (Mark Brown)
Date: Wed, 27 Apr 2016 10:57:39 +0100
Subject: [RESEND PATCH v2 7/7] usb: xhci: plat: add vbus regulator control
In-Reply-To: <87bn4vpq7j.fsf@intel.com>
References: <1461675460-2295-1-git-send-email-jszhang@marvell.com>
 <1461675460-2295-8-git-send-email-jszhang@marvell.com>
 <87bn4vpq7j.fsf@intel.com>
Message-ID: <20160427095738.GG3217@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 27, 2016 at 08:37:20AM +0300, Felipe Balbi wrote:
> Jisheng Zhang <jszhang@marvell.com> writes:

> > +	vbus = devm_regulator_get(&pdev->dev, "vbus");

> devm_regulator_get_optional() ??

Does USB work without a VBUS?  Unless the answer is yes then I'd expect
this to be just a normal regulator_get().

> 
> > +	if (PTR_ERR(vbus) == -ENODEV) {
> > +		vbus = NULL;
> > +	} else if (IS_ERR(vbus)) {
> > +		ret = PTR_ERR(vbus);
> > +		goto disable_clk;
> > +	} else if (vbus) {
> > +		ret = regulator_enable(vbus);
> > +		if (ret) {
> > +			dev_err(&pdev->dev,
> > +				"failed to enable usb vbus regulator: %d\n",
> > +				ret);
> > +			goto disable_clk;
> > +		}
> > +	}

This is all completely broken unless the supply is optional.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160427/48c0861d/attachment.sig>
