From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 25 Aug 2011 16:16:34 +0100
Subject: [PATCH 3/4] mach-ux500: export System-on-Chip information ux500
	via sysfs
In-Reply-To: <201108251656.32459.arnd@arndb.de>
References: <1312981422-13294-1-git-send-email-lee.jones@linaro.org>
	<201108241810.20753.arnd@arndb.de> <4E5613F0.6030205@linaro.org>
	<201108251656.32459.arnd@arndb.de>
Message-ID: <4E566752.9010704@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Whoa, what a brilliant response. Thanks Arnd.

I think I'm going to have to take this offline with Linus.

On 25/08/11 15:56, Arnd Bergmann wrote:
> On Thursday 25 August 2011, Lee Jones wrote:
>> On 24/08/11 17:10, Arnd Bergmann wrote:
>>> On Wednesday 10 August 2011, Lee Jones wrote:
>>>> +
>>>> +static void ux500_get_soc_id(char *buf)
>>>> +{
>>>> +       void __iomem *uid_base;
>>>> +       int i;
>>>> +       ssize_t sz = 0;
>>>> +
>>>> +       if (dbx500_partnumber() == 0x8500) {
>>>> +               uid_base = __io_address(U8500_BB_UID_BASE);
>>>> +               for (i = 0; i < U8500_BB_UID_LENGTH; i++) {
>>>> +                       sz += sprintf(buf + sz, "%08x", readl(uid_base + i * sizeof(u32)));
>>>> +               }
>>>> +               return;
>>>> +       } else {
>>>> +               /* Don't know where it is located for U5500 */
>>>> +               sprintf(buf, "N/A");
>>>> +               return;
>>>> +       }
>>>> +}
>>>> +
>>>
>>> This still feels like it's hanging upside-down. You add an SOC node before you know
>>> what it is, and then attach other device to it.
>>
>> Does this comment have anything to do with the code above, or was it
>> quoted just to illustrate that we do find out what the SoC is eventually?
> 
> I should have been more elaborate here. The problem is that you try to provide
> a generic *soc*id* function for the entire ux500 platform, which already
> supports multiple SoCs and will gain support for further ones. Obviously,
> the ID is a central part of the SoC that will be different for every one,
> making it totally pointless to share the function across multiple SoCs.
> 
> Then you go further and inside that function check which soc you actually
> have and *directly* access the registers from some magic address constant.
> We spend a lot of work right now trying to get rid of those constants,
> but a lot of the time we still need them to set up platform_devices on
> platforms that don't yet use device tree probing. However, under no
> circumstances should a random function just take a hardcoded base
> address and do I/O on that.
> 
>> If I am understanding you correctly, you mean that we're registering a
>> '/sys/devices/soc/NODE', before we know what kind of SoC we're dealing
>> with and which devices it contains?
>>
>> If that is the case, I don't believe that this is an issue. If this code
>> has been reached, we know that we're dealing with an SoC, of any type
>> and we decided on a naming convention of 1, 2, 3, ..., thus making prior
>> knowledge of the type of SoC irrelevant.
>>
>> IMO, as soon as we know we're dealing with an SoC, then
>> '/sys/devices/soc' along with the first node '1' should be registered.
>> Then as we have devices appear, they should be allowed to register
>> themselves as children of that node.
>>
>> Again, please correct me if I misunderstand you.
> 
> The name is indeed irrelevant, although a name such as 'db8500' would
> arguably be more useful than a name of '1'.
> 
> Why can't you just put all db8500 specific code into the cpu-db8500.c
> file along with the other code that knows about what a db8500 looks like?
> 
>>> Similarly, having a function named 'ux500_soc_sysfs_init' is plain wrong.
>>>
>>> You don't initialize sysfs here, but you should be probing a device with a
>>> driver that happens to have a sysfs interface.
>>
>> Understood. Would something like 'ux500_export_soc_info_init' be more
>> suitable, or maybe even drop the init? It seems a little long (although
>> fully describes what we're trying to achieve) to me. Perhaps you can
>> provide a more succinct suggestion.
> 
> The problem is the idea that you separate the "info" part from the actual
> "soc" part. What I want to see is a *driver* for the soc that handles all
> aspects of the soc that are unique to the soc but not to specific
> devices inside of the soc.
> 
>>> All probing of devices in general should start at the root and then trickle
>>> down as you discover the child devices:
>>> Each board has its own init_machine() callback that knows the main devices,
>>> most importantly the SoC and registers them. When the driver for the SoC
>>> gets loaded, that driver knows what devices are present in the device and
>>> registers those recursively.
>>
>> I completely agree with you. So how does that differ to what's happening
>> here?
> 
> You currently have a single mop500_init_machine() function that tries to handle
> multiple very different boards, instead of having one init_machine function
> for each one that is actually different.
> 
>>> When you get this right, you can also eliminate the ugly machine_is_* checks
>>> in the board file.
>>
>> We can?
> 
> What you should have here is instead of 
> 
>> static void __init mop500_init_machine(void)
>> {
>>        int i2c0_devs;
>>
>>        /*
>>         * The HREFv60 board removed a GPIO expander and routed
>>         * all these GPIO pins to the internal GPIO controller
>>         * instead.
>>         */
>>        if (!machine_is_snowball()) {
>>                if (machine_is_hrefv60())
>>                        mop500_gpio_keys[0].gpio = HREFV60_PROX_SENSE_GPIO;
>>                else
>>                        mop500_gpio_keys[0].gpio = GPIO_PROX_SENSOR;
>>        }
>>
>>        u8500_init_devices();
>>
>>        mop500_pins_init();
>>        if (machine_is_snowball())
>>                platform_add_devices(snowball_platform_devs,
>>                                        ARRAY_SIZE(snowball_platform_devs));
>>        else
>>                platform_add_devices(mop500_platform_devs,
>>                                        ARRAY_SIZE(mop500_platform_devs));
> 
> just do
> 
> static void snowball_init_machine(void)
> {
> 	u8500_init_devices();
> 	snowball_pins_init();
> 	platform_add_devices(snowball_platform_devs,
>                              ARRAY_SIZE(snowball_platform_devs));
> 	...
> }
> 
> static void hrefv60_init_machine(void)
> {
> 	u8500_init_devices();
> 	hrefv60_pins_init();
> 	platform_add_devices(mop500_platform_devs,
>                              ARRAY_SIZE(mop500_platform_devs));
> 	...
> }
> 
> Everything related to the soc node should then go into the u8500_init_devices()
> function that already knows how to take care of that soc. The remaining parts
> of the init_machine just deal with the board-specific components, which can
> of course be very similar on related boards, e.g. each of the boards would
> add an ab8500 device to the external bus, if I interpret the source correctly.
> 
> 	Arnd


-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
