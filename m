From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Tue, 14 Feb 2017 11:29:39 +0200
Subject: [PATCH v6 3/3] i2c: zx2967: add i2c controller driver for ZTE's
 zx2967 family
In-Reply-To: <8322ae7c-a74d-c6a3-9cdb-4cd5584f37d4@linaro.org>
References: <1486632753-17363-1-git-send-email-baoyou.xie@linaro.org>
 <1486632753-17363-3-git-send-email-baoyou.xie@linaro.org>
 <8322ae7c-a74d-c6a3-9cdb-4cd5584f37d4@linaro.org>
Message-ID: <CAHp75VcwAym_ujHfyEJKypsvQftCY5JytDy922xqMM9yKz1GfQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 14, 2017 at 6:05 AM, Jun Nie <jun.nie@linaro.org> wrote:
> On 2017?02?09? 17:32, Baoyou Xie wrote:
>>

First of all, please, Jun, remove tons of lines of over quoting when
answering to emails with one line question. Respect others time.

See below.

>> +static irqreturn_t zx2967_i2c_isr(int irq, void *dev_id)
>> +{
>> +       u32 status;
>> +       struct zx2967_i2c_info *zx_i2c = (struct zx2967_i2c_info *)dev_id;
>> +       unsigned long flags;
>> +
>> +       spin_lock_irqsave(&zx_i2c->lock, flags);
>
>
> Is this spin lock really necessary?

If you protect IO and one CPU is in interrupt while another in some
other function you need to have a spin lock.

>> +
>> +       status = zx2967_i2c_readl(zx_i2c, REG_STAT) & I2C_INT_MASK;
>> +       zx2967_i2c_isr_clr(zx_i2c);
>> +
>> +       if (status & I2C_ERROR_MASK) {
>> +               spin_unlock_irqrestore(&zx_i2c->lock, flags);
>> +               return IRQ_HANDLED;
>> +       }
>> +
>> +       if (status & I2C_TRANS_DONE)
>> +               complete(&zx_i2c->complete);
>> +
>> +       spin_unlock_irqrestore(&zx_i2c->lock, flags);
>> +
>> +       return IRQ_HANDLED;
>> +}

-- 
With Best Regards,
Andy Shevchenko
