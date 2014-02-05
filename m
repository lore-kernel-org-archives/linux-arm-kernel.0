From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 05 Feb 2014 14:38:44 +0100
Subject: [PATCH 10/18] mfd: max14577: Add detection of device type
In-Reply-To: <20140203095541.GK13529@lee--X1>
References: <1390911522-28209-1-git-send-email-k.kozlowski@samsung.com>
 <1390911522-28209-11-git-send-email-k.kozlowski@samsung.com>
 <20140203095541.GK13529@lee--X1>
Message-ID: <1391607524.3726.23.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2014-02-03 at 09:55 +0000, Lee Jones wrote:
> > This patch continues the preparation for adding support for max77836
> > device to existing max14577 driver.
> > 
> > Add enum for types of devices supported by this driver. The device type
> > will be detected by matching of_device_id, or i2c_device_id as a
> > fallback.
> > 
> > The patch also moves to separate function the code related to displaying
> > DeviceID register values.
> > 
> > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > Cc: Kyungmin Park <kyungmin.park@samsung.com>
> > Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> > ---
> >  drivers/mfd/max14577.c               |   61 +++++++++++++++++++++++-----------
> >  include/linux/mfd/max14577-private.h |   12 ++++---
> >  2 files changed, 50 insertions(+), 23 deletions(-)
> > 
> > diff --git a/drivers/mfd/max14577.c b/drivers/mfd/max14577.c
> > index 1d8104213b3e..224aba8c5b3f 100644
> > --- a/drivers/mfd/max14577.c
> > +++ b/drivers/mfd/max14577.c
> > @@ -20,6 +20,7 @@
> 
> <snip>
> 
> > +static void max14577_print_dev_type(struct maxim_core *maxim_core)
> > +{
> > +	u8 reg_data, vendor_id, device_id;
> > +	int ret = max14577_read_reg(maxim_core->regmap_muic,
> > +			MAXIM_MUIC_REG_DEVICEID, &reg_data);
> 
> I'm not a big fan of declaring variables whilst feeding them with
> function return values. Can you separate the two please?

Sure.

> 
> > +	if (ret) {
> > +		dev_err(maxim_core->dev, "Failed to read DEVICEID
> > register: %d\n",
> 
> I think this is too many chars.

OK.

> 
> > +				ret);
> > +		return;
> > +	}
> > +
> 
> <snip>
> 
> > -	ret = max14577_read_reg(maxim_core->regmap_muic,
> > -			MAXIM_MUIC_REG_DEVICEID, &reg_data);
> > -	if (ret) {
> > -		dev_err(maxim_core->dev, "Device not found on this channel: %d\n",
> > -				ret);
> > -		return ret;
> > +	if (np) {
> > +		const struct of_device_id *of_id =
> > +			of_match_device(max14577_dt_match, &i2c->dev);
> 
> Again this is a bit messy. Bring it down onto a separate line.

OK.

I'll send fixed version after grabbing more ACK-s for previous
rename-patches (this patch depends on them).

Best regards,
Krzysztof
