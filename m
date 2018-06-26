From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Tue, 26 Jun 2018 20:18:44 +0300
Subject: [PATCH 5/5] i2c: Add Actions Semi OWL family S900 I2C driver
In-Reply-To: <20180626170125.GB5241@Mani-XPS-13-9360>
References: <20180623161147.15672-1-manivannan.sadhasivam@linaro.org>
 <20180623161147.15672-6-manivannan.sadhasivam@linaro.org>
 <CAHp75Vf_JR6scrwnomiu62_x2idgCGH63UdMf2bhfy8VNaijXQ@mail.gmail.com>
 <20180626170125.GB5241@Mani-XPS-13-9360>
Message-ID: <CAHp75VdR5UbGvM3AOu21+Hp1xqPgtSnjRSKyhnCeB8ebAmF7eQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 26, 2018 at 8:01 PM, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
> On Mon, Jun 25, 2018 at 12:38:50PM +0300, Andy Shevchenko wrote:
>> On Sat, Jun 23, 2018 at 7:11 PM, Manivannan Sadhasivam
>> <manivannan.sadhasivam@linaro.org> wrote:

>> > +#define OWL_I2C_REG_CTL                (0x0000)
>> > +#define OWL_I2C_REG_CLKDIV     (0x0004)
>> > +#define OWL_I2C_REG_STAT       (0x0008)
>> > +#define OWL_I2C_REG_ADDR       (0x000C)
>> > +#define OWL_I2C_REG_TXDAT      (0x0010)
>> > +#define OWL_I2C_REG_RXDAT      (0x0014)
>> > +#define OWL_I2C_REG_CMD                (0x0018)
>> > +#define OWL_I2C_REG_FIFOCTL    (0x001C)
>> > +#define OWL_I2C_REG_FIFOSTAT   (0x0020)
>> > +#define OWL_I2C_REG_DATCNT     (0x0024)
>> > +#define OWL_I2C_REG_RCNT       (0x0028)
>>
>> I don't understand why these have parents?
>>
>
> I'm not sure what you mean here! Can you please elaborate?

One has to read 'parens'. Sorry for confusion.

>> > +#define OWL_I2C_TIMEOUT                (msecs_to_jiffies(4 * 1000))
>>
>> Ditto.

> Same as above

Ditto.

>> > +       /* Wait until FIFO reset complete */
>> > +       do {
>> > +               val = readl(i2c_dev->base + OWL_I2C_REG_FIFOCTL);
>> > +               if (!(val & (OWL_I2C_FIFOCTL_RFR | OWL_I2C_FIFOCTL_TFR)))
>> > +                       break;
>> > +       } while (1);
>>
>> No way. Get rid of infinite loop.

> Okay. Can I change it to max of 50 retries with 1ms delay?

Whatever suitable for HW. Rely on datasheet or other source of
information about this timeouts.

>> > +static irqreturn_t owl_i2c_interrupt(int irq, void *_dev)

>> > +               dev_warn(&i2c_dev->adap.dev, "received NACK from device");
>>
>> And if it happens hundreds times in a row?

> Should I change it to dev_dbg?

>> > +               dev_warn(&i2c_dev->adap.dev, "bus error");

> Same as above?

ratelimit, another level, tracepoints, getting rid of them completely
? your call.

-- 
With Best Regards,
Andy Shevchenko
