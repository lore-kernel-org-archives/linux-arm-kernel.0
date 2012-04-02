From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Mon, 2 Apr 2012 17:38:21 +0800
Subject: [PATCH V3 4/4] Input: pxa27x_keypad add choice to set
 direct_key_mask
In-Reply-To: <1333246084-14110-4-git-send-email-chao.xie@marvell.com>
References: <1333246084-14110-1-git-send-email-chao.xie@marvell.com>
 <1333246084-14110-4-git-send-email-chao.xie@marvell.com>
Message-ID: <CAN1soZzep_gqbOvL7G4KaCqkbOSLWz7j9VoU3R8fqGpwUui=dQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 1, 2012 at 10:08 AM, Chao Xie <chao.xie@marvell.com> wrote:
> Direct keys usage may not start from KP_DKIN0, add a msk option
> to configure the specifics for platforms that can skip some keys.
>
> Signed-off-by: Chao Xie <chao.xie@marvell.com>
> ---
> ?arch/arm/plat-pxa/include/plat/pxa27x_keypad.h | ? ?2 ++
> ?drivers/input/keyboard/pxa27x_keypad.c ? ? ? ? | ? ?9 ++++++++-
> ?2 files changed, 10 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/plat-pxa/include/plat/pxa27x_keypad.h b/arch/arm/plat-pxa/include/plat/pxa27x_keypad.h
> index 7ffb16b..5ce8d5e 100644
> --- a/arch/arm/plat-pxa/include/plat/pxa27x_keypad.h
> +++ b/arch/arm/plat-pxa/include/plat/pxa27x_keypad.h
> @@ -46,6 +46,8 @@ struct pxa27x_keypad_platform_data {
> ? ? ? ?unsigned int ? ?direct_key_map[MAX_DIRECT_KEY_NUM];
> ? ? ? ?/* the key output may be low active */
> ? ? ? ?int ? ? ? ? ? ? direct_key_low_active;
> + ? ? ? /* give board a chance to choose the start direct key */
> + ? ? ? unsigned int ? ?direct_key_mask;
>
> ? ? ? ?/* rotary encoders 0 */
> ? ? ? ?int ? ? ? ? ? ? enable_rotary0;
> diff --git a/drivers/input/keyboard/pxa27x_keypad.c b/drivers/input/keyboard/pxa27x_keypad.c
> index a60f14e..7f7b724 100644
> --- a/drivers/input/keyboard/pxa27x_keypad.c
> +++ b/drivers/input/keyboard/pxa27x_keypad.c
> @@ -391,7 +391,14 @@ static void pxa27x_keypad_config(struct pxa27x_keypad *keypad)
> ? ? ? ?if (pdata->direct_key_num > direct_key_num)
> ? ? ? ? ? ? ? ?direct_key_num = pdata->direct_key_num;
>
> - ? ? ? keypad->direct_key_mask = ((1 << direct_key_num) - 1) & ~mask;
> + ? ? ? /*
> + ? ? ? ?* Direct keys usage may not start from KP_DKIN0, check the platfrom
> + ? ? ? ?* mask data to config the specific.
> + ? ? ? ?*/
> + ? ? ? if (pdata->direct_key_mask)
> + ? ? ? ? ? ? ? keypad->direct_key_mask = pdata->direct_key_mask;
> + ? ? ? else
> + ? ? ? ? ? ? ? keypad->direct_key_mask = ((1 << direct_key_num) - 1) & ~mask;
>
> ? ? ? ?/* enable direct key */
> ? ? ? ?if (direct_key_num)
> --
> 1.7.0.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Loop Dmitry
