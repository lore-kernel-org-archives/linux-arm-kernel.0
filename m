From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 7 Mar 2014 18:19:32 +0100
Subject: [PATCH] i2c: mv64xxx: Fix compilation breakage
In-Reply-To: <20140307160836.GM21483@n2100.arm.linux.org.uk>
References: <1394204370-22979-1-git-send-email-maxime.ripard@free-electrons.com>
 <20140307160836.GM21483@n2100.arm.linux.org.uk>
Message-ID: <20140307171932.GU607@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 07, 2014 at 04:08:36PM +0000, Russell King - ARM Linux wrote:
> On Fri, Mar 07, 2014 at 03:59:30PM +0100, Maxime Ripard wrote:
> > @@ -900,7 +902,8 @@ mv64xxx_i2c_probe(struct platform_device *pd)
> >  exit_free_irq:
> >  	free_irq(drv_data->irq, drv_data);
> >  exit_reset:
> > -	if (pd->dev.of_node && !IS_ERR(drv_data->rstc))
> > +	if (pd->dev.of_node && IS_ENABLED(CONFIG_RESET_CONTROLLER) &&
> > +	    !IS_ERR(drv_data->rstc))
> >  		reset_control_assert(drv_data->rstc);
> 
> Another question is... why do we need to check pd->dev.of_node here?
> If CONFIG_RESET_CONTROLLER is set, we always try to get the reset
> controller node, so drv_data->rstc is either going to be a valid
> pointer, or it's going to be an error pointer - neither
> reset_control_get() nor devm_reset_control_get return NULL.

Hmmm, right. I'll fix this in a later version.

Wolfram, do you want me to respin the patch making use of
reset_get_optional introduced by Philip in its other mail?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140307/e5889c10/attachment.sig>
