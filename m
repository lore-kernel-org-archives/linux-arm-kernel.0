From: peppe.cavallaro@st.com (Giuseppe CAVALLARO)
Date: Thu, 14 Apr 2016 16:15:34 +0200
Subject: [PATCH 2/5] regulator: st-flashss: Add a regulator driver for
 flashss vsense.
In-Reply-To: <20160413172318.GC29471@sirena.org.uk>
References: <1460474204-5351-1-git-send-email-peter.griffin@linaro.org>
 <1460474204-5351-3-git-send-email-peter.griffin@linaro.org>
 <20160413061514.GI14664@sirena.org.uk> <570DFC44.8060408@st.com>
 <20160413172318.GC29471@sirena.org.uk>
Message-ID: <570FA606.4070908@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mark

On 4/13/2016 7:23 PM, Mark Brown wrote:
> On Wed, Apr 13, 2016 at 09:59:00AM +0200, Giuseppe CAVALLARO wrote:
>> On 4/13/2016 8:15 AM, Mark Brown wrote:
>>>>> +static void st_get_satinize_powerup_voltage(struct st_vsense *vsense)
>>>>> +{
>
>>> or am I missing something?  Why do we need to do this anyway, it's very
>>> surprsing?
>
>> This functions is to sanitize the vsense voltages when the regulator
>> is probed and in some circumstances the reset value of this register
>> does not reflect the hw status/config. For example, by default, after
>> the reset, the bit 0 is set so the EMMC, inside the flash subsystem,
>> is supposed to operate at 3v3. But the latched bit 24 can be 0 on
>> a platform where it is actually set at 1v8.
>> So the bit 0 must be reset to keep this coherent and to allow MMC
>> framework to properly setup the Vdd when the framework starts.
>
> I'm afraid I can't follow that explanation, perhaps because I don't know
> anything about the content of this register except for these three bits.
> I think we do need a comment in the driver explaining what's going on,

yes you are right

> and probably a simplification of the code too if my understanding of the
> effect of all those operations is correct.

Maybe we can simplify the function as:

static void st_get_satinize_powerup_voltage(struct st_vsense *vsense)
{
	void __iomem *ioaddr = vsense->ioaddr;
	u32 value = readl_relaxed(ioaddr);

	/*
	 * After resetting, the CONFIG_REG_PSW_<xxx> are set, this
	 * means 3v3 operating voltage.
	 * The CONFIG_LATCHED_PSW_<xxx> must be used to fix the previous
	 * bits so operating at 1v8 if this is the real HW configuration
	 * at boot time.
	 */
	if (!(value & TOP_VSENSE_CONFIG_LATCHED_PSW_EMMC))
		value &= ~TOP_VSENSE_CONFIG_REG_PSW_EMMC;

	if (!(value & TOP_VSENSE_CONFIG_LATCHED_PSW_NAND))
		value &= ~TOP_VSENSE_CONFIG_REG_PSW_NAND;

	if (!(value & TOP_VSENSE_CONFIG_LATCHED_PSW_SPI))
		value &= ~TOP_VSENSE_CONFIG_REG_PSW_SPI;

	writel_relaxed(value, ioaddr);
}

Le me know if this looks a bit more clear.

Peppe
