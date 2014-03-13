From: emilio@elopez.com.ar (=?UTF-8?B?RW1pbGlvIEzDs3Bleg==?=)
Date: Thu, 13 Mar 2014 00:16:35 -0300
Subject: Common clock: function clock and bus clock
In-Reply-To: <CADApbeh0zjd=qMguiqQGrn=0v+-SVqgnyL=Gk8D9MiQvHU2XGA@mail.gmail.com>
References: <CADApbej768d0z_SwSOAK8WcrxZOMMs3mFNzJ76Bewmi_-UU-PA@mail.gmail.com>
 <CAN1soZzFfSp2Hj=JBxj+N9iLrjkm3poOa7piJDJT5BY-ycsWHQ@mail.gmail.com>
 <CADApbegGTm=REJbukdyEY9ZVK9hXax+Hodp7MFx3SUb=CV1TbA@mail.gmail.com>
 <5320336B.3020107@ti.com>
 <CADApbeh0zjd=qMguiqQGrn=0v+-SVqgnyL=Gk8D9MiQvHU2XGA@mail.gmail.com>
Message-ID: <53212313.9040305@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

El mi? 12 mar 2014 23:15:20 ART, Chao Xie escribi?:
> On Wed, Mar 12, 2014 at 6:14 PM, Grygorii Strashko
> <grygorii.strashko@ti.com> wrote:
>> On 03/12/2014 04:30 AM, Chao Xie wrote:
>>>
>>> On Tue, Mar 11, 2014 at 10:48 AM, Haojian Zhuang
>>> <haojian.zhuang@gmail.com> wrote:
>>>>
>>>> On Tue, Mar 11, 2014 at 10:06 AM, Chao Xie <xiechao.mail@gmail.com>
>>>> wrote:
>>>>>
>>>>> hi
>>>>>
>>>>> I can not find any examples for handling function clock and bus clock
>>>>> in drivers/clk/.
>>>>>
>>>>> For a device, it will have a function clock and bus clock. function
>>>>> clock will control the fucntionality of this device, while bus clock
>>>>> will control the communication part to the bus.
>>>>>
>>>>> For some SOCes, they do not export bus clock, so from the hardware it
>>>>> seems that function clock is combined with bus clock, while for some
>>>>> SOCes, they are not.
>>>>>
>>>>> For most of the device driver, they will enable/disable function clock
>>>>> and bus clock both. While for some devices, they may share bus clock,
>>>>> and have different function clocks.

You can define two normal clocks and use them like this

* If a device has both bus and module

clocks = <&abc ...>, <&xyz ...>;
clock-names = "bus", "module";

* If a device only has module clock

clocks = <&xyz ...>;
clock-names = "module";

Then on the driver to control this specific hardware you can do 
something like

/* mandatory module clock */
mod = devm_clk_get(dev, "module");
if (!IS_ERR(mod))
	clk_prepare_enable(mod)
else
	goto fail;	

/* optional bus clock */
bus = devm_clk_get(dev, "bus");
if (!IS_ERR(bus))
	clk_prepare_enable(bus)


The framework keeps count of how many times clocks have been enabled, so 
as long as a device needs the bus clock, it will remain operational.

You can find many examples of this pattern with

$ grep 'clock-names.*ahb' arch/arm/boot/dts/*dts*

Cheers,

Emilio
