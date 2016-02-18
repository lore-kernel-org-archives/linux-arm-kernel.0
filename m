From: carlo@endlessm.com (Carlo Caione)
Date: Thu, 18 Feb 2016 13:24:09 +0100
Subject: [PATCH 1/2] ARM: meson: Adding support to retrieve serial and SoC
 revision
In-Reply-To: <CABgxDoKOUd_k4kmrcswnUCaKAN8KQ11f8dUTMXDisySp_SVcMA@mail.gmail.com>
References: <1455730114-2547-1-git-send-email-romain.perier@gmail.com>
 <1455730114-2547-2-git-send-email-romain.perier@gmail.com>
 <CAOQ7t2b8N+w33zKMfedtQqJ+-u1=kGn0pK4cBXhXB8LGx6qrtQ@mail.gmail.com>
 <CABgxDoKOUd_k4kmrcswnUCaKAN8KQ11f8dUTMXDisySp_SVcMA@mail.gmail.com>
Message-ID: <CAL9uMOHLDtQa7dMJm+7VpVJSRJJ+xoG_-Nx1VpJ7S1sL8TS5bw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 18, 2016 at 1:20 PM, Romain Perier <romain.perier@gmail.com> wrote:
> Hi all,

[cut]

>>> +static void __init meson_init_machine(void)
>>> +{
>>> +       struct soc_device_attribute *soc_dev_attr;
>>> +       struct soc_device *soc_dev;
>>> +       struct regmap *hwrev;
>>> +       unsigned int val;
>>> +       int ret;
>>> +
>>> +       hwrev = syscon_regmap_lookup_by_compatible("amlogic,meson8b-hwrev");
>>
>> Is this specific only for Meson8b?
>
>
> For now, yes. However, As I said, I can to do something generic. What
> do you think ?

my guess is that it works fine for meson8 and meson8b. Not sure about
meson6. You should take a look to the Amlogic SDK to confirm that or
just exclude meson6.
I was actually referring to the name of the compatible that seems a
bit too specific to me.

>>
>>> +               return;
>>> +       }
>>> +       system_rev = val == 0x11111111 ? 0xA : 0xB;
>>> +
>>> +       soc_dev_attr->family = "Amlogic Meson";
>>> +       soc_dev_attr->revision = kasprintf(GFP_KERNEL, "0x%x", system_rev);
>>> +       soc_dev_attr->soc_id = kasprintf(GFP_KERNEL, "0x%x", system_serial_high);
>>> +
>>> +       soc_dev = soc_device_register(soc_dev_attr);
>>> +       if (IS_ERR(soc_dev)) {
>>> +               pr_err("Could not register soc device\n");
>>> +               kfree(soc_dev_attr);
>>
>> leaking soc_dev_attr->revision and  soc_dev_attr->soc_id also any
>> reason why you are not kasprintf-ing also family?
>>
>
> My problem is that I cannot use a devm allocation there, right ? I
> mean I have no device... Well, I will think about it.

I mean: you are kfree-ing soc_dev_attr but not soc_dev_attr->revision
and soc_dev_attr->soc_id

>>> +               return;
>>> +       }
>>> +
>>> +       pr_info("Amlogic Meson SoC Rev%X (%X:%X)\n", system_rev, system_serial_high, system_rev);
>>> +       of_platform_populate(NULL, of_default_bus_match_table, NULL, soc_dev);
>>
>> Compiling I got:
>>
>>   CC      arch/arm/mach-meson/meson.o
>> arch/arm/mach-meson/meson.c: In function 'meson_init_machine':
>> arch/arm/mach-meson/meson.c:77:63: warning: passing argument 4 of
>> 'of_platform_populate' from incompatible pointer type
>>   of_platform_populate(NULL, of_default_bus_match_table, NULL, soc_dev);
>>                                                                ^
>> In file included from arch/arm/mach-meson/meson.c:17:0:
>> include/linux/of_platform.h:71:12: note: expected 'struct device *'
>> but argument is of type 'struct soc_device *'
>>  extern int of_platform_populate(struct device_node *root,
>>             ^
>>
>
> Ah, good catch ! I build everything using yocto, so I did not see
> these warnings ^^

Please, do not use yocto for this ;)

Cheers,

-- 
Carlo Caione  |  +39.340.80.30.096  |  Endless
