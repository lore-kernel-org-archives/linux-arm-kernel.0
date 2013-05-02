From: balbi@ti.com (Felipe Balbi)
Date: Thu, 2 May 2013 19:40:58 +0300
Subject: [PATCH] ARM: OMAP-USB: Fix possible memory leak
In-Reply-To: <1367512124.978518915@f372.mail.ru>
References: <1367510596-27780-1-git-send-email-shc_work@mail.ru>
 <20130502162433.GA10016@kahuna> <1367512124.978518915@f372.mail.ru>
Message-ID: <20130502164058.GC8577@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, May 02, 2013 at 08:28:44PM +0400, Alexander Shiyan wrote:
> > On 20:03-20130502, Alexander Shiyan wrote:
> > > 
> > > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> > > ---
> > >  arch/arm/mach-omap2/usb-host.c | 21 +++++++++++++++++----
> > >  1 file changed, 17 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/arch/arm/mach-omap2/usb-host.c b/arch/arm/mach-omap2/usb-host.c
> > > index aa27d7f..8d17a0d 100644
> > > --- a/arch/arm/mach-omap2/usb-host.c
> > > +++ b/arch/arm/mach-omap2/usb-host.c
> > > @@ -570,8 +570,10 @@ static int usbhs_add_regulator(char *name, char *dev_id, char *dev_supply,
> > >  	supplies->dev_name = dev_id;
> > >  
> > >  	reg_data = kzalloc(sizeof(*reg_data), GFP_KERNEL);
> > > -	if (!reg_data)
> > > +	if (!reg_data) {
> > > +		kfree(supplies);
> > >  		return -ENOMEM;
> > > +	}
> > >  
> > >  	reg_data->constraints.valid_ops_mask = REGULATOR_CHANGE_STATUS;
> > >  	reg_data->consumer_supplies = supplies;
> > > @@ -579,8 +581,11 @@ static int usbhs_add_regulator(char *name, char *dev_id, char *dev_supply,
> > >  
> > >  	config = kmemdup(&hsusb_reg_config, sizeof(hsusb_reg_config),
> > >  			GFP_KERNEL);
> > > -	if (!config)
> > > +	if (!config) {
> > > +		kfree(supplies);
> > > +		kfree(reg_data);
> > >  		return -ENOMEM;
> > > +	}
> > >  
> > >  	config->supply_name = name;
> > >  	config->gpio = gpio;
> > > @@ -589,17 +594,25 @@ static int usbhs_add_regulator(char *name, char *dev_id, char *dev_supply,
> > >  
> > >  	/* create a regulator device */
> > >  	pdev = kzalloc(sizeof(*pdev), GFP_KERNEL);
> > > -	if (!pdev)
> > > +	if (!pdev) {
> > > +		kfree(supplies);
> > > +		kfree(reg_data);
> > > +		kfree(config);
> > >  		return -ENOMEM;
> > > +	}
> > >  
> > >  	pdev->id = PLATFORM_DEVID_AUTO;
> > >  	pdev->name = reg_name;
> > >  	pdev->dev.platform_data = config;
> > >  
> > >  	ret = platform_device_register(pdev);
> > > -	if (ret)
> > > +	if (ret) {
> > >  		pr_err("%s: Failed registering regulator %s for %s\n",
> > >  				__func__, name, dev_id);
> > > +		kfree(supplies);
> > > +		kfree(reg_data);
> > > +		kfree(config);
> > > +	}
> > 
> > Might be better to switch to devm_XXX managed functions?

I don't think it makes sense since the platform_device hasn't been
registered yet.

Still, patch can be improved with proper goto labels instead of
sprinkling different kfree() calls in every single error branch.

> If anyone can rewrite driver to use devm_xx, it would have been better.
> I'm not going to redo the patch yet, let it be so, I just showed a point
> for OMAP-developers.

fair enough.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130502/4c5991d0/attachment.sig>
