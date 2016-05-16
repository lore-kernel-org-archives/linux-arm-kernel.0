From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 16 May 2016 10:49:13 +0200
Subject: [RFC PATCH 1/3] reset: Add support for the Amlogic Meson GXBB
 Reset Controller
In-Reply-To: <m2oa881xwp.fsf@baylibre.com>
References: <1463148012-25988-1-git-send-email-narmstrong@baylibre.com>
 <1463148012-25988-2-git-send-email-narmstrong@baylibre.com>
 <m2oa881xwp.fsf@baylibre.com>
Message-ID: <57398989.2020207@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/14/2016 05:07 PM, Kevin Hilman wrote:
> Neil Armstrong <narmstrong@baylibre.com> writes:
>> +	writel(readl(reg_addr) | BIT(offset), reg_addr);
> 
> The spec lists these registers as 16-bit registers, so probably readw/writew
> are more appropriate here.


Looking at the datasheet, the reset controller is an APB3 module, thus 32bit would be the only data width configured.

Sure, it's strange to only have 16 used bits per registers...

> 
>> +	return 0;
>> +}
>> +
>> +static int meson_gxbb_reset_deassert(struct reset_controller_dev *rcdev,
>> +				unsigned long id)
>> +{
>> +	struct meson_gxbb_reset *data =
>> +		container_of(rcdev, struct meson_gxbb_reset, rcdev);
>> +	unsigned int bank = id / BITS_PER_REG;
>> +	unsigned int offset = id % BITS_PER_REG;
>> +	void *reg_addr = data->reg_base + (bank << 2);
>> +
>> +	if (bank >= REG_COUNT)
>> +		return -EINVAL;
>> +
>> +	writel(readl(reg_addr) & ~BIT(offset), reg_addr);
> 
> and here.
> 
>> +	return 0;
>> +}
> 
> Kevin
> 

Neil
