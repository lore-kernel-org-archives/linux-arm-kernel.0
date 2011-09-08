From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Thu, 8 Sep 2011 09:16:46 +0530
Subject: [PATCH 1/2] input: samsung-keypad: Add HAVE_SAMSUNG_KEYPAD config
	option
In-Reply-To: <20110907182248.GA2874@core.coreip.homeip.net>
References: <1315317317-21873-1-git-send-email-thomas.abraham@linaro.org>
	<1315317317-21873-2-git-send-email-thomas.abraham@linaro.org>
	<20110907182248.GA2874@core.coreip.homeip.net>
Message-ID: <CAJuYYwQg8pMaM7Y-AQD5eDqw32rMOHggL2gWOtJH_ri8gsH-yg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dmitry,

On 7 September 2011 23:52, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> Hi Thomas,
>
> On Tue, Sep 06, 2011 at 07:25:16PM +0530, Thomas Abraham wrote:
>> Samsung keyboard driver could be used with platforms using device tree.
>> So the inclusion of samsung keyboard driver cannot be based on
>> SAMSUNG_DEV_KEYPAD. A new config option HAVE_SAMSUNG_KEYPAD is added
>> which device tree based platforms should use to include samsung keyboard
>> driver.
>
> I am sorry, I do not follow... What is the difference between
> SAMSUNG_DEV_KEYPAD and HAVE_SAMSUNG_KEYPAD? They look exactly the same.

The inclusion of platform device instance for keypad (in
arch/arm/plat-samsung/dev-keypad.c) in the build depends on
SAMSUNG_DEV_KEYPAD. The samsung-keypad driver is also dependent on
SAMSUNG_DEV_KEYPAD.

In case of device tree based instantiation of keypad, compilation of
dev-keypad.c file is not required. So SAMSUNG_DEV_KEYPAD config option
will not be selected.In that case, the compilation of the keypad
driver cannot be dependent on SAMSUNG_DEV_KEYPAD. There should be
another option to select the keypad driver and so HAVE_SAMSUNG_KEYPAD
was introduced. HAVE_SAMSUNG_KEYPAD can be selected on platforms that
need the samsung-keypad driver but do no need the keypad platform
device.

Thanks for your review and comments.

Regards,
Thomas.

>
> Thanks,
>
>>
>> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
>> ---
>> ?drivers/input/keyboard/Kconfig | ? ?9 ++++++++-
>> ?1 files changed, 8 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
>> index b4dee9d..370fb18 100644
>> --- a/drivers/input/keyboard/Kconfig
>> +++ b/drivers/input/keyboard/Kconfig
>> @@ -423,9 +423,16 @@ config KEYBOARD_PMIC8XXX
>> ? ? ? ? To compile this driver as a module, choose M here: the module will
>> ? ? ? ? be called pmic8xxx-keypad.
>>
>> +config HAVE_SAMSUNG_KEYPAD
>> + ? ? bool
>> + ? ? help
>> + ? ? ? This will include Samsung Keypad controller driver support. If you
>> + ? ? ? want to include Samsung Keypad support for any machine, kindly
>> + ? ? ? select this in the respective mach-xxxx/Kconfig file.
>> +
>> ?config KEYBOARD_SAMSUNG
>> ? ? ? tristate "Samsung keypad support"
>> - ? ? depends on SAMSUNG_DEV_KEYPAD
>> + ? ? depends on SAMSUNG_DEV_KEYPAD || HAVE_SAMSUNG_KEYPAD
>> ? ? ? help
>> ? ? ? ? Say Y here if you want to use the Samsung keypad.
>>
>> --
>> 1.6.6.rc2
>>
>
> --
> Dmitry
>
