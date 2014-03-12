From: xiechao.mail@gmail.com (Chao Xie)
Date: Wed, 12 Mar 2014 10:30:07 +0800
Subject: Common clock: function clock and bus clock
In-Reply-To: <CAN1soZzFfSp2Hj=JBxj+N9iLrjkm3poOa7piJDJT5BY-ycsWHQ@mail.gmail.com>
References: <CADApbej768d0z_SwSOAK8WcrxZOMMs3mFNzJ76Bewmi_-UU-PA@mail.gmail.com>
 <CAN1soZzFfSp2Hj=JBxj+N9iLrjkm3poOa7piJDJT5BY-ycsWHQ@mail.gmail.com>
Message-ID: <CADApbegGTm=REJbukdyEY9ZVK9hXax+Hodp7MFx3SUb=CV1TbA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 11, 2014 at 10:48 AM, Haojian Zhuang
<haojian.zhuang@gmail.com> wrote:
> On Tue, Mar 11, 2014 at 10:06 AM, Chao Xie <xiechao.mail@gmail.com> wrote:
>> hi
>>
>> I can not find any examples for handling function clock and bus clock
>> in drivers/clk/.
>>
>> For a device, it will have a function clock and bus clock. function
>> clock will control the fucntionality of this device, while bus clock
>> will control the communication part to the bus.
>>
>> For some SOCes, they do not export bus clock, so from the hardware it
>> seems that function clock is combined with bus clock, while for some
>> SOCes, they are not.
>>
>> For most of the device driver, they will enable/disable function clock
>> and bus clock both. While for some devices, they may share bus clock,
>> and have different function clocks.
>>
>> In fact, i want to define the APIs as below:
>>
>> struct clk* soc_register_bus_clock(struct device *dev, char **parent_name, ...);
>> This function will  create and register bus clock
>>
>> struct clk* soc_register_fucntion_clock(struct device *dev, char
>> **parent_name, ...);
>> This function will create and register function clock
>>
>> struct clk* soc_register_clk(struct device *dev, char **parent_name);
>> This function will create and register a device clock. Then this clock
>> is enable, it will enable bus clock and function clock both, and it is
>> similar for disabling.
>>
>> struct clk* soc_register_composite_clk(struct device *dev, char
>> *bus_clk_name, char *function_clk_name);
>> This function will create and register a composite device clock. When
>> enable this clock, it will invoke clk_enable(bus_clk) and
>> clk_enable(function_clk) both. It is similar for disabling.
>>
>> So for the device which has its own control register and bits for
>> function clock and bus clock. We can call  soc_register_clk.
>> For the device share bus clock with other devices, we create the clock
>> for the device by calling  soc_register_composite_clk.
>>
>> 1. Now clk_enable can be preempted by same caller.
>> 2. For above devices, the bus clock only have enable/disable ops.
>>
>> Based on above conditions, I think soc_register_composite_clk is fine.
>>
>> Does anyone have same problems? Will above proposal break common clock rules.
>
> I think it's too complex.
>
> If the bus clock and function clock is only used for gating, maybe you
> can set the bus clock as parent of function clock.
>
You can not do it. Because the function clock may have mux and div, it
can not depends on bus clock's rate.

> If both of them are complex, why not define two clocks in your device driver?
>
It is the problem. In fact for different SOCes, we can not know which
device will have such limitation.
Even for same device, for SOC-a, it has the limitation, for SOC-b, it does not.
So the choice is make all the device drivers to grap two clocks. There
are too many of them, and for
the devices does not have such limitation, it is redundant.
So the point is we donot want to change the device driver, and we want
to make the device driver interfaces
maintain unchanged. .

> Regards
> Haojian
