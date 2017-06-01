From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 1 Jun 2017 10:46:33 +0100
Subject: [PATCH 4/4] drm/bridge: dw-hdmi: add cec driver
In-Reply-To: <db1f1785-930b-0f32-d71a-79ae8e053b2c@xs4all.nl>
References: <20170530142218.GS22219@n2100.armlinux.org.uk>
 <E1dFi3P-0004lv-2K@rmk-PC.armlinux.org.uk>
 <db1f1785-930b-0f32-d71a-79ae8e053b2c@xs4all.nl>
Message-ID: <20170601094633.GE27796@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 01, 2017 at 10:31:10AM +0200, Hans Verkuil wrote:
> Hi Russell,
> 
> First a few top-level questions:

Hi Hans,

> 1) What was the reason for using the cec-notifier here? Isn't this
>    tightly integrated into the main dw-hdmi block? For the tda driver
>    it is clearly required, but for tightly coupled HDMI & CEC HW I
>    just create the adapter from the HDMI driver. As a small bonus it
>    avoids adding the cec-notifier code and the control flow is a bit
>    easier to trace.

It's to avoid complex dependencies.  If it's all built in to the HDMI
driver, then the HDMI driver needs to depend on all the media stuff
being non-modular.  For a video output device, this is sub-optimal,
because you want the video output device to work during boot.

I feel strongly about this point, especially as we have had many years
of users being able to use dw-hdmi without needing CEC enabled.

> 2) I may have asked this before, apologies if I repeat myself: does
>    this CEC implementation support CEC monitoring (aka snooping)? If
>    it does, then I recommend that it is implemented since it is very
>    useful.

It does not.

> 3) Is the CEC still active if there is no hotplug signal? Or is it
>    powered off in that case? Ideally it should still be possible to
>    send CEC messages even if there is no hotplug. This is explicitly
>    allowed by the CEC 2.0 spec to wake up displays that turn off the
>    HPD, but that still have a working CEC controller.

This is not specified in the documentation, so I don't think we know
without experimentation.  This would be a future enhancement to the
patch set.

> > diff --git a/drivers/gpu/drm/bridge/synopsys/Kconfig b/drivers/gpu/drm/bridge/synopsys/Kconfig
> > index 40d2827a6d19..bd30a0a07272 100644
> > --- a/drivers/gpu/drm/bridge/synopsys/Kconfig
> > +++ b/drivers/gpu/drm/bridge/synopsys/Kconfig
> > @@ -21,3 +21,11 @@ config DRM_DW_HDMI_I2S_AUDIO
> >  	help
> >  	  Support the I2S Audio interface which is part of the Synopsys
> >  	  Designware HDMI block.
> > +
> > +config DRM_DW_HDMI_CEC
> > +	tristate "Synopsis Designware CEC interface"
> > +	depends on DRM_DW_HDMI && MEDIA_CEC_SUPPORT
> > +	select MEDIA_CEC_NOTIFIER
> > +	help
> > +	  Support the CE interface which is part of the Synopsis
> > +	  Designware HDMI block.
> 
> This will change. Patches to fix the config handling are pending for 4.12.
> 
> Here you can see the pending patches:
> https://git.linuxtv.org/hverkuil/media_tree.git/log/?h=drm-cec
> 
> The patches from 'cec-notifier.h: handle unreachable CONFIG_CEC_CORE' to
> 'cec: drop MEDIA_CEC_DEBUG' should all be merged in 4.12.
> 
> That means that this config becomes:
> 
> +
> +config DRM_DW_HDMI_CEC
> +	tristate "Synopsis Designware CEC interface"
> +	depends on DRM_DW_HDMI
> +	select CEC_CORE
> +	select CEC_NOTIFIER
> +	help
> +	  Support the CE interface which is part of the Synopsis
> +	  Designware HDMI block.

