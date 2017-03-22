From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 22 Mar 2017 12:47:38 +0100
Subject: [PATCH 2/6] pinctrl: armada-37xx: Add pin controller support for
 Armada 37xx
In-Reply-To: <CACRpkdbnfkb8tDtjzbQdhg8JxV1S5FdFjPx7B8NAT+nkeUO=Lw@mail.gmail.com>
 (Linus Walleij's message of "Fri, 30 Dec 2016 09:44:49 +0100")
References: <20161222172501.16121-1-gregory.clement@free-electrons.com>
 <20161222172501.16121-3-gregory.clement@free-electrons.com>
 <CACRpkdbnfkb8tDtjzbQdhg8JxV1S5FdFjPx7B8NAT+nkeUO=Lw@mail.gmail.com>
Message-ID: <878tnxfs85.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,
 
 On ven., d?c. 30 2016, Linus Walleij <linus.walleij@linaro.org> wrote:

> On Thu, Dec 22, 2016 at 6:24 PM, Gregory CLEMENT
> <gregory.clement@free-electrons.com> wrote:
>
>> The Armada 37xx SoC come with 2 pin controllers: one on the south
>> bridge (managing 28 pins) and one on the north bridge (managing 36 pins).
>>
>> At the hardware level the controller configure the pins by group and not
>> pin by pin. This constraint is reflected in the design of the driver:
>> only the group related functions are implemented.
>>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>
> Overall this looks good.
>
>> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
>> index 715ef1256838..0786e3e0f5c6 100644
>> --- a/arch/arm64/Kconfig.platforms
>> +++ b/arch/arm64/Kconfig.platforms
>> @@ -105,6 +105,8 @@ config ARCH_MVEBU
>>         select ARMADA_37XX_CLK
>>         select MVEBU_ODMI
>>         select MVEBU_PIC
>> +       select PINCTRL
>> +       select PINCTRL_ARMADA_37XX
>
> Do you already select MFD_SYSCON? It seems to be required.

I added the dependency

>
> I can't merge patches to ARM SoC and prefer not to. Split this into a separate
> patch for ARM SoC in the Armada/Marvell tree.
>
>> -obj-$(CONFIG_PINCTRL_MVEBU)    += mvebu/
>> +obj-y                          += mvebu/
>

Done it was split.

> Just make sure everything is guarded with proper symbols.

I checked it.

>
>> +struct armada_37xx_pin_group {
>> +       const char      *name;
>> +       unsigned int    start_pin;
>> +       unsigned int    npins;
>> +       u32             reg_mask;
>> +       unsigned int    extra_pin;
>> +       unsigned int    extra_npins;
>> +       const char      *funcs[NB_FUNCS];
>> +       unsigned int    *pins;
>> +};
>
> I would prefer if you add some kerneldoc to this struct.
> Especially the extra_pin things are not evident so explain this
> in detail here.

done.

>> +static int armada_37xx_pin_config_group_get(struct pinctrl_dev *pctldev,
>> +                           unsigned int selector, unsigned long *config)
>> +{
>> +       return -ENOTSUPP;
>> +}
>> +
>> +static int armada_37xx_pin_config_group_set(struct pinctrl_dev *pctldev,
>> +                           unsigned int selector, unsigned long *configs,
>> +                           unsigned int num_configs)
>> +{
>> +       return -ENOTSUPP;
>> +}
>> +
>> +static struct pinconf_ops armada_37xx_pinconf_ops = {
>> +       .is_generic = true,
>> +       .pin_config_group_get = armada_37xx_pin_config_group_get,
>> +       .pin_config_group_set = armada_37xx_pin_config_group_set,
>> +};
>
> Don't we support just leaving group set/get uninitialized? Too bad in that case.
>

I am not sure to follow you here. On this controller some of the pin
cannot be configured individually but only inside a group. That's why I
set this function not supported. Did I miss something?

>> +static int _add_function(struct armada_37xx_pmx_func *funcs, int *funcsize,
>> +                        const char *name)
>
> No _foo opaque underscore prefix please. Git this a reasonable name
> like armada_37xx_add_function() or so.

OK done

>
> Apart from that it looks good.

Thanks,

Gregory
-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
