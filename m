From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 12 May 2014 16:30:52 +0200
Subject: [PATCH v2 4/7] usb: ehci-platform: add optional reset controller
 retrieval
In-Reply-To: <Pine.LNX.4.44L0.1405101023510.1268-100000@netrider.rowland.org>
References: <1399726619-30150-5-git-send-email-maxime.ripard@free-electrons.com>
 <Pine.LNX.4.44L0.1405101023510.1268-100000@netrider.rowland.org>
Message-ID: <20140512143052.GA17154@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alan,

On Sat, May 10, 2014 at 10:35:49AM -0400, Alan Stern wrote:
> > @@ -206,6 +208,19 @@ static int ehci_platform_probe(struct platform_device *dev)
> >  				break;
> >  			}
> >  		}
> > +
> > +		priv->rst = devm_reset_control_get_optional(&dev->dev,
> > +							    NULL);
> 
> I hate the style that matches arguments on a continuation line with the
> opening paren of the function call, for a couple of reasons.  Instead I
> simply indent continuation lines by two or more tab stops.  But some
> people seem to be incurably attached to it.

Ok, I'll change it.

> > +		if (IS_ERR(priv->rst)) {
> > +			err = PTR_ERR(priv->rst);
> > +			if (err == -EPROBE_DEFER)
> > +				goto err_put_clks;
> > +			priv->rst = NULL;
> > +		} else {
> > +			err = reset_control_deassert(priv->rst);
> > +			if (err)
> > +				goto err_put_clks;
> > +		}
> >  	}
> >  
> >  	if (pdata->big_endian_desc)
> 
> The new code was added inside an "if" statement, which will cause it to
> apply only to OF devices.  Is there any reason not to put the new code
> outside the "if" statement, so it applies to all devices?

Hmmm, I did this because so far, the reset framework only handles the
DT case. But that's right that it can be extended in the future, I'll
update it.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140512/42981ac8/attachment.sig>
