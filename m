From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 27 Feb 2018 14:39:11 +0100
Subject: [RFC PATCH] drivers: use 'depends on MFD_SYSCON' instead of
 'select MFD_SYSCON'
In-Reply-To: <CAK7LNASOzMdk_ej-U_T3_m-OtseJUOs+TqUv-BqZFLvS3e0kww@mail.gmail.com>
References: <1519483851-31135-1-git-send-email-yamada.masahiro@socionext.com>
 <CAK8P3a26kkcmzT450326=xHXjynG=uNYi2w07w6T+T01zQOQag@mail.gmail.com>
 <CAK7LNAT8sRDNZKbcpXY+e98O+sJHw9vUM9bKvdmVZNuEEQoMdA@mail.gmail.com>
 <CAK8P3a3zMG4wV9SWg78NGmk=BU9yq5paxZvJ=coHCWxVgNhO2w@mail.gmail.com>
 <CAK7LNAQBLTk7rduT2eQQKRhRiGTw-8MRhpz2ZJdEwKTx=-zY-Q@mail.gmail.com>
 <CAK8P3a1cEcBTiH7_gcUPZtsuRaeoOYaH3H4cYxkUBQiLMTMq=A@mail.gmail.com>
 <CAK7LNASOzMdk_ej-U_T3_m-OtseJUOs+TqUv-BqZFLvS3e0kww@mail.gmail.com>
Message-ID: <CAK8P3a2t9a=qzSpxSQ7j5r20i_cR2G=kAZE9amT2fFypU0whzw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 27, 2018 at 11:22 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> 2018-02-27 18:03 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
>> On Tue, Feb 27, 2018 at 1:46 AM, Masahiro Yamada
>> <yamada.masahiro@socionext.com> wrote:
>>> But, we need to decide what the right solution is.
>>
>> I think for consistency, we should change the existing
>> 'depends on MFD_SYSCON' to 'select MFD_SYSCON'. This
>> matches what we do with REGMAP_MMIO.
>>
>> MFD_SYSCON is really a thin wrapper around REGMAP_MMIO,
>> so I would keep using the same conventions here, even though
>> we normally prefer to not 'select' any user-visible options.
>>
>> It might be possible to make MFD_SYSCON a silent symbol
>> as well, but we'd have to make sure that all users select the symbol
>> then.
>>
>>         Arnd
>
>
> If we agree, I can send the following three patches.
>
>
> [1] Add "depends on HAS_IOMEM"
>     to all drivers selecting MFD_SYSCON
>     (Unmet dependencies will be fixed by this)
>
> [2] For consistency, convert existing "depends on MFD_SYSCON"
>     to "select MFD_SYSCON" + "depends on HAS_IOMEM"

Those sound good.

> [3] Change MFD_SYSCON to user-unconfigurable option.
>     But, for COMPILE_TEST, allow users to enable it independently.
>     Like follows:
>
>     config MFD_SYSCON
>         bool "System Controller Register R/W Based on Regmap" if COMPILE_TEST
>         select REGMAP_MMIO
>         help
>           Select this option to enable accessing system control registers
>           via regmap.
>
>
> Is this OK?

I'm unsure about the third one, since we have drivers that can optionally
use syscon, depending on the platform. With this change, any user that
manually enabled syscon to use that with a driver that requires it on their
platform but not on others will see a regression.

If we do make MFD_SYSCON a silent option like that, we should remove
the #else section in include/linux/mfd/syscon.h to force a build error,
and require all drivers to 'select MFD_SYSCON' if they are able to use it.

       Arnd
