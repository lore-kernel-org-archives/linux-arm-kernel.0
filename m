From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 25 Aug 2011 10:20:48 +0100
Subject: [PATCH 3/4] mach-ux500: export System-on-Chip information ux500
	via sysfs
In-Reply-To: <201108241810.20753.arnd@arndb.de>
References: <1312981422-13294-1-git-send-email-lee.jones@linaro.org>
	<1312981422-13294-3-git-send-email-lee.jones@linaro.org>
	<201108241810.20753.arnd@arndb.de>
Message-ID: <4E5613F0.6030205@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/08/11 17:10, Arnd Bergmann wrote:
> On Wednesday 10 August 2011, Lee Jones wrote:
>> +
>> +static void ux500_get_soc_id(char *buf)
>> +{
>> +       void __iomem *uid_base;
>> +       int i;
>> +       ssize_t sz = 0;
>> +
>> +       if (dbx500_partnumber() == 0x8500) {
>> +               uid_base = __io_address(U8500_BB_UID_BASE);
>> +               for (i = 0; i < U8500_BB_UID_LENGTH; i++) {
>> +                       sz += sprintf(buf + sz, "%08x", readl(uid_base + i * sizeof(u32)));
>> +               }
>> +               return;
>> +       } else {
>> +               /* Don't know where it is located for U5500 */
>> +               sprintf(buf, "N/A");
>> +               return;
>> +       }
>> +}
>> +
> 
> This still feels like it's hanging upside-down. You add an SOC node before you know
> what it is, and then attach other device to it.

Does this comment have anything to do with the code above, or was it
quoted just to illustrate that we do find out what the SoC is eventually?

If I am understanding you correctly, you mean that we're registering a
'/sys/devices/soc/NODE', before we know what kind of SoC we're dealing
with and which devices it contains?

If that is the case, I don't believe that this is an issue. If this code
has been reached, we know that we're dealing with an SoC, of any type
and we decided on a naming convention of 1, 2, 3, ..., thus making prior
knowledge of the type of SoC irrelevant.

IMO, as soon as we know we're dealing with an SoC, then
'/sys/devices/soc' along with the first node '1' should be registered.
Then as we have devices appear, they should be allowed to register
themselves as children of that node.

Again, please correct me if I misunderstand you.

> Similarly, having a function named 'ux500_soc_sysfs_init' is plain wrong.
> 
> You don't initialize sysfs here, but you should be probing a device with a
> driver that happens to have a sysfs interface.

Understood. Would something like 'ux500_export_soc_info_init' be more
suitable, or maybe even drop the init? It seems a little long (although
fully describes what we're trying to achieve) to me. Perhaps you can
provide a more succinct suggestion.

> All probing of devices in general should start at the root and then trickle
> down as you discover the child devices:
> Each board has its own init_machine() callback that knows the main devices,
> most importantly the SoC and registers them. When the driver for the SoC
> gets loaded, that driver knows what devices are present in the device and
> registers those recursively.

I completely agree with you. So how does that differ to what's happening
here?

> When you get this right, you can also eliminate the ugly machine_is_* checks
> in the board file.

We can?

Kind regards,
Lee


-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
