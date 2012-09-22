From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Sat, 22 Sep 2012 12:17:27 +0200
Subject: [PATCH 4/6] staging: drm/imx: Add i.MX IPUv3 crtc support
In-Reply-To: <505C94B3.3020308@boundarydevices.com>
References: <1348214872-28594-1-git-send-email-s.hauer@pengutronix.de>
 <1348214872-28594-5-git-send-email-s.hauer@pengutronix.de>
 <505C94B3.3020308@boundarydevices.com>
Message-ID: <20120922101727.GG1322@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

On Fri, Sep 21, 2012 at 09:24:19AM -0700, Eric Nelson wrote:
> Hi Sascha,
> 
> While testing against a video-enabled U-Boot on i.MX6, I found the issue
> below.
> 

[...]

> 
> But ipu_crtc->imx_crtc gets initialized in this call, and
> ipu_irq_handler() makes use of it.
> 
> The U-Boot code doesn't enable interrupts, so it's not acking
> along the way, and leaves bits set in IPU1_INT_STAT_15.
> 
> I found that I can get around this in U-Boot by disabling the
> LCD controller and acking all of the interrupts after disabling
> the controller, but I haven't yet figured out where to tap into
> cleanup_before_linux().

Passing over an enabled IPU from the bootloader to the kernel is
(currently) not a supported usecase, so U-Boot should indeed disable it.
That said, the kernel driver should make sure the IPU is sufficiently
configured before the interrupts are enabled, so this seems to be a bug
that deserves fixing.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
