From: julian.calaby@gmail.com (Julian Calaby)
Date: Fri, 26 Feb 2016 10:31:06 +1100
Subject: [PATCH][V3] mt7601u: do not free dma_buf when ivp allocation fails
In-Reply-To: <1456442667-19751-1-git-send-email-colin.king@canonical.com>
References: <1456442667-19751-1-git-send-email-colin.king@canonical.com>
Message-ID: <CAGRGNgUq_YTi1h_FBxGSFGLUhHoz3xQguDU_5ZFhSyUKAruW1w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Feb 26, 2016 at 10:24 AM, Colin King <colin.king@canonical.com> wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> If the allocation of ivp fails the error handling attempts to
> free an uninitialized dma_buf; this data structure just contains
> garbage on the stack, so the freeing will cause issues when the
> urb, buf and dma fields are free'd. Fix this by not free'ing the
> dma_buf if the ivp allocation fails.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Looks right to me.

Reviewed-by: Julian Calaby <julian.calaby@gmail.com>

> ---
>  drivers/net/wireless/mediatek/mt7601u/mcu.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/mediatek/mt7601u/mcu.c b/drivers/net/wireless/mediatek/mt7601u/mcu.c
> index fbb1986..91c4b34 100644
> --- a/drivers/net/wireless/mediatek/mt7601u/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt7601u/mcu.c
> @@ -362,7 +362,9 @@ mt7601u_upload_firmware(struct mt7601u_dev *dev, const struct mt76_fw *fw)
>         int i, ret;
>
>         ivb = kmemdup(fw->ivb, sizeof(fw->ivb), GFP_KERNEL);
> -       if (!ivb || mt7601u_usb_alloc_buf(dev, MCU_FW_URB_SIZE, &dma_buf)) {
> +       if (!ivb)
> +               return -ENOMEM;
> +       if (mt7601u_usb_alloc_buf(dev, MCU_FW_URB_SIZE, &dma_buf)) {
>                 ret = -ENOMEM;
>                 goto error;
>         }
> --
> 2.7.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Thanks,

-- 
Julian Calaby

Email: julian.calaby at gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
