From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Sun, 1 Jul 2018 12:11:54 +0300
Subject: [PATCH v3 5/6] i2c: Add Actions Semiconductor Owl family S900 I2C
 driver
In-Reply-To: <20180701084140.GC28390@Mani-XPS-13-9360>
References: <20180630133330.23858-1-manivannan.sadhasivam@linaro.org>
 <20180630133330.23858-6-manivannan.sadhasivam@linaro.org>
 <CAHp75VcVNb51tJzKbCU3pqf0XYPCUZWpv38nfaV1711vyf2S0Q@mail.gmail.com>
 <20180701081333.GB28390@Mani-XPS-13-9360>
 <20180701084140.GC28390@Mani-XPS-13-9360>
Message-ID: <CAHp75VcDK7U-x-W9-gaY9-2zAJqnawdwe5gor0ifX8iYe_p0_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 1, 2018 at 11:41 AM, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
> On Sun, Jul 01, 2018 at 01:43:33PM +0530, Manivannan Sadhasivam wrote:
>> On Sun, Jul 01, 2018 at 12:11:00AM +0300, Andy Shevchenko wrote:
>> > On Sat, Jun 30, 2018 at 4:33 PM, Manivannan Sadhasivam
>> > <manivannan.sadhasivam@linaro.org> wrote:
>> > > Add Actions Semiconductor Owl family S900 I2C driver.

>> > > +static int owl_i2c_reset(struct owl_i2c_dev *i2c_dev)
>> > > +{
>> >
>> > > +       mdelay(1);
>> >
>> > But now, since it's not used in atomic context, we may switch to
>> > usleep_range() / msleep() instead.
>> >
>>
>> okay, will use msleep()
>>
>
> Just realised, I have to use spinlock for the entire owl_i2c_master_xfer
> function, so can't use sleep* for delay.
>
>> > > +       owl_i2c_update_reg(i2c_dev->base + OWL_I2C_REG_CTL,
>> > > +                               OWL_I2C_CTL_EN, true);
>> > > +
>> >
>> > > +       /* Wait 50ms for FIFO reset complete */
>> > > +       do {
>> >
>> > > +               mdelay(1);
>> >
>> > Especially in this case it's very important.
>> >
>>
>> Okay.
>
> Same here, but I'm not sure about the latency. What is your suggestion?

Look at other i2c bus drivers, check with data sheet you have, try to
refactor / redesign code that wouldn't need to sleep so long in atomic
context.


-- 
With Best Regards,
Andy Shevchenko
