From: cedric.madianga@gmail.com (M'boumba Cedric Madianga)
Date: Wed, 1 Jun 2016 16:01:31 +0200
Subject: [PATCH 2/5] i2c: Add STM32F4 I2C driver
In-Reply-To: <CAOAejn0Fsizp9fK1mNn3BBeL2LeoVgt5_zF5656La4G2uDPH7g@mail.gmail.com>
References: <1462980974-22091-1-git-send-email-cedric.madianga@gmail.com>
 <1462980974-22091-3-git-send-email-cedric.madianga@gmail.com>
 <CALszF6A-jiCBtSO1RFDdgHKTKmsonRXFVs0x2zHha1LJ3UhwtQ@mail.gmail.com>
 <CAOAejn0Fsizp9fK1mNn3BBeL2LeoVgt5_zF5656La4G2uDPH7g@mail.gmail.com>
Message-ID: <CAOAejn1NQDJpGrTwGtpvSfVOGg3UuCkj8wLJ7B5LnW1-Z2VrQA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

>>> +static void stm32f4_i2c_set_speed_mode(struct stm32f4_i2c_dev *i2c_dev)
>>> +{
>>> +       struct stm32f4_i2c_timings *t = &i2c_timings[i2c_dev->speed];
>>> +       u32 ccr, val, clk_rate;
>>> +
>>> +       ccr = readl_relaxed(i2c_dev->base + STM32F4_I2C_CCR);
>>> +       ccr &= ~(STM32F4_I2C_CCR_FS | STM32F4_I2C_CCR_DUTY |
>>> +                STM32F4_I2C_CCR_CCR_MASK);
>>> +
>>> +       clk_rate = clk_get_rate(i2c_dev->clk);
>>> +
>>> +       switch (i2c_dev->speed) {
>>> +       case STM32F4_I2C_SPEED_STANDARD:
>>> +               val = clk_rate / t->rate * 2;
>>> +               if (val < STM32F4_I2C_MIN_CCR)
>>> +                       ccr |= STM32F4_I2C_CCR_CCR(STM32F4_I2C_MIN_CCR);
>>> +               else
>>> +                       ccr |= STM32F4_I2C_CCR_CCR(val);
>>> +               break;
>>> +       case STM32F4_I2C_SPEED_FAST:
>>> +               ccr |= STM32F4_I2C_CCR_FS;
>>> +               if (t->duty) {
>>> +                       ccr |= STM32F4_I2C_CCR_DUTY;
>>> +                       ccr |= STM32F4_I2C_CCR_CCR(clk_rate / t->rate * 25);
>>> +               } else {
>>> +                       ccr |= STM32F4_I2C_CCR_CCR(clk_rate / t->rate * 3);
>>> +               }
>> Is it really useful since duty seems to always be 0?
> Agree, I will rework it by directly set duty at 0 in the register.

Contrary to what I wrote previously, the duty has to be set for FAST
Mode to reach 400khz.
So, I am going to keep the timing struct and set duty to 1 for FAST mode
