From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 14 Sep 2012 11:38:31 +0200
Subject: [PATCH 3/6] staging: drm/imx: add i.MX IPUv3 base driver
In-Reply-To: <5052F8E2.6010106@de.bosch.com>
References: <1347445874-10779-1-git-send-email-s.hauer@pengutronix.de>
 <1347445874-10779-4-git-send-email-s.hauer@pengutronix.de>
 <5052F8E2.6010106@de.bosch.com>
Message-ID: <20120914093831.GV6180@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 14, 2012 at 11:29:06AM +0200, Dirk Behme wrote:
> On 12.09.2012 12:31, Sascha Hauer wrote:
> >+
> >+       timeout = jiffies + msecs_to_jiffies(1000);
> >+       while (ipu_cm_read(ipu, IPU_MEM_RST) & 0x80000000) {
> >+               if (time_after(jiffies, timeout))
> >+                       return -ETIME;
> >+               cpu_relax();
> >+       }
> >+
> >+       mdelay(300);
>           ^^^^^^^^^^^^
> 
> >+       return 0;
> >+}
> 
> While doing some boot time measurement with i.MX6, we found that the
> above mdelay(300) is hurting regarding boot time. On i.MX6 you have
> two IPU instances, so in the end you get 600ms additional delay.
> 
> Looking at the Freescale code, this function looks like
> 
> static int ipu_reset(struct ipu_soc *ipu)
> {
> int timeout = 1000;
> 
> ipu_cm_write(ipu, 0x807FFFFF, IPU_MEM_RST);
> 
> while (ipu_cm_read(ipu, IPU_MEM_RST) & 0x80000000) {
>  if (!timeout--)
>    return -ETIME;
>  msleep(1);
> }
> return 0;
> }
> 
> So there is a msleep() in the loop but no mdelay() outside. Any idea
> why the mdelay() is needed here? Or what could be done regarding
> boot time with this?

I remember we had issues on i.MX51 or 53 without it, but I would have to
recheck it.
In any way, I think this should be reworked. The reset takes quite a
long time and it's not nice to block the boot process for so long.
Some asynchronous reset would be nice here.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
