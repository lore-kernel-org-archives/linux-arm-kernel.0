From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 22 Dec 2011 10:53:58 +0000
Subject: [PATCH] regulator: max8925: fix enabled/disabled judgement mistake
In-Reply-To: <1324543892-32540-1-git-send-email-haojian.zhuang@marvell.com>
References: <1324543892-32540-1-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <20111222105357.GC4546@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 22, 2011 at 04:51:32PM +0800, Haojian Zhuang wrote:
> From: Kevin Liu <kliu5@marvell.com>
> 
> The judgement should depend on the power up/down sequence select.
> With flexible power sequence, regulator is always enabled after boot up.
> With i2c enabled, regulator enable/disable according to output enable bit.

I'm sorry but I'm having a hard time understanding what this changelog
means, please clarify.

> -	return ret & (1 << info->enable_bit);
> +	ldo_seq = (ret >> LDO_SEQ_SHIFT) & LDO_SEQ_MASK;
> +	if (ldo_seq != LDO_SEQ_I2C_EN)
> +		return 1 << info->enable_bit;
> +	else
> +		return ret & (1 << info->enable_bit);

Does this mean that the register for enabling and disabling the register
doesn't always work?  If it does then doesn't that mean that the enable
and disable functions need to be updated as well to either put the
regulator into I2C mode or return an error when it isn't in I2C mode?
