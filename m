From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 18 Aug 2016 13:27:41 +0200
Subject: [PATCH 2/4] soc: qcom: add EBI2 driver
In-Reply-To: <e073d8b7-a658-ec10-5f17-cfeeb5d46319@codeaurora.org>
References: <1470691445-27571-1-git-send-email-linus.walleij@linaro.org>
 <1470691445-27571-3-git-send-email-linus.walleij@linaro.org>
 <e073d8b7-a658-ec10-5f17-cfeeb5d46319@codeaurora.org>
Message-ID: <CACRpkdbXvJx4a=h_bJrVCX4izeBPh2SSCm1JZY8FUhekBJ=OEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 9, 2016 at 1:33 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 08/08/2016 02:24 PM, Linus Walleij wrote:

> drivers/bus seems ok to me.

Moved to drivers/bus.

>> +config QCOM_EBI2
>> +     bool "Qualcomm External Bus Interface 2 (EBI2)"
>> +     default y if ARCH_MSM8X60
>
> Please don't do any default. I've been trying to get rid of ARCH_MSM8X60
> as a Kconfig symbol for some time.

OK cut it, let's defconfig it in or something.

>> +/* Guessed bit placement CS2 and CS3 are certain */
>> +/* What about CS1A, CS1B, CS2A, CS2B? */
>> +#define EBI2_CS0_ENABLE BIT(2) /* GUESS */
>> +#define EBI2_CS1_ENABLE BIT(3) /* GUESS */
>> +#define EBI2_CS2_ENABLE BIT(4)
>> +#define EBI2_CS3_ENABLE BIT(5)
>> +#define EBI2_CS4_ENABLE BIT(6) /* GUESS */
>> +#define EBI2_CS5_ENABLE BIT(7) /* GUESS */
>> +#define EBI2_CSN_MASK BIT(2)|BIT(3)|BIT(4)|BIT(5)|BIT(6)|BIT(7)
>
> CS0, CS1, CS4, CS5 are 2 bits wide.

I guess that reads:
CS0 bit 0,1
CS1 bit 2,3
CS2 bit 4
CS3 bit 5
CS4 bit 6,7
CS5 bit 8,9

And the register is 32bits wide. Augmenting the code like this.

>> +/*
>> + * FAST CSn CFG
>> + * Bits 31-28: ?
>> + * Bits 27-24: RD_HOLD: the length in cycles of the first segment of a read
>> + *             transfer. For a single read trandfer this will be the time
>> + *             from CS assertion to OE assertion.
>> + * Bits 18-24: ?
>> + * Bits 17-16: ADV_OE_RECOVERY, the number of cycles elapsed before an OE
>> + *             assertion, with respect to the cycle where ADV is asserted.
>> + *             2 means 2 cycles between ADV and OE. Values 0, 1, 2 or 3.
>> + * Bits 5:     ADDR_HOLD_ENA, The address is held for an extra cycle to meet
>> + *             hold time requirements with ADV assertion.
>> + *
>> + * The manual mentions "write precharge cycles" and "precharge cycles".
>> + * We have not been able to figure out which bit fields these correspond to
>> + * in the hardware, or what valid values exist. The current hypothesis is that
>> + * this is something just used on the FAST chip selects. There is also a "byte
>> + * device enable" flag somewhere for 8bit memories.
>> + */
>> +#define EBI2_XMEM_CS0_FAST_CFG 0x0028 /* GUESS */
>> +#define EBI2_XMEM_CS1_FAST_CFG 0x002C /* GUESS */
>> +#define EBI2_XMEM_CS2_FAST_CFG 0x0030 /* GUESS */
>> +#define EBI2_XMEM_CS3_FAST_CFG 0x0034
>> +#define EBI2_XMEM_CS4_FAST_CFG 0x0038 /* GUESS */
>> +#define EBI2_XMEM_CS5_FAST_CFG 0x003C /* GUESS */
>
> Guesses are correct.

Thanks, feel more secure. You don't happen to know about the
uses of bits 31-28 or bits 18-24 in these registers?

>> +     clk = devm_clk_get(dev, "ebi2x");
>> +     if (IS_ERR(clk)) {
>> +             dev_err(dev, "could not get EBI2X clk (%li)\n", PTR_ERR(clk));
>> +             return PTR_ERR(clk);
>
> This could be noisy on probe defer...

OK skipping it.

>> +     ret = clk_prepare_enable(clk);
>> +     if (ret) {
>> +             dev_err(dev, "could not enable EBI2 clk\n");
>> +             return ret;
>
> clk_disable_unprepare ebi2x clk? Or perhaps get both clks first and then
> try to enable both in succession.

OK will handle the errorpath better.

>> +             dev_info(dev, "enabled CS%u\n", csindex);
>
> dev_dbg?

OK. Once everything works I will take a swep and dev_dbg()
a bunch of stuff.

>> +             if (slowcfg)
>> +                     writel_relaxed(slowcfg, ebi2_xmem + csd->slow_cfg);
>> +             if (fastcfg)
>> +                     writel_relaxed(fastcfg, ebi2_xmem + csd->fast_cfg);
>
> The documentation just speaks of config0 and config1, but I guess if
> slow and fast is meaningful to you then it's ok.

That comes from the very similar hardware
Cypress AN49576 Antioch Westbridge
http://www.cypress.com/file/105771/download
they call then "Fast_CSn_CFG0" and "Slow_CSn_CFG1"
respectively.

Yours,
Linus Walleij
