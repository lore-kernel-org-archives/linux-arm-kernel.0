From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Thu, 13 Mar 2014 13:30:43 +0200
Subject: Common clock: function clock and bus clock
In-Reply-To: <53212313.9040305@elopez.com.ar>
References: <CADApbej768d0z_SwSOAK8WcrxZOMMs3mFNzJ76Bewmi_-UU-PA@mail.gmail.com>
 <CAN1soZzFfSp2Hj=JBxj+N9iLrjkm3poOa7piJDJT5BY-ycsWHQ@mail.gmail.com>
 <CADApbegGTm=REJbukdyEY9ZVK9hXax+Hodp7MFx3SUb=CV1TbA@mail.gmail.com>
 <5320336B.3020107@ti.com>
 <CADApbeh0zjd=qMguiqQGrn=0v+-SVqgnyL=Gk8D9MiQvHU2XGA@mail.gmail.com>
 <53212313.9040305@elopez.com.ar>
Message-ID: <532196E3.1060408@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/13/2014 05:16 AM, Emilio L?pez wrote:
> Hi,
> 
> El mi? 12 mar 2014 23:15:20 ART, Chao Xie escribi?:
>> On Wed, Mar 12, 2014 at 6:14 PM, Grygorii Strashko
>> <grygorii.strashko@ti.com> wrote:
>>> On 03/12/2014 04:30 AM, Chao Xie wrote:
>>>>
>>>> On Tue, Mar 11, 2014 at 10:48 AM, Haojian Zhuang
>>>> <haojian.zhuang@gmail.com> wrote:
>>>>>
>>>>> On Tue, Mar 11, 2014 at 10:06 AM, Chao Xie <xiechao.mail@gmail.com>
>>>>> wrote:
>>>>>>
>>>>>> hi
>>>>>>
>>>>>> I can not find any examples for handling function clock and bus clock
>>>>>> in drivers/clk/.
>>>>>>
>>>>>> For a device, it will have a function clock and bus clock. function
>>>>>> clock will control the fucntionality of this device, while bus clock
>>>>>> will control the communication part to the bus.
>>>>>>
>>>>>> For some SOCes, they do not export bus clock, so from the hardware it
>>>>>> seems that function clock is combined with bus clock, while for some
>>>>>> SOCes, they are not.
>>>>>>
>>>>>> For most of the device driver, they will enable/disable function 
>>>>>> clock
>>>>>> and bus clock both. While for some devices, they may share bus clock,
>>>>>> and have different function clocks.
> 
> You can define two normal clocks and use them like this
> 
> * If a device has both bus and module
> 
> clocks = <&abc ...>, <&xyz ...>;
> clock-names = "bus", "module";
> 
> * If a device only has module clock
> 
> clocks = <&xyz ...>;
> clock-names = "module";
> 
> Then on the driver to control this specific hardware you can do 
> something like
> 
> /* mandatory module clock */
> mod = devm_clk_get(dev, "module");
> if (!IS_ERR(mod))
>      clk_prepare_enable(mod)
> else
>      goto fail;
> 
> /* optional bus clock */
> bus = devm_clk_get(dev, "bus");
> if (!IS_ERR(bus))
>      clk_prepare_enable(bus)
> 

That what exactly Clock PM domain is doing :)

In Davinci it is defined as:
static struct pm_clk_notifier_block platform_bus_notifier = {
	.pm_domain = &davinci_pm_domain,
	.con_ids = { "fck", "master", "slave", NULL },
};

When device is created the Clk PM domain core (clock_ops.c) recollects all clocks
specified for device (in DT or in clkdev tables) by their names (DT) or con_id (clkdev).
One device can specify clocks: "master", "slave"
and another only "fck".

Then in driver you need only do:
 pm_runtime_enable(dev);
 error = pm_runtime_get_sync(dev);
 ^ all clocks assigned to the device will be enabled

...
 error = pm_runtime_put_sync(dev);
 ^ all clocks assigned to the device will be disabled


Regards,
- grygorii
