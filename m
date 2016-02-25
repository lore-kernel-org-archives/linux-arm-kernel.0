From: julian.calaby@gmail.com (Julian Calaby)
Date: Fri, 26 Feb 2016 10:14:59 +1100
Subject: [PATCH][V2] mt7601u: do not free dma_buf when ivp allocation fails
In-Reply-To: <1456441799-19266-1-git-send-email-colin.king@canonical.com>
References: <1456441799-19266-1-git-send-email-colin.king@canonical.com>
Message-ID: <CAGRGNgX0323K81mi_7yyUu18-CB6=GTrMM0J72iuYPBv9JD88g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Colin,

On Fri, Feb 26, 2016 at 10:09 AM, Colin King <colin.king@canonical.com> wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> If the allocation of ivp fails the error handling attempts to
> free an uninitialized dma_buf; this data structure just contains
> garbage on the stack, so the freeing will cause issues when the
> urb, buf and dma fields are free'd. Fix this by not free'ing the
> dma_buf if the ivp allocation fails.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/net/wireless/mediatek/mt7601u/mcu.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/wireless/mediatek/mt7601u/mcu.c b/drivers/net/wireless/mediatek/mt7601u/mcu.c
> index fbb1986..70e4b5e 100644
> --- a/drivers/net/wireless/mediatek/mt7601u/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt7601u/mcu.c
> @@ -362,10 +362,10 @@ mt7601u_upload_firmware(struct mt7601u_dev *dev, const struct mt76_fw *fw)
>         int i, ret;
>
>         ivb = kmemdup(fw->ivb, sizeof(fw->ivb), GFP_KERNEL);
> -       if (!ivb || mt7601u_usb_alloc_buf(dev, MCU_FW_URB_SIZE, &dma_buf)) {
> -               ret = -ENOMEM;
> +       if (!ivb)
> +               return -ENOMEM;
> +       if (mt7601u_usb_alloc_buf(dev, MCU_FW_URB_SIZE, &dma_buf))
>                 goto error;

Are you sure this is right? Isn't ret unset here and consequently
returned at the end of the error label?

Thanks,

-- 
Julian Calaby

Email: julian.calaby at gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
