From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 13 May 2014 09:51:33 +0200
Subject: [PATCH v3 5/8] usb: ehci-platform: add optional reset controller
 retrieval
In-Reply-To: <Pine.LNX.4.44L0.1405121604140.1202-100000@iolanthe.rowland.org>
References: <1399923274-6017-6-git-send-email-maxime.ripard@free-electrons.com>
 <Pine.LNX.4.44L0.1405121604140.1202-100000@iolanthe.rowland.org>
Message-ID: <20140513075133.GA16873@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 12, 2014 at 04:06:16PM -0400, Alan Stern wrote:
> On Mon, 12 May 2014, Maxime Ripard wrote:
> 
> > From: Boris BREZILLON <boris.brezillon@free-electrons.com>
> > 
> > On the Allwinner's A31 SoC the reset line connected to the EHCI IP has to
> > be deasserted for the EHCI block to be usable.
> > 
> > Add support for an optional reset controller that will be deasserted on
> > power off and asserted on power on.
> > 
> > Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> 
> ...
> 
> > @@ -208,6 +210,18 @@ static int ehci_platform_probe(struct platform_device *dev)
> >  		}
> >  	}
> >  
> > +	priv->rst = devm_reset_control_get_optional(&dev->dev, NULL);
> > +	if (IS_ERR(priv->rst)) {
> > +		err = PTR_ERR(priv->rst);
> > +		if (err == -EPROBE_DEFER)
> > +			goto err_put_clks;
> > +		priv->rst = NULL;
> > +	} else {
> > +		err = reset_control_deassert(priv->rst);
> > +		if (err)
> > +			goto err_put_clks;
> > +	}
> > +
> >  	if (pdata->big_endian_desc)
> >  		ehci->big_endian_desc = 1;
> >  	if (pdata->big_endian_mmio)
> 
> You don't re-assert the reset control if an error happens later on 
> during probe.  Was that intentional?

No, it wasn't. I'll resubmit another version.

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140513/397a9394/attachment.sig>
