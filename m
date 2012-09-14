From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Fri, 14 Sep 2012 11:29:06 +0200
Subject: [PATCH 3/6] staging: drm/imx: add i.MX IPUv3 base driver
In-Reply-To: <1347445874-10779-4-git-send-email-s.hauer@pengutronix.de>
References: <1347445874-10779-1-git-send-email-s.hauer@pengutronix.de>
 <1347445874-10779-4-git-send-email-s.hauer@pengutronix.de>
Message-ID: <5052F8E2.6010106@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12.09.2012 12:31, Sascha Hauer wrote:
> The IPU is the Image Processing Unit found on i.MX51/53/6 SoCs. It
> features several units for image processing, this patch adds support
> for the units needed for Framebuffer support, namely:
> 
> - Display Controller (dc)
> - Display Interface (di)
> - Display Multi Fifo Controller (dmfc)
> - Display Processor (dp)
> - Image DMA Controller (idmac)
> 
> This patch is based on the Freescale driver, but follows a different
> approach. The Freescale code implements logical idmac channels and
> the handling of the subunits is hidden in common idmac code pathes
> in big switch/case statements. This patch instead just provides code
> and resource management for the different subunits. The user, in this
> case the framebuffer driver, decides how the different units play
> together.
> 
> The IPU has other units missing in this patch:
> 
> - CMOS Sensor Interface (csi)
> - Video Deinterlacer (vdi)
> - Sensor Multi FIFO Controler (smfc)
> - Image Converter (ic)
> - Image Rotator (irt)
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
....
> +static int ipu_reset(struct ipu_soc *ipu)
> +{
> +       unsigned long timeout;
> +
> +       ipu_cm_write(ipu, 0x807FFFFF, IPU_MEM_RST);
> +
> +       timeout = jiffies + msecs_to_jiffies(1000);
> +       while (ipu_cm_read(ipu, IPU_MEM_RST) & 0x80000000) {
> +               if (time_after(jiffies, timeout))
> +                       return -ETIME;
> +               cpu_relax();
> +       }
> +
> +       mdelay(300);
           ^^^^^^^^^^^^

> +       return 0;
> +}

While doing some boot time measurement with i.MX6, we found that the 
above mdelay(300) is hurting regarding boot time. On i.MX6 you have two 
IPU instances, so in the end you get 600ms additional delay.

Looking at the Freescale code, this function looks like

static int ipu_reset(struct ipu_soc *ipu)
{
int timeout = 1000;

ipu_cm_write(ipu, 0x807FFFFF, IPU_MEM_RST);

while (ipu_cm_read(ipu, IPU_MEM_RST) & 0x80000000) {
  if (!timeout--)
    return -ETIME;
  msleep(1);
}
return 0;
}

So there is a msleep() in the loop but no mdelay() outside. Any idea why 
the mdelay() is needed here? Or what could be done regarding boot time 
with this?

Note: This is just a question, this shouldn't block the staging process.

Best regards

Dirk
