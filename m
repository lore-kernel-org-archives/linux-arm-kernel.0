From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed, 11 Apr 2012 15:14:19 +0200
Subject: [PATCH v6 05/17] pwm: Add device tree support
In-Reply-To: <20120411130208.GC2445@S2101-09.ap.freescale.net>
References: <1334070400-25013-1-git-send-email-thierry.reding@avionic-design.de>
 <1334070400-25013-6-git-send-email-thierry.reding@avionic-design.de>
 <20120411130208.GC2445@S2101-09.ap.freescale.net>
Message-ID: <20120411131419.GC27337@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Shawn Guo wrote:
> On Tue, Apr 10, 2012 at 05:06:28PM +0200, Thierry Reding wrote:
> > This patch adds helpers to support device tree bindings for the generic
> > PWM API. Device tree binding documentation for PWM controllers is also
> > provided.
> > 
> > Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> > Changes in v6:
> > - don't override error code in of_pwm_simple_xlate()
> > - no longer export of_pwm_request(), only pwm_get() should be used
> 
> Ok, I read this here ...
> 
> > +/**
> > + * of_pwm_request() - request a PWM via the PWM framework
> > + * @np: device node to get the PWM from
> > + * @con_id: consumer name
> > + *
> > + * Returns the PWM device parsed from the phandle and index specified in the
> > + * "pwms" property of a device tree node or a negative error-code on failure.
> > + * Values parsed from the device tree are stored in the returned PWM device
> > + * object.
> > + *
> > + * If con_id is NULL, the first PWM device listed in the "pwms" property will
> > + * be requested. Otherwise the "pwm-names" property is used to do a reverse
> > + * lookup of the PWM index. This also means that the "pwm-names" property
> > + * becomes mandatory for devices that look up the PWM device via the con_id
> > + * parameter.
> > + */
> > +static struct pwm_device *of_pwm_request(struct device_node *np,
> > +					 const char *con_id)
> > +{
> ...
> > +}
> > +EXPORT_SYMBOL(of_pwm_request);
> 
> ... so this line should be removed.  Otherwise,

You are absolutely right. I always thought that gcc would complain if you
tried to export a static function. Funny also that my compile tests haven't
caught this in the !OF configuration. Anyway, since of_pwm_request() is no
longer exported, I've replaced this by an IS_ENABLED(CONFIG_OF) construct
similar to the calls to of_pwmchip_add() and of_pwmchip_remove().

> Reviewed-by: Shawn Guo <shawn.guo@linaro.org>

Thanks,
Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120411/d29bce6d/attachment-0001.sig>
