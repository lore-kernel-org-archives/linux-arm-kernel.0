From: 21cnbao@gmail.com (Barry Song)
Date: Wed, 15 May 2013 22:42:33 +0800
Subject: [PATCH] arm: prima2: use of_platform_populate instead of
 of_platform_bus_probe
In-Reply-To: <201305151620.56677.arnd@arndb.de>
References: <1368523923-27137-1-git-send-email-Baohua.Song@csr.com>
 <201305151620.56677.arnd@arndb.de>
Message-ID: <CAGsJ_4znmN20pCe3yC57ysQve4V1L+euo_3X9Sbn6+z_Gx5tLQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/5/15 Arnd Bergmann <arnd@arndb.de>:
> On Tuesday 14 May 2013, Barry Song wrote:
>>
>> use of_platform_populate to populate platform devices, it is suitable
>> for creating devices which are children of the root node, then makes
>> things like pcm work.
>>
>> Signed-off-by: Barry Song <Baohua.Song@csr.com>
>> Signed-off-by: Rongjun Ying <Rongjun.Ying@csr.com>
>
> With 3.10-rc1 and above, you can just remove the sirfsoc_mach_init
> function entirely for the same effect.

ok.  since kernel/setup.c does:

static int __init customize_machine(void)
{
        /*
         * customizes platform devices, or adds new ones
         * On DT based machines, we fall back to populating the
         * machine from the device tree, if no callback is provided,
         * otherwise we would always need an init_machine callback.
         */
        if (machine_desc->init_machine)
                machine_desc->init_machine();
#ifdef CONFIG_OF
        else
                of_platform_populate(NULL, of_default_bus_match_table,
                                        NULL, NULL);
#endif
        return 0;
}

>
>         Arnd

-barry
