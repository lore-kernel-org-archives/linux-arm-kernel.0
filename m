From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 26 Jul 2012 12:50:55 +0100
Subject: [PATCH 20/21] ASoC: codecs: Enable AB8500 CODEC for Device Tree
In-Reply-To: <1343298534-13611-21-git-send-email-lee.jones@linaro.org>
References: <1343298534-13611-1-git-send-email-lee.jones@linaro.org>
 <1343298534-13611-21-git-send-email-lee.jones@linaro.org>
Message-ID: <20120726115055.GD3099@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 26, 2012 at 11:28:53AM +0100, Lee Jones wrote:

>  drivers/mfd/ab8500-core.c               |    1 +
>  include/linux/mfd/abx500/ab8500-codec.h |    6 ++-
>  sound/soc/codecs/ab8500-codec.c         |   79 +++++++++++++++++++++++++++++++
>  3 files changed, 84 insertions(+), 2 deletions(-)

Yet again no binding documentation....

>  	{
>  		.name = "ab8500-codec",
> +		.of_compatible = "stericsson,ab8500-codec",
>  	},

Why are we doing this?  The MFD cells are a totally Linux specific
thing, there's no reason to represent them in the device tree unless
they're in some way reusable and the "ab8500-codec" name suggests that's
unlikely.  Just put the properties on the parent node and instantiate
the MFD cell as normal.

> +	/* Has a non-standard Vamic been requested? */
> +	if(of_get_property(np, "stericsson,amic1a-bias-vamic2", NULL))

Coding style.

> +	if (!of_property_read_u32(np, "stericsson,earpeice-cmv", &value)) {
> +		switch (value) {
> +		case 950 :
> +			codec->ear_cmv = EAR_CMV_0_95V;
> +			break;
> +		case 1100 :
> +			codec->ear_cmv = EAR_CMV_1_10V;
> +			break;
> +		case 1270 :
> +			codec->ear_cmv = EAR_CMV_1_27V;
> +			break;
> +		case 1580 :
> +			codec->ear_cmv = EAR_CMV_1_58V;
> +			break;
> +		default :
> +			codec->ear_cmv = EAR_CMV_UNKNOWN;
> +			dev_err(dev, "Unsuitable earpiece voltage found in DT\n");

The platform data code picks a default, can't the DT code do the same?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120726/a86beb69/attachment.sig>
