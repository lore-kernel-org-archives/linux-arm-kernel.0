From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 27 Feb 2018 19:22:56 +0900
Subject: [RFC PATCH] drivers: use 'depends on MFD_SYSCON' instead of
 'select MFD_SYSCON'
In-Reply-To: <CAK8P3a1cEcBTiH7_gcUPZtsuRaeoOYaH3H4cYxkUBQiLMTMq=A@mail.gmail.com>
References: <1519483851-31135-1-git-send-email-yamada.masahiro@socionext.com>
 <CAK8P3a26kkcmzT450326=xHXjynG=uNYi2w07w6T+T01zQOQag@mail.gmail.com>
 <CAK7LNAT8sRDNZKbcpXY+e98O+sJHw9vUM9bKvdmVZNuEEQoMdA@mail.gmail.com>
 <CAK8P3a3zMG4wV9SWg78NGmk=BU9yq5paxZvJ=coHCWxVgNhO2w@mail.gmail.com>
 <CAK7LNAQBLTk7rduT2eQQKRhRiGTw-8MRhpz2ZJdEwKTx=-zY-Q@mail.gmail.com>
 <CAK8P3a1cEcBTiH7_gcUPZtsuRaeoOYaH3H4cYxkUBQiLMTMq=A@mail.gmail.com>
Message-ID: <CAK7LNASOzMdk_ej-U_T3_m-OtseJUOs+TqUv-BqZFLvS3e0kww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-02-27 18:03 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
> On Tue, Feb 27, 2018 at 1:46 AM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>> 2018-02-26 21:43 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
>>> On Mon, Feb 26, 2018 at 12:53 PM, Masahiro Yamada
>>> <yamada.masahiro@socionext.com> wrote:
>>>> 2018-02-26 17:43 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
>>>>> On Sat, Feb 24, 2018 at 3:50 PM, Masahiro Yamada
>>>>> <yamada.masahiro@socionext.com> wrote:
>>>>>> As Documentation/kbuild/kconfig-language.txt notes, 'select' should be
>>>>>> used with care - it forces a lower limit of another symbol, ignoring
>>>>>> the dependency.
>>>>>>
>>>>>> MFD_SYSCON depends on HAS_IOMEM, but several drivers with COMPILE_TEST
>>>>>> select it.
>>>>>>
>>>>>> This causes unmet dependencies for architecture without HAS_IOMEM.
>>>>>>
>>>>>>   $ make ARCH=score randconfig
>>>>>>   scripts/kconfig/conf  --randconfig Kconfig
>>>>>>   KCONFIG_SEED=0x27C47F43
>>>>>>   warning: (HWSPINLOCK_QCOM && AHCI_MTK && STMMAC_PLATFORM && ...)
>>>>>>   selects MFD_SYSCON which has unmet direct dependencies (HAS_IOMEM)
>>>>>>
>>>>>> Use 'depends on' to observe the dependency.
>>>>>>
>>>>>> This commit was created by the following command:
>>>>>>
>>>>>>   $ find drivers -name 'Kconfig*' | xargs sed -i -e \
>>>>>>     's/select MFD_SYSCON$/depends on MFD_SYSCON/'
>>>>>>
>>>>>> Then, COMMON_CLK_NXP and S3C2410_WATCHDOG were fixed up manually.
>>>>>>
>>>>>> Also, make MFD_SYSCON 'default y' because some defconfig files may
>>>>>> rely on someone select's MFD_SYSCON.
>>>>>>
>>>>>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>>>>>> ---
>>>>>>
>>>>>> If you have a better idea to fix 'unmet dependencies',
>>>>>> please suggest.
>>>>>
>>>>> Changing 'select MFD_SYSCON' to 'depends on' will definitely break lots
>>>>> of defconfig configurations, I'd rather not do that.
>>>>
>>>>
>>>> Could you explain why?
>>>>
>>>> I set 'default y' for MFD_SYSCON.
>>>>
>>>> Would it still break defconfig configurations?
>>>
>>> No, you are right, that would not break defconfigs, it would just mean one
>>> useless driver being enabled for many configurations that don't need it.
>>
>> If we are unhappy about this,
>> we can send per-arch patches
>> to add CONFIG_MTD_SYSCON=y to defconfigs that need it.
>>
>> But, we need to decide what the right solution is.
>
> I think for consistency, we should change the existing
> 'depends on MFD_SYSCON' to 'select MFD_SYSCON'. This
> matches what we do with REGMAP_MMIO.
>
> MFD_SYSCON is really a thin wrapper around REGMAP_MMIO,
> so I would keep using the same conventions here, even though
> we normally prefer to not 'select' any user-visible options.
>
> It might be possible to make MFD_SYSCON a silent symbol
> as well, but we'd have to make sure that all users select the symbol
> then.
>
>         Arnd


If we agree, I can send the following three patches.


[1] Add "depends on HAS_IOMEM"
    to all drivers selecting MFD_SYSCON
    (Unmet dependencies will be fixed by this)

[2] For consistency, convert existing "depends on MFD_SYSCON"
    to "select MFD_SYSCON" + "depends on HAS_IOMEM"

[3] Change MFD_SYSCON to user-unconfigurable option.
    But, for COMPILE_TEST, allow users to enable it independently.
    Like follows:

    config MFD_SYSCON
        bool "System Controller Register R/W Based on Regmap" if COMPILE_TEST
        select REGMAP_MMIO
        help
          Select this option to enable accessing system control registers
          via regmap.


Is this OK?


-- 
Best Regards
Masahiro Yamada
