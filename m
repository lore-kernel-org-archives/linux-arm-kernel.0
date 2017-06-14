From: hoegeun.kwon@samsung.com (Hoegeun Kwon)
Date: Wed, 14 Jun 2017 16:19:59 +0900
Subject: [PATCH 2/3] drm/panel: Add support for s6e63j0x03 panel driver
In-Reply-To: <04f1d0f1-0010-d21a-1d02-e4e5f9440e56@samsung.com>
References: <1496984354-5271-1-git-send-email-hoegeun.kwon@samsung.com>
 <CGME20170609045938epcas5p216c0ff705d60a32ee57ecb55de9233b5@epcas5p2.samsung.com>
 <1496984354-5271-3-git-send-email-hoegeun.kwon@samsung.com>
 <04f1d0f1-0010-d21a-1d02-e4e5f9440e56@samsung.com>
Message-ID: <d87f4fcc-ad22-cd21-d6c5-a5ef1a5a8ab0@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrzej,

Thanks for your review.

On 06/12/2017 10:16 PM, Andrzej Hajda wrote:
> Hi Hoegeun,
>
> Nice to see patches completing support for mainlined platforms.
>
> On 09.06.2017 06:59, Hoegeun Kwon wrote:
>> This patch adds MIPI-DSI based S6E63J0X03 AMOLED LCD panel driver
>> which uses mipi_dsi bus to communicate with panel. The panel has
>> 320?320 resolution in 1.63" physical panel. This panel is used in
>> Samsung Galaxy Gear 2.
>>
>> Signed-off-by: Inki Dae <inki.dae@samsung.com>
>> Signed-off-by: Hyungwon Hwang <human.hwang@samsung.com>
>> Signed-off-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
>> ---
>>   drivers/gpu/drm/panel/Kconfig                    |   7 +
>>   drivers/gpu/drm/panel/Makefile                   |   1 +
>>   drivers/gpu/drm/panel/panel-samsung-s6e63j0x03.c | 491 +++++++++++++++++++++++
>>   3 files changed, 499 insertions(+)
>>   create mode 100644 drivers/gpu/drm/panel/panel-samsung-s6e63j0x03.c
>>
>>

...

>> +
>> +static int s6e63j0x03_enable(struct drm_panel *panel)
>> +{
>> +	struct s6e63j0x03 *ctx = panel_to_s6e63j0x03(panel);
>> +	struct backlight_device *bl_dev = ctx->bl_dev;
>> +	u8 seq[] = { MIPI_DCS_SET_DISPLAY_ON };
>> +	int ret;
>> +
>> +	ret = s6e63j0x03_dcs_write_seq(ctx, seq, ARRAY_SIZE(seq));
>> +	if (ret > 0)
>> +		bl_dev->props.power = FB_BLANK_UNBLANK;
>> +
>> +	return 0;
>> +}
> For many (maybe most) panels power on sequence is as follows:
> 0. Enable power supplies and gpios.
> 1. Initialization, including MIPI_DCS_EXIT_SLEEP_MODE
> 2. Wait for 120ms, to avoid display glitches.
> 3. Unblanking and adjusting display, including MIPI_DCS_SET_DISPLAY_ON.
>
> And power-off:
> 4. MIPI_DCS_SET_DISPLAY_OFF
> 5. MIPI_DCS_ENTER_SLEEP_MODE
> 6. Wait for 120ms
> 7. Disable power supplies and gpios.
>
> I suppose waiting for 120ms is a good indicator what should be put into
> prepare/enable/disable/unprepare phase.
> In my opinion it should be as follows:
> Prepare: 0, 1
> Enable: 2, 3
> Disable: 4,5,6
> Unprepare: 7
>
> What do you think about it?
> Could you arrange the code this way and test if it works correctly?
> Maybe you/other developers have some opinions about it?

I agree with you.
I will send ver2 patch with the above style.
And modify it to use as mipi_dsi_dcs_*.

>> +
>> +static const struct drm_display_mode default_mode = {
>> +	.clock = 4644,
>> +	.hdisplay = 320,
>> +	.hsync_start = 320 + 1,
>> +	.hsync_end = 320 + 1 + 1,
>> +	.htotal = 320 + 1 + 1 + 1,
>> +	.vdisplay = 320,
>> +	.vsync_start = 320 + 150,
>> +	.vsync_end = 320 + 150 + 1,
>> +	.vtotal = 320 + 150 + 1 + 2,
>> +	.vrefresh = 30,
>> +	.flags = 0,
>> +};
> clock should be equal vtotal*htotal*vrefresh, it is little higher? what
> is the reason?
> What is actual refresh rate?

The actual refresh rate is 30.43Hz
So I will modfiy the clock Hz to 4649.

((323 * 473 )* 30.43) / 1000 = 4649

Best regards,
Hoegeun
