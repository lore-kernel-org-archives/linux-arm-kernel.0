From: aryabinin@virtuozzo.com (Andrey Ryabinin)
Date: Tue, 21 Jun 2016 19:34:03 +0300
Subject: [RFC][PATCH] arm: ubsan: select ARCH_HAS_UBSAN_SANITIZE_ALL
In-Reply-To: <3804659.HRLf903cuS@wuerfel>
References: <1466487545-22819-1-git-send-email-sw0312.kim@samsung.com>
 <12441230.VuJWJP4oWR@wuerfel> <3804659.HRLf903cuS@wuerfel>
Message-ID: <57696C7B.8050109@virtuozzo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 06/21/2016 02:44 PM, Arnd Bergmann wrote:
> On Tuesday, June 21, 2016 10:43:19 AM CEST Arnd Bergmann wrote:
>> On Tuesday, June 21, 2016 2:39:05 PM CEST Seung-Woo Kim wrote:
>>> To enable UBSAN on arm, this patch enables ARCH_HAS_UBSAN_SANITIZE_ALL
>>> from arm confiuration. Basic kernel booting is tested on arm kernel
>>> enabled CONFIG_UBSAN_SANITIZE_ALL from Exynos5422 based Odroid-XU3
>>> board.
>>>
>>> Signed-off-by: Seung-Woo Kim <sw0312.kim@samsung.com>
>>> ---
>>> Because I tested only with specific soc board, so I am not sure the ubsan is
>>> fine for all other cases. So, I send this patch as a RFC.
>>>
>>
>> I've tried this out on my build test box in the past, but ran into
>> some problems. In particular I ended up disabling 
>> -fsanitize=signed-integer-overflow and -fsanitize=object-size
>> and later reverting the whole thing, but don't remember exactly
>> why (possibly I was hitting internal compiler errors?).'
>>
>> Let me re-enable it with your patch locally and report back
>> with whatever build problems I run into.
> 
> This is what I have run into so far, during  a few dozen randconfig builds,
> this is with "arm-linux-gnueabi-gcc (GCC) 6.0.0 20160323 (experimental)"
> and I can try building a newer version if you think that helps.
> 

Unlikely newer compiler will change anything. Ubsan causes register pressure and bloats code and stack.
We could workaround most of the build errors bellow by bumping CONFIG_FRAME_WARN limit.


> I left the duplicates in to show what happens how often:
> 
> ../crypto/serpent_generic.c: In function '__serpent_setkey':
> ../crypto/serpent_generic.c:436:1: error: the frame size of 1080 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
> ../drivers/media/dvb-frontends/mb86a16.c: In function 'mb86a16_set_fe':
> ../drivers/media/dvb-frontends/mb86a16.c:1522:1: error: the frame size of 1096 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
> ../drivers/net/wireless/realtek/rtlwifi/rtl8723be/hw.c: In function '_rtl8723be_read_adapter_info.constprop':
> ../drivers/net/wireless/realtek/rtlwifi/rtl8723be/hw.c:2243:1: error: the frame size of 1032 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
> ../drivers/gpu/drm/radeon/si_dpm.c: In function 'si_init_dte_leakage_table.constprop':
> ../drivers/gpu/drm/radeon/si_dpm.c:2614:1: error: the frame size of 1096 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
> ../crypto/serpent_generic.c: In function '__serpent_setkey':
> ../crypto/serpent_generic.c:436:1: error: the frame size of 1072 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
> ../crypto/serpent_generic.c: In function '__serpent_setkey':
> ../crypto/serpent_generic.c:436:1: error: the frame size of 1072 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
> ../crypto/serpent_generic.c: In function '__serpent_setkey':
> ../crypto/serpent_generic.c:436:1: error: the frame size of 1072 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
> drivers/media/built-in.o: In function `zl10353_calc_nominal_rate':
> tea575x.c:(.text+0x1caa94): undefined reference to `____ilog2_NaN'
> tea575x.c:(.text+0x1cafc8): undefined reference to `__aeabi_uldivmod'
> tea575x.c:(.text+0x1cb02c): undefined reference to `__aeabi_uldivmod'
> tea575x.c:(.text+0x1cb09c): undefined reference to `__aeabi_uldivmod'
> tea575x.c:(.text+0x1cb2d4): undefined reference to `__aeabi_uldivmod'
> tea575x.c:(.text+0x1cb3a8): undefined reference to `__aeabi_uldivmod'
> drivers/media/built-in.o:tea575x.c:(.text+0x1cb410): more undefined references to `__aeabi_uldivmod' follow
> ../drivers/video/fbdev/aty/atyfb_base.c: In function 'aty_bl_update_status':
> ../drivers/video/fbdev/aty/atyfb_base.c:167:33: error: array subscript is above array bounds [-Werror=array-bounds]
>    return aty_ld_le32(lt_lcd_regs[index], par);
>                       ~~~~~~~~~~~^~~~~~~

This is just a bug in code. lt_lcd_regs[] has only 9 elements, while:

#define LCD_MISC_CNTL		0x14
....

aty_bl_update_status():
	unsigned int reg = aty_ld_lcd(LCD_MISC_CNTL, par);



> ../drivers/video/fbdev/aty/atyfb_base.c:152:26: error: array subscript is above array bounds [-Werror=array-bounds]
>    aty_st_le32(lt_lcd_regs[index], val, par);
> ../drivers/gpu/drm/radeon/si_dpm.c: In function 'si_init_dte_leakage_table.constprop':
> ../drivers/gpu/drm/radeon/si_dpm.c:2614:1: error: the frame size of 1096 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
> ../crypto/serpent_generic.c: In function '__serpent_setkey':
> ../crypto/serpent_generic.c:436:1: error: the frame size of 1072 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
> ../drivers/video/fbdev/aty/atyfb_base.c: In function 'aty_bl_update_status':
> ../drivers/video/fbdev/aty/atyfb_base.c:167:33: error: array subscript is above array bounds [-Werror=array-bounds]
>    return aty_ld_le32(lt_lcd_regs[index], par);
>                       ~~~~~~~~~~~^~~~~~~
> ../drivers/video/fbdev/aty/atyfb_base.c:152:26: error: array subscript is above array bounds [-Werror=array-bounds]
>    aty_st_le32(lt_lcd_regs[index], val, par);
> ../crypto/serpent_generic.c: In function '__serpent_setkey':
> ../crypto/serpent_generic.c:436:1: error: the frame size of 1080 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
> 
> 
> Some warnings go away after I turn off -fsanitize=signed-integer-overflow and
> -fsanitize=object-size, but the one in crypto/serpent_generic.c remains
> unchanged.

__serpent_setkey() bloat caused by alignment checks, i.e. -fsanitize=alignment

> 
> 	Arnd
> 
