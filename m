From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 29 Sep 2014 16:00:48 +0800
Subject: mfd_add_devices() doesn't check whether nodes are "diabled" in dts
In-Reply-To: <20140929075332.GC7308@lee--X1>
References: <CAGsJ_4yqumj3=54HwxuzVffPjHdQZrCP2wYc2TSumKsg0-wm7w@mail.gmail.com>
 <20140929075332.GC7308@lee--X1>
Message-ID: <CAGsJ_4zz7R_f+RBvsPqbVA4nYgepuc4ffZXeueZjBOrXzfTGaw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-09-29 15:53 GMT+08:00 Lee Jones <lee.jones@linaro.org>:
> On Mon, 29 Sep 2014, Barry Song wrote:
>
>> hi Samuel, Lee,
>> the current mfd_add_devices() doesn't check whether nodes are diabled
>> in dts, so even though we put status = "disabled" in dts for a MFD
>> subnode, it will still create the platform_device. this will cause the
>> platform_driver to execute probe() entry.
>>
>> mfd-core is doing:
>>
>> mfd_add_device()
>>
>> alloc platform_device no matter it is disabled or not:
>>
>> 92         pdev = platform_device_alloc(cell->name, id + cell->id);
>>  93         if (!pdev)
>>  94                 goto fail_alloc;
>>
>> ....
>> extend all nodes:
>>
>> 112         if (parent->of_node && cell->of_compatible) {
>> 113                 for_each_child_of_node(parent->of_node, np) {
>> 114                         if (of_device_is_compatible(np,
>> cell->of_compatible)) {
>> 115                                 pdev->dev.of_node = np;
>> 116                                 break;
>> 117                         }
>> 118                 }
>> 119         }
>>
>> it seems it doesn't match with the general behavior like
>> of_platform_populate(), in which we only extend available nodes.
>>
>> how do you think if we do a fix for the behaviour of mfd_add_devices()
>> and mfd_remove_devices()?
>
> Yes, sounds good.

ok, wei will do a  follow up patch for this issue.

>
> --
> Lee Jones
> Linaro STMicroelectronics Landing Team Lead
> Linaro.org ? Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog


-barry
