From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 27 Feb 2018 09:46:53 +0900
Subject: [RFC PATCH] drivers: use 'depends on MFD_SYSCON' instead of
 'select MFD_SYSCON'
In-Reply-To: <CAK8P3a3zMG4wV9SWg78NGmk=BU9yq5paxZvJ=coHCWxVgNhO2w@mail.gmail.com>
References: <1519483851-31135-1-git-send-email-yamada.masahiro@socionext.com>
 <CAK8P3a26kkcmzT450326=xHXjynG=uNYi2w07w6T+T01zQOQag@mail.gmail.com>
 <CAK7LNAT8sRDNZKbcpXY+e98O+sJHw9vUM9bKvdmVZNuEEQoMdA@mail.gmail.com>
 <CAK8P3a3zMG4wV9SWg78NGmk=BU9yq5paxZvJ=coHCWxVgNhO2w@mail.gmail.com>
Message-ID: <CAK7LNAQBLTk7rduT2eQQKRhRiGTw-8MRhpz2ZJdEwKTx=-zY-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-02-26 21:43 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
> On Mon, Feb 26, 2018 at 12:53 PM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>> 2018-02-26 17:43 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
>>> On Sat, Feb 24, 2018 at 3:50 PM, Masahiro Yamada
>>> <yamada.masahiro@socionext.com> wrote:
>>>> As Documentation/kbuild/kconfig-language.txt notes, 'select' should be
>>>> used with care - it forces a lower limit of another symbol, ignoring
>>>> the dependency.
>>>>
>>>> MFD_SYSCON depends on HAS_IOMEM, but several drivers with COMPILE_TEST
>>>> select it.
>>>>
>>>> This causes unmet dependencies for architecture without HAS_IOMEM.
>>>>
>>>>   $ make ARCH=score randconfig
>>>>   scripts/kconfig/conf  --randconfig Kconfig
>>>>   KCONFIG_SEED=0x27C47F43
>>>>   warning: (HWSPINLOCK_QCOM && AHCI_MTK && STMMAC_PLATFORM && ...)
>>>>   selects MFD_SYSCON which has unmet direct dependencies (HAS_IOMEM)
>>>>
>>>> Use 'depends on' to observe the dependency.
>>>>
>>>> This commit was created by the following command:
>>>>
>>>>   $ find drivers -name 'Kconfig*' | xargs sed -i -e \
>>>>     's/select MFD_SYSCON$/depends on MFD_SYSCON/'
>>>>
>>>> Then, COMMON_CLK_NXP and S3C2410_WATCHDOG were fixed up manually.
>>>>
>>>> Also, make MFD_SYSCON 'default y' because some defconfig files may
>>>> rely on someone select's MFD_SYSCON.
>>>>
>>>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>>>> ---
>>>>
>>>> If you have a better idea to fix 'unmet dependencies',
>>>> please suggest.
>>>
>>> Changing 'select MFD_SYSCON' to 'depends on' will definitely break lots
>>> of defconfig configurations, I'd rather not do that.
>>
>>
>> Could you explain why?
>>
>> I set 'default y' for MFD_SYSCON.
>>
>> Would it still break defconfig configurations?
>
> No, you are right, that would not break defconfigs, it would just mean one
> useless driver being enabled for many configurations that don't need it.

If we are unhappy about this,
we can send per-arch patches
to add CONFIG_MTD_SYSCON=y to defconfigs that need it.

But, we need to decide what the right solution is.


>>> Only score, tile and um have some configurations that select 'NO_IOMEM'.
>>> Score is getting removed now, tile might get removed later (we could make
>>> PCI mandatory in the meantime to avoid that configuration), and I think for
>>> um, we already have a workaround for the NO_IOMEM dependencies
>>> (I forget the details).
>>
>> I do not think this is a stable solution.
>>
>> Or, do you mean to remove NO_IOMEM and HAS_IOMEM completely?
>
> We could either leave it for arch/um only and have that deal with the
> issues (which I think we already have), or we could remove the options
> entirely.
>
>       Arnd
> --
> To unsubscribe from this list: send the line "unsubscribe linux-clk" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
