From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 26 Jul 2012 12:32:04 +0100
Subject: [PATCH 07/21] ASoC: io: Prevent use of regmap if request fails
In-Reply-To: <1343298534-13611-8-git-send-email-lee.jones@linaro.org>
References: <1343298534-13611-1-git-send-email-lee.jones@linaro.org>
 <1343298534-13611-8-git-send-email-lee.jones@linaro.org>
Message-ID: <20120726113204.GY3099@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 26, 2012 at 11:28:40AM +0100, Lee Jones wrote:

> @@ -52,10 +52,13 @@ static unsigned int hw_read(struct snd_soc_codec *codec, unsigned int reg)
>  		if (codec->cache_only)
>  			return -1;
>  
> -		ret = regmap_read(codec->control_data, reg, &val);
> -		if (ret == 0)
> -			return val;
> -		else
> +		if (codec->using_regmap) {
> +			ret = regmap_read(codec->control_data, reg, &val);
> +			if (ret == 0)
> +				return val;
> +			else
> +				return -1;
> +		} else

No, this makes no sense.  There is no non-regmap I/O support in soc-io,
anything using the soc-io hw_read() function must be using regmap.

>  	case SND_SOC_REGMAP:
>  		/* Device has made its own regmap arrangements */
> -		codec->using_regmap = true;

Again, this makes no sense.  If we're explicitly being asked to use
regmap then we should be using regmap or just failing to set up I/O
(which is obviously a catastrophic failure).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120726/3197f7ea/attachment.sig>
