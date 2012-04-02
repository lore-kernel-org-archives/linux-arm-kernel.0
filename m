From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Mon, 2 Apr 2012 17:38:01 +0800
Subject: [PATCH V3 3/4] Input: pxa27x_keypad direct key may be low active
In-Reply-To: <1333246084-14110-3-git-send-email-chao.xie@marvell.com>
References: <1333246084-14110-1-git-send-email-chao.xie@marvell.com>
 <1333246084-14110-3-git-send-email-chao.xie@marvell.com>
Message-ID: <CAN1soZzcW6Oy_vd3U_WYy9RNL1BLDfG+NpWKg1HUfQDD0eJAUQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 1, 2012 at 10:08 AM, Chao Xie <chao.xie@marvell.com> wrote:
> KPDK_DK only indicates the pin level of direct key.
> So it is related to board, and low level may be active which
> indicates that a key is pressed.
>
> Signed-off-by: Chao Xie <chao.xie@marvell.com>
> ---
> ?arch/arm/plat-pxa/include/plat/pxa27x_keypad.h | ? ?2 ++
> ?drivers/input/keyboard/pxa27x_keypad.c ? ? ? ? | ? 10 +++++++++-
> ?2 files changed, 11 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/plat-pxa/include/plat/pxa27x_keypad.h b/arch/arm/plat-pxa/include/plat/pxa27x_keypad.h
> index abcc36e..7ffb16b 100644
> --- a/arch/arm/plat-pxa/include/plat/pxa27x_keypad.h
> +++ b/arch/arm/plat-pxa/include/plat/pxa27x_keypad.h
> @@ -44,6 +44,8 @@ struct pxa27x_keypad_platform_data {
> ? ? ? ?/* direct keys */
> ? ? ? ?int ? ? ? ? ? ? direct_key_num;
> ? ? ? ?unsigned int ? ?direct_key_map[MAX_DIRECT_KEY_NUM];
> + ? ? ? /* the key output may be low active */
> + ? ? ? int ? ? ? ? ? ? direct_key_low_active;
>
> ? ? ? ?/* rotary encoders 0 */
> ? ? ? ?int ? ? ? ? ? ? enable_rotary0;
> diff --git a/drivers/input/keyboard/pxa27x_keypad.c b/drivers/input/keyboard/pxa27x_keypad.c
> index 5d71720..a60f14e 100644
> --- a/drivers/input/keyboard/pxa27x_keypad.c
> +++ b/drivers/input/keyboard/pxa27x_keypad.c
> @@ -311,7 +311,15 @@ static void pxa27x_keypad_scan_direct(struct pxa27x_keypad *keypad)
> ? ? ? ?if (pdata->enable_rotary0 || pdata->enable_rotary1)
> ? ? ? ? ? ? ? ?pxa27x_keypad_scan_rotary(keypad);
>
> - ? ? ? new_state = KPDK_DK(kpdk) & keypad->direct_key_mask;
> + ? ? ? /*
> + ? ? ? ?* The KPDR_DK only output the key pin level, so it relates to board,
> + ? ? ? ?* and low level may be active.
> + ? ? ? ?*/
> + ? ? ? if (pdata->direct_key_low_active)
> + ? ? ? ? ? ? ? new_state = ~KPDK_DK(kpdk) & keypad->direct_key_mask;
> + ? ? ? else
> + ? ? ? ? ? ? ? new_state = KPDK_DK(kpdk) & keypad->direct_key_mask;
> +
> ? ? ? ?bits_changed = keypad->direct_key_state ^ new_state;
>
> ? ? ? ?if (bits_changed == 0)
> --
> 1.7.0.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Loop Dmitry
