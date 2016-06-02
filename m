From: cedric.madianga@gmail.com (M'boumba Cedric Madianga)
Date: Thu, 2 Jun 2016 17:35:12 +0200
Subject: [PATCH 2/5] i2c: Add STM32F4 I2C driver
In-Reply-To: <CALszF6ADLuZ0wK=L68FDzy5M5_eSPRTbNOjSoQw=dWDOjsPqCA@mail.gmail.com>
References: <1462980974-22091-1-git-send-email-cedric.madianga@gmail.com>
 <1462980974-22091-3-git-send-email-cedric.madianga@gmail.com>
 <CALszF6A-jiCBtSO1RFDdgHKTKmsonRXFVs0x2zHha1LJ3UhwtQ@mail.gmail.com>
 <CAOAejn0Fsizp9fK1mNn3BBeL2LeoVgt5_zF5656La4G2uDPH7g@mail.gmail.com>
 <CAOAejn1NQDJpGrTwGtpvSfVOGg3UuCkj8wLJ7B5LnW1-Z2VrQA@mail.gmail.com>
 <CALszF6ADLuZ0wK=L68FDzy5M5_eSPRTbNOjSoQw=dWDOjsPqCA@mail.gmail.com>
Message-ID: <CAOAejn0G3JzATKME5DaMV0GEBwQVWjkB1=ei-7LOQ98vzkUeVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

>> +
>> +/**
>> + * stm32f4_i2c_xfer() - Transfer combined I2C message
>> + * @i2c_adap: Adapter pointer to the controller
>> + * @msgs: Pointer to data to be written.
>> + * @num: Number of messages to be executed
>> + */
>> +static int stm32f4_i2c_xfer(struct i2c_adapter *i2c_adap, struct i2c_msg msgs[],
>> +                           int num)
>> +{
>> +       struct stm32f4_i2c_dev *i2c_dev = i2c_get_adapdata(i2c_adap);
>> +       int ret, i;
>> +
>> +       i2c_dev->busy = true;
>> +
>> +       ret = clk_prepare_enable(i2c_dev->clk);
>> +       if (ret) {
>> +               dev_err(i2c_dev->dev, "Failed to prepare_enable clock\n");
>> +               return ret;
>> +       }
>> +
>> +       stm32f4_i2c_hw_config(i2c_dev);
> Maybe you could call this only at probe and resume time?
> You would save some register accesses.
Some clarification about this point.
We need to call stm32f4_i2c_hw_config before each I2C transfer as at
the end of I2C communication the peripheral is automatically disabled
and configuration registers are reset.


BR,
Cedric
