From: cedric.madianga@gmail.com (M'boumba Cedric Madianga)
Date: Thu, 12 Jan 2017 17:17:47 +0100
Subject: [PATCH v8 2/5] i2c: Add STM32F4 I2C driver
In-Reply-To: <CAOAejn2pW20VPP_yGtvJ_ufvj6Xj1poBiiA2WqkALiaLyyONug@mail.gmail.com>
References: <1483607246-14771-1-git-send-email-cedric.madianga@gmail.com>
 <1483607246-14771-3-git-send-email-cedric.madianga@gmail.com>
 <20170111082208.vzu7xgpd4eakyldl@pengutronix.de>
 <CAOAejn2eOy2sn1VkE979ne23Sj9L6+kaQDNpL1EUKb2m=6sGXw@mail.gmail.com>
 <20170111153940.dtxzvtdici3r7l54@pengutronix.de>
 <CAOAejn2pW20VPP_yGtvJ_ufvj6Xj1poBiiA2WqkALiaLyyONug@mail.gmail.com>
Message-ID: <CAOAejn1MWjW5h+EvCtt3aLPAQfndro6PhLTZTRs95VTOfRBJxQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>> > I don't understand scl_period = 1 ?s for Fast Mode. For a bus freqency
>>> > of 400 kHz we need low + high = 2.5 ?s. Is there a factor 10 missing
>>> > somewhere?
>>>
>>> As CCR = SCL_period * I2C parent clk frequency with minimal freq =
>>> 2Mhz and SCL_period = 1 we have:
>>> CCR = 1 * 2Mhz = 2.
>>> But to compute, scl_low and scl_high in Fast mode, we have to do the
>>> following thing as Duty=1:
>>> scl_high = 9 * CCR * I2C parent clk period
>>> scl_low = 16 * CCR * I2C parent clk period
>>> In our example:
>>> scl_high = 9 * 2 * 0,0000005 = 0,000009 sec = 9 ?s
>>> scl_low = 16 * 2 * 0.0000005 = 0,000016 sec = 16 ?s
>>> So low + high = 27 ?s > 2,5 ?s
>>
>> For me 9 ?s + 16 ?s is 25 ?s, resulting in 40 kHz. That's why I wondered
>> if there is a factor 10 missing somewhere.
>
> Hum ok. I am going to double-check what is wrong because when I check
> with the scope I always reach 400Khz for SCL.
> I will let you know.

There is one point I miss here that is described in the reference manual:
To reach the 400 kHz maximum I?C fast mode clock, the I2C parent rate
must be a multiple of 10 MHz.
So, contrary to what we said in a previous thread, 400 kHz could not
be reached with low frequencies.
In that way, we could compute CCR with duty = 0 by default.
So, I find another formula very close to the first one I pushed in the
first version:

In fast mode, we compute CCR with duty = 0:
t_scl_high = CCR * I2C parent clk period
t_scl_low = 2 *CCR * I2C parent clk period
So, CCR = I2C parent rate / 400 kHz / 3

For example with parent rate = 40 MHz:
CCR = 40000000 / 400000 / 3 = 33.333333333 = 33
t_scl_high = 33 * (1 / 2000000) = 825 ns > 600 ns
t_scl_low = 2 * 16 * (1 / 2000000) = 1650 ns > 1300 ns

It seems ok now.

Best regards,

Cedric
