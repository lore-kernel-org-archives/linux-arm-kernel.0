From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 15 Sep 2013 11:24:33 +0200
Subject: [PATCH] ARM: tegra: throw the unique chip ID into the entropy pool
In-Reply-To: <52333E56.8060204@wwwdotorg.org>
References: <1378394938-1551-1-git-send-email-linus.walleij@linaro.org>
 <52333E56.8060204@wwwdotorg.org>
Message-ID: <CACRpkdYTD4i74U-pAY1eq6FXiBwh-sw9U4N5PobBmpSKiTEVwA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 13, 2013 at 6:33 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 09/05/2013 09:28 AM, Linus Walleij wrote:
>> This adds a hook at common late init to extract the 64 bits of
>> chip-unique data and throw it into the entropy pool to make it
>> more device-unique.
>
>> diff --git a/arch/arm/mach-tegra/common.c b/arch/arm/mach-tegra/common.c
>
>>  void __init tegra_init_late(void)
>>  {
>> +     tegra_random_init();
>
> Looking at this further, there's already a tegra_init_fuse() call made
> from tegra_init_early(), so rather than adding a second init function
> into the fuse code, I'd rather just augment that function, unless
> there's some reason add_device_randomness() won't work at that time?

This seems to be possible, due to the comment above
rand_initialize():

/*
 * Note that setup_arch() may call add_device_randomness()
 * long before we get here. This allows seeding of the pools
 * with some platform dependent data very early in the boot
 * process.
(...)

> If that will work, I'll supply an alternate patch that replaces this,
> since I also want to remove the tegra_chip_uid() function, and need to
> make the add_device_randomness() call not use tegra_chip_uid() on
> Tegra30 or later, since the set of fuses for the chip ID changed radically.

Sure, go ahead.

Yours,
Linus Walleij
