From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 8 Jan 2013 15:04:23 -0200
Subject: [PATCH 7/7] ARM i.MX51 babbage: Add display support
In-Reply-To: <CAOMZO5BnFZs+s-WFahtqyzCi15P9RBzKDzwdZNCJ4PmnQrFY1g@mail.gmail.com>
References: <1352733809-27230-1-git-send-email-s.hauer@pengutronix.de>
 <1352733809-27230-8-git-send-email-s.hauer@pengutronix.de>
 <CAOMZO5BnFZs+s-WFahtqyzCi15P9RBzKDzwdZNCJ4PmnQrFY1g@mail.gmail.com>
Message-ID: <CAOMZO5AkRmhdB-JWQ5DFuQUJHibV7GGvvDeK7-cg7m8OnbHA_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 8, 2013 at 2:41 PM, Fabio Estevam <festevam@gmail.com> wrote:
> Hi Sascha,
>
> On Mon, Nov 12, 2012 at 1:23 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
>> The babbage board has a DVI-I output which allows to output analog
>> and digital signals simultaneously. This patch adds support for it
>> to the devicetree. The DDC signals are not wired up on the board, so
>> DRM will fall back on default VESA modes.
>>
>> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
>
> I am running linux-next 20130108, which has this patch applied and I
> get the following on my mx51babbage:

Ok, good news. I see a nice penguin on my monitor now.

Discussed with Marek and he proposed a quick workaround:

--- a/drivers/staging/imx-drm/ipuv3-crtc.c
+++ b/drivers/staging/imx-drm/ipuv3-crtc.c
@@ -343,6 +343,11 @@ static irqreturn_t ipu_irq_handler(int irq, void *dev_id)
 {
        struct ipu_crtc *ipu_crtc = dev_id;

+       if (!ipu_crtc->imx_crtc) {
+               pr_err("Spurious IPU IRQ\n");
+               return IRQ_HANDLED;
+       }
+
        imx_drm_handle_vblank(ipu_crtc->imx_crtc);

        if (ipu_crtc->newfb) {

It seems that this issue happened because bootloader leaves the IPU turned on.

Thanks,

Fabio Estevam
