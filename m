From: shunqian.zheng@gmail.com (Shunqian Zheng)
Date: Thu, 06 Aug 2015 09:10:00 +0800
Subject: [PATCH v2 0/3] Add the efuse driver on rockchip platform
In-Reply-To: <55C0E42E.3060509@linaro.org>
References: <1434439665-27781-1-git-send-email-wxt@rock-chips.com>
 <557FE3EA.4000306@i2se.com> <557FEAB2.1040101@linaro.org>
 <557FF50C.10809@rock-chips.com> <55800070.5030509@linaro.org>
 <55826D9D.2060106@i2se.com> <5582816B.5020208@linaro.org>
 <55BB3F92.9030701@gmail.com> <55C0E42E.3060509@linaro.org>
Message-ID: <55C2B3E8.2070000@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2015?08?05? 00:11, Srinivas Kandagatla wrote:
> Hi Shunqian,
>
> Sorry for delay in reply, I was on Holidays..
>
> Thanks for testing.
>
> On 31/07/15 10:27, Shunqian Zheng wrote:
>>
>> 1. Without the following diff, `hexdump
>> /sys/bus/nvmem/devices/rockchip-efuse0/nvmem` is wrong with "INVALID
>> ARGUMENT":
>>
>> +++ b/drivers/nvmem/core.c
>> @@ -67,7 +67,7 @@ static ssize_t bin_attr_nvmem_read(struct file *filp,
>> struct kobject *kobj,
>>          int rc;
>>
>>          /* Stop the user from reading */
>> -       if (pos > nvmem->size)
>> +       if (pos > nvmem->size - 1)
>>                  return 0;
>
> Yes, this should have been something like this
> -       if (pos > nvmem->size)
> +       if (pos >= nvmem->size)
>                 return 0;
>
> We can send a fix on top of v9 once its merged.
>
>>
>>          if (pos + count > nvmem->size)
>>
>> RK3288-efuse has  32 x 8bit regs, in dts "reg = <0xffb40000 0x20>;"
>> Here is the message dump from nvmem_device:
>> [    2.158314] nvmem:
>> [    2.158314]           name (null)
>> [    2.158314]           stride 1
>> [    2.158314]           word_size 1
>> [    2.158314]           ncells 0
>> [    2.158314]           id 0
>> [    2.158314]           users 0
>> [    2.158314]           size 32
>> [    2.158314]           read_only 0
>>
>> Do you think there is a leak or I'm messing up ?
>>
>> 2. About the read operation, eFuse data can be read during device
>> probe() and cached, OR,
>>      read from eFuse when needed every time. I prefer the second one but
>> then, the clock of eFuse may be
>>      gated. So before/after reading I have to enable/disable clk like :
>>            devm_clk_get(dev, "hclk_efuse256");
>>      The trouble is I can't find a way to get the "dev" hander in :
>>            static int rockchip_efuse_read(void *context, const void
>> *reg, size_t reg_size, void *val, size_t val_size)
>>      I am appreciated if you can give some advice.
>
>
> May be you should use regmap_init_mmio_clk() instead of 
> regmap_init_mmio() it will take care of clks.
Thank you for you reply.
Although the regmap_init_mmio_clk() and it's series interface deal with 
the clks, but
MMIO uses its own regmap_bus{}, while the eFuse of RK3X need special 
read/write
callback functions.

I still can't find a good way to resolve this. Can you help?

Shunqian
>
>>      Or, do you think it's reasonable to add hooks before/after read in
>> nvmem/core.c like :
>>            +       before_read(dev, ...);
>>                     rc = regmap_raw_read(nvmem->regmap, pos, buf, 
>> count);
>>            +       after_read(dev, ...);
>>
>
>
>> 3. In the /sys/bus/nvmem/devices/rockchip-efuse0/, there are files:
>>           /sys/devices/platform/ffb40000.efuse/rockchip-efuse0 # ls
>>           nvmem      of_node    power      subsystem  uevent
>>      Do you have a plan to add the nvmem consumers to /sys/ in nvmem
>> framework?
> yes, Am waiting for the framework to be merged, I have plans to add 
> this feature.
>
>>      For example,  in dts defined the "cpu_leakage":
>>          efuse: efuse at ffb40000 {
>>                  compatible = "rockchip,rk3x-efuse";
>>                  reg = <0xffb40000 0x20>;
>>                  #address-cells = <1>;
>>                  #size-cells = <1>;
>>                  clocks = <&cru PCLK_EFUSE256>;
>>                  clock-names = "pclk_efuse_256";
>>
>>                  cpu_leakage: cpu_leakage {
>>                          reg = <0x17 0x1>;
>>                  };
>>          };
>>     Then nvmem exposes the "cpu_leakage" file in /sys which can be
>> read/write.
>
> --srini
