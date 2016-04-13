From: peppe.cavallaro@st.com (Giuseppe CAVALLARO)
Date: Wed, 13 Apr 2016 09:59:00 +0200
Subject: [PATCH 2/5] regulator: st-flashss: Add a regulator driver for
 flashss vsense.
In-Reply-To: <20160413061514.GI14664@sirena.org.uk>
References: <1460474204-5351-1-git-send-email-peter.griffin@linaro.org>
 <1460474204-5351-3-git-send-email-peter.griffin@linaro.org>
 <20160413061514.GI14664@sirena.org.uk>
Message-ID: <570DFC44.8060408@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/13/2016 8:15 AM, Mark Brown wrote:
>> >+static void st_get_satinize_powerup_voltage(struct st_vsense *vsense)
>> >+{
>> >+	void __iomem *ioaddr = vsense->ioaddr;
>> >+	u32 value = readl_relaxed(ioaddr);
>> >+
>> >+	dev_dbg(vsense->dev, "Initial start-up value: (0x%08x)\n", value);
>> >+
>> >+	/* Sanitize voltage values forcing what is provided from start-up */
>> >+	if (value & TOP_VSENSE_CONFIG_LATCHED_PSW_EMMC)
>> >+		value |= TOP_VSENSE_CONFIG_REG_PSW_EMMC;
>> >+	else
>> >+		value &= ~TOP_VSENSE_CONFIG_REG_PSW_EMMC;
>> >+
>> >+	if (value & TOP_VSENSE_CONFIG_LATCHED_PSW_NAND)
>> >+		value |= TOP_VSENSE_CONFIG_REG_PSW_NAND;
>> >+	else
>> >+		value &= ~TOP_VSENSE_CONFIG_REG_PSW_NAND;
>> >+
>> >+	if (value & TOP_VSENSE_CONFIG_LATCHED_PSW_SPI)
>> >+		value |= TOP_VSENSE_CONFIG_REG_PSW_SPI;
>> >+	else
>> >+		value &= ~TOP_VSENSE_CONFIG_REG_PSW_SPI;
> This looks like a very complicated way of writing
>
> 	value &= TOP_VSENSE_CONFIG_LATCHED_PSW_SPI |
> 		TOP_VSENSE_CONFIG_LATCHED_PSW_NAND |
> 		TOP_VSENSE_CONFIG_REG_PSW_EMMC
>
> or am I missing something?  Why do we need to do this anyway, it's very
> surprsing?
>

This functions is to sanitize the vsense voltages when the regulator
is probed and in some circumstances the reset value of this register
does not reflect the hw status/config. For example, by default, after
the reset, the bit 0 is set so the EMMC, inside the flash subsystem,
is supposed to operate at 3v3. But the latched bit 24 can be 0 on
a platform where it is actually set at 1v8.
So the bit 0 must be reset to keep this coherent and to allow MMC
framework to properly setup the Vdd when the framework starts.

Hoping this can help.

Regards
peppe
