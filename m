From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Thu, 14 Jun 2012 16:48:56 +0530
Subject: [PATCH 15/17] i2c: omap: always return IRQ_HANDLED
In-Reply-To: <1339669250-9183-16-git-send-email-balbi@ti.com>
References: <1339669250-9183-1-git-send-email-balbi@ti.com>
 <1339669250-9183-16-git-send-email-balbi@ti.com>
Message-ID: <CAMQu2gzbK+ObetarwRiEz9A7=awEffAhrMMAqSMfiv4H6BZAuw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 14, 2012 at 3:50 PM, Felipe Balbi <balbi@ti.com> wrote:
> otherwise we could get our IRQ line disabled due
> to many spurious IRQs.
>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
> ?drivers/i2c/busses/i2c-omap.c | ? ?2 +-
> ?1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index fc5b8bc..5b78a73 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -1015,7 +1015,7 @@ omap_i2c_isr(int this_irq, void *dev_id)
> ? ? ? ? ? ? ? ?}
> ? ? ? ?} while (stat);
>
> - ? ? ? return count ? IRQ_HANDLED : IRQ_NONE;
> + ? ? ? return IRQ_HANDLED;

no sure if this is correct. if you have IRQ flood and instead of _actually_
handling it, if you return handled, you still have interrupt pending, right?

 if (count++ == 100) {
                        dev_warn(dev->dev, "Too much work in one IRQ\n");
                        break;
                }
ofcourse we do get warning message already, so as such the change
should be fine.

Just want to understand the change bit more.

Regards
Santosh



Regards
santosh