You will also need to select MEDIA_SUPPORT to avoid dependency issues.
CEC_CORE and CEC_NOTIFIER are both lumped under an "if MEDIA_SUPPORT"
block in drivers/media/Kconfig, so they depend on this symbol.  Asking
Kconfig to select these two symbols without MEDIA_SUPPORT creates an
invalid configuration - unless CEC has been moved out from being under
MEDIA_SUPPORT.  (I haven't looked at your tree yet.)

> > +static int dw_hdmi_cec_log_addr(struct cec_adapter *adap, u8 logical_addr)
> > +{
> > +	struct dw_hdmi_cec *cec = adap->priv;
> > +	u32 addresses;
> > +
> > +	if (logical_addr == CEC_LOG_ADDR_INVALID)
> > +		addresses = cec->addresses = 0;
> > +	else
> > +		addresses = cec->addresses |= BIT(logical_addr) | BIT(15);
> > +
> > +	dw_hdmi_write(cec, addresses & 255, HDMI_CEC_ADDR_L);
> > +	dw_hdmi_write(cec, addresses >> 8, HDMI_CEC_ADDR_H);
> 
> The addresses local variable doesn't really seem needed.

Ok.

> > +static int dw_hdmi_cec_transmit(struct cec_adapter *adap, u8 attempts,
> > +				u32 signal_free_time, struct cec_msg *msg)
> > +{
> > +	struct dw_hdmi_cec *cec = adap->priv;
> > +	unsigned i;
> > +
> > +	cec->retries = attempts;
> 
> Should probably be 'cec->retries = attempts - 1;'
> Since 2 attempts == 1 retry.

Probably correct, but rather moot given your comment below.

> > +static irqreturn_t dw_hdmi_cec_hardirq(int irq, void *data)
> > +{
> > +	struct cec_adapter *adap = data;
> > +	struct dw_hdmi_cec *cec = adap->priv;
> > +	unsigned stat = dw_hdmi_read(cec, HDMI_IH_CEC_STAT0);
> > +	irqreturn_t ret = IRQ_HANDLED;
> > +
> > +	if (stat == 0)
> > +		return IRQ_NONE;
> > +
> > +	dw_hdmi_write(cec, stat, HDMI_IH_CEC_STAT0);
> > +
> > +	if (stat & CEC_STAT_ERROR_INIT) {
> > +		if (cec->retries) {
> > +			unsigned v = dw_hdmi_read(cec, HDMI_CEC_CTRL);
> > +			dw_hdmi_write(cec, v | CEC_CTRL_START, HDMI_CEC_CTRL);
> > +			cec->retries -= 1;
> 
> Why handle retries here at all? Just mark this as CEC_TX_STATUS_ERROR and set
> tx_done to true. The CEC core will just call dw_hdmi_cec_transmit again if
> it needs to make another attempt. I suggest that the whole retry code is
> dropped.

Probably comes from a previous iteration of your CEC core which required
the driver to do retries, so it can probably be fixed up in the way you
describe.

However, presumably this needs a different status other than
"CEC_TX_STATUS_MAX_RETRIES"?  I don't see a way to report this error to
the CEC core in a way that it will retry.

> > +static irqreturn_t dw_hdmi_cec_thread(int irq, void *data)
> > +{
> > +	struct cec_adapter *adap = data;
> > +	struct dw_hdmi_cec *cec = adap->priv;
> > +
> > +	if (cec->tx_done) {
> > +		cec->tx_done = false;
> > +		cec_transmit_done(adap, cec->tx_status, 0, 0, 0, 0);
> 
> I think I will make a patch for a new helper function where you can just call:
> 
> cec_transmit_attempt_done(adap, cec->tx_status);
> 
> and that will call cec_transmit_done filling in the other arguments
> based on the status.
> 
> Most CEC HW doesn't do retries so only make one attempt. In that case
> only one of the remaining count arguments is 1 and that's based on the
> status.
> 
> Having correct error counts is useful for debugging problems.

It hasn't been clear to me which counts should be non-zero, and it seems
like entirely redundant information given that the status argument
indicates what happened to the message.

> > +static void dw_hdmi_cec_disable(struct dw_hdmi *hdmi)
> > +{
> > +	mutex_lock(&hdmi->mutex);
> > +	hdmi->mc_clkdis |= HDMI_MC_CLKDIS_CECCLK_DISABLE;
> > +	hdmi_writeb(hdmi, hdmi->mc_clkdis, HDMI_MC_CLKDIS);
> > +	mutex_unlock(&hdmi->mutex);
> > +}
> > +
> > +static const struct dw_hdmi_cec_ops dw_hdmi_cec_ops = {
> > +	.write = hdmi_writeb,
> > +	.read = hdmi_readb,
> > +	.enable = dw_hdmi_cec_enable,
> > +	.disable = dw_hdmi_cec_disable,
> > +};
> > +
> 
> This feels over-engineered and I suspect it is simplified if you just
> add a cec_adapter pointer to struct dw_hdmi and link dw-hdmi-cec.c
> together with dw-hdmi.c.

As I mention above, to do so would mean that dw-hdmi has to be modular
if you want CEC to be modular, and I don't think that is reasonable
for a video output device, which may be the source of kernel boot
messages.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
