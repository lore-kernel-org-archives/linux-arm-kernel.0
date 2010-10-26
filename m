From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Tue, 26 Oct 2010 13:47:58 +0900
Subject: [PATCH 9/9] ARM: S5PV310: Add audio platform devices
In-Reply-To: <AANLkTikMG2AqmdxL7diXq9iuBK-AmgU_e4rzkekHA+td@mail.gmail.com>
References: <1288057281-25635-1-git-send-email-jassisinghbrar@gmail.com>
	<AANLkTikMG2AqmdxL7diXq9iuBK-AmgU_e4rzkekHA+td@mail.gmail.com>
Message-ID: <AANLkTimcj8i44K2xX8cW0Gm_N5WbQzs6GCBuR2Rs0Qph@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 26, 2010 at 1:21 PM, Kyungmin Park <kmpark@infradead.org> wrote:
> On Tue, Oct 26, 2010 at 10:41 AM, Jassi Brar <jassisinghbrar@gmail.com> wrote:
>> From: Jassi Brar <jassi.brar@samsung.com>
>>
>> Define platform devices for all audio devices found on S5PV310
>>
>> Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
>> ---
>> ?arch/arm/mach-s5pv310/Makefile ? ? ? ? ? ?| ? ?1 +
>> ?arch/arm/mach-s5pv310/dev-audio.c ? ? ? ? | ?364 +++++++++++++++++++++++++++++
>> ?arch/arm/mach-s5pv310/include/mach/map.h ?| ? 16 ++
>> ?arch/arm/plat-samsung/include/plat/devs.h | ? ?9 +
>> ?4 files changed, 390 insertions(+), 0 deletions(-)
>> ?create mode 100644 arch/arm/mach-s5pv310/dev-audio.c
>>
>> diff --git a/arch/arm/mach-s5pv310/Makefile b/arch/arm/mach-s5pv310/Makefile
>> index d265adb..61e3cb6 100644
>> --- a/arch/arm/mach-s5pv310/Makefile
>> +++ b/arch/arm/mach-s5pv310/Makefile
>> @@ -27,6 +27,7 @@ obj-$(CONFIG_MACH_UNIVERSAL_C210) ? ? += mach-universal_c210.o
>>
>> ?# device support
>>
>> +obj-y += dev-audio.o
> Why it's default build? could you make a config as others?

It was decided by Ben (and Mark IIRC) that most, if not all, devices use
audio and it is better to have the platform support built unconditionally.
If you see, it is same for all platforms since 64xx.

>> +static int s5pv310_cfg_i2s(struct platform_device *pdev)
>> +{
>> + ? ? ? /* configure GPIO for i2s port */
>> + ? ? ? switch (pdev->id) {
>> + ? ? ? case 0:
>> + ? ? ? ? ? ? ? s3c_gpio_cfgpin_range(S5PV310_GPZ(0), 7, S3C_GPIO_SFN(2));
> Does it default setup for i2s? In my board some pins are used for
> other purpose.
> I mean GPZ(1, 5, 6) doesn't used it for I2S.
> then how do you handle this one?
At least in the manual that I have, I2S0 is possible only on GPZ[0:6],
so if a user
does attempt to use I2S0, he/she shouldn't touch the GPIOs for any
other purpose.
Please let me know details of your board if you think there is some problem
with this setup.

>> +
>> +static struct resource s5pv310_iis0_resource[] = {
> You wrote that there are some users to use iis but c210/v310 doesn't.
> So you should use the i2s at least c210/v310 series
yes, this was simply modified from v210 so left unchanged.

>>
>> +extern struct platform_device s5pv310_device_ac97;
>> +extern struct platform_device s5pv310_device_pcm0;
>> +extern struct platform_device s5pv310_device_pcm1;
>> +extern struct platform_device s5pv310_device_pcm2;
>> +extern struct platform_device s5pv310_device_iis0;
>> +extern struct platform_device s5pv310_device_iis1;
>> +extern struct platform_device s5pv310_device_iis2;
>> +extern struct platform_device s5pv310_device_spdif;
>> +
>
> How to make common audio platform data? If not, we should list all
> samsung soc audio node in the future.

That will be done when we have some common mechanism for all
devices. There is nothing Audio specific that we can do about it.
