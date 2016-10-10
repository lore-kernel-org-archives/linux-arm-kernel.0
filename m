From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 10 Oct 2016 14:57:26 +0200
Subject: [PATCH v2 2/4] power: add axp20x-battery driver
In-Reply-To: <20161009062714.5085-2-icenowy@aosc.xyz>
References: <20161009062714.5085-1-icenowy@aosc.xyz>
 <20161009062714.5085-2-icenowy@aosc.xyz>
Message-ID: <20161010125726.GJ3462@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Icenowy,

On Sun, Oct 09, 2016 at 02:27:12PM +0800, Icenowy Zheng wrote:
> +	case POWER_SUPPLY_PROP_CURRENT_NOW:
> +		ret = regmap_read(power->regmap, AXP20X_BATT_DISCHRG_I_H, &dh);
> +		if (ret)
> +			return ret;
> +		ret = regmap_read(power->regmap, AXP20X_BATT_DISCHRG_I_L, &dl);
> +		if (ret)
> +			return ret;
> +		/* it's a 12 bit integer, high 8-bit is stored in dh */
> +		val->intval = dh << 4 | dl >> 4;
> +		break;
> +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +		ret = regmap_read(power->regmap, AXP20X_BATT_V_H, &dh);
> +		if (ret)
> +			return ret;
> +		ret = regmap_read(power->regmap, AXP20X_BATT_V_L, &dl);
> +		if (ret)
> +			return ret;
> +		/* it's a 12 bit integer, high 8-bit is stored in dh */
> +		val->intval = dh << 4 | dl >> 4;
> +		/* The formula below is from axp22_vbat_to_mV function
> +		 * of Allwinner 3.4 kernel.
> +		 */
> +		val->intval = val->intval * 1100 / 1000;
> +		break;

I really feel that this should be implemented through a IIO driver
(like the AXP288). This is especially true for the AXP209 and its
multiple GPIOs that can be muxed to a general purpose ADC, but it's
also true for the AXP221 / 223 TS pin that can also be used as an ADC.

Quentin has been working on this lately for the AXP209, feel free to
sync with him to support the AXP22*

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161010/f2256077/attachment.sig>
