From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 24 Aug 2016 08:41:53 +0200
Subject: [PATCH v3 4/4] iio: adc: add support for Allwinner SoCs ADC
In-Reply-To: <bccb6739-4804-8c71-a120-2cb8672fb57e@free-electrons.com>
References: <1469519027-11387-1-git-send-email-quentin.schulz@free-electrons.com>
 <1469519027-11387-5-git-send-email-quentin.schulz@free-electrons.com>
 <20160729071230.GB6215@lukather>
 <bccb6739-4804-8c71-a120-2cb8672fb57e@free-electrons.com>
Message-ID: <20160824064153.GC8103@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 04, 2016 at 10:41:00AM +0200, Quentin Schulz wrote:
> > However, I'm not sure this is even possible. Isn't the point of the
> > runtime_pm precisely to not be called while you're using the device?
> 
> I agree on the principle but I am using runtime_pm functions (I am
> mainly talking about the pm_runtime_put function) when probing or
> removing the driver. Let's say we remove the mutex locks in runtime_pm
> functions, what will happen if we are reading raw values from the ADC
> when removing the ADC driver for example?

Most likely, the first thing you will be doing in your remove is to
unregister from the framework, so you won't be able to start any new
conversion. So that case shouldn't happen.

> >> +	/* Disable all hardware interrupts */
> >> +	regmap_write(info->regmap, SUNXI_GPADC_TP_INT_FIFOC, 0);
> > 
> > This looks like the wrong place to do that. You'll disable the
> > interrupts of all the devices of the MFD, which is probbaly not what
> > you want to do (and if you do, you want to do it in the MFD driver).
> 
> Yes but all subdrivers of the MFD are using IIO channels from the ADC
> driver so anyway they would not work at all.

I'm not sure what you mean by that.

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160824/5c7f2069/attachment.sig>
