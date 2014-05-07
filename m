From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 7 May 2014 11:15:12 +0300
Subject: [PATCH 2/4] OMAPDSS: panel-sharp-ls037v7dw01: update to use gpiod
In-Reply-To: <1398815562-24113-3-git-send-email-tony@atomide.com>
References: <1398815562-24113-1-git-send-email-tony@atomide.com>
 <1398815562-24113-3-git-send-email-tony@atomide.com>
Message-ID: <5369EB90.8060007@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/04/14 02:52, Tony Lindgren wrote:
> Using gpiod will make it easier to add device tree support
> for this panel in the following patches.
> 
> Note that all the GPIOs for this panel are optional, any
> of the the GPIOs could be configured with external pulls
> instead of GPIOs, so let's not error out if GPIOs are not
> found to make the panel more generic.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  .../omap2/displays-new/panel-sharp-ls037v7dw01.c   | 92 +++++++++-------------
>  1 file changed, 38 insertions(+), 54 deletions(-)

<snip>

> +static struct gpio_desc *
> +sharp_ls_get_gpio(struct device *dev, int gpio, unsigned long flags,
> +		  char *desc)
> +{
> +	int r;
> +
> +	r = devm_gpio_request_one(dev, gpio, flags, desc);
> +	if (r) {
> +		dev_err(dev, "no %s gpio\n", desc);

As it's fine to not have a gpio, I guess this error print should be removed.

Also, if the error is EPROBE_DEFER, the driver should fail and return
that. The same goes for the DT version in the next patch.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140507/0a152871/attachment-0001.sig>
