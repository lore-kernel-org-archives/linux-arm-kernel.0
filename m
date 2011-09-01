From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 1 Sep 2011 23:51:05 +0200
Subject: [PATCH] mach-ux500: unlock I&D l2x0 caches before init
In-Reply-To: <4E5F94C6.7020609@gmail.com>
References: <1314870093-5758-1-git-send-email-linus.walleij@stericsson.com>
	<4E5F94C6.7020609@gmail.com>
Message-ID: <CAKnu2Mrvf_CuTp0M2xn4jk_Q=cFwU+5_hMRUD4aX9tMRmPq=Mw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/9/1 Rob Herring <robherring2@gmail.com>:
> [Me]
>> Apparently U8500 U-Boot versions may leave the l2x0 locked down
>> before executing the kernel. Make sure we unlock it before we
>> initialize the l2x0. This fixes a performance problem reported
>> by Jan Rinze.
>
> Just when you think a bootloader wouldn't muck with something like this...
>
> I'll ask the obvious question: As this is u-boot, can't this be fixed in
> u-boot?

As in so many other countless examples found on the ARM
mailing list, this is sadly yet another case where there are
deployed U-boot images all over the planet doing this, and
people don't like to change them.

>> + ? ? /*
>> + ? ? ?* Unlock Data and Instruction Lock if locked. Ux500 U-Boot versions
>> + ? ? ?* apparently locks both caches before jumping to the kernel.
>> + ? ? ?*/
>> + ? ? if (readl_relaxed(l2x0_base + L2X0_LOCKDOWN_WAY_D) & 0xFF)
>> + ? ? ? ? ? ? writel_relaxed(0x0, l2x0_base + L2X0_LOCKDOWN_WAY_D);
>> +
>> + ? ? if (readl_relaxed(l2x0_base + L2X0_LOCKDOWN_WAY_I) & 0xFF)
>> + ? ? ? ? ? ? writel_relaxed(0x0, l2x0_base + L2X0_LOCKDOWN_WAY_I);
>
> Do you really need to read the register first?
>
> Can't this just be done unconditionally in l2x0_init for everyone. I
> doubt anyone wants to lock down ways. You would need to adjust for
> 16-way support.

Good question.

Catalin, how do you feel about disabling D&I locks in l2x0_init()?

Yours,
Linus Walleij
