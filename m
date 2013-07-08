From: balbi@ti.com (Felipe Balbi)
Date: Mon, 8 Jul 2013 12:02:54 +0300
Subject: [PATCH 2/4] mmc: omap_hsmmc: Enable SDIO IRQ using a GPIO in
 idle mode
In-Reply-To: <20130607214952.18581.90049.stgit@localhost>
References: <20130607214557.18581.75288.stgit@localhost>
 <20130607214952.18581.90049.stgit@localhost>
Message-ID: <20130708090254.GH29100@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 07, 2013 at 02:49:52PM -0700, Tony Lindgren wrote:
> From: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
> 
> Without functional clock the omap_hsmmc module can't forward SDIO IRQs to
> the system. This patch reconfigures dat1 line as a gpio while the fclk is
> off. When the fclk is present it uses the standard SDIO IRQ detection of
> the module.
> 
> The gpio irq is managed via the 'disable_depth' ref counter of the irq
> subsystem, this driver simply calls enable_irq/disable_irq when needed.
> 
>                       sdio irq    sdio irq
>                       unmasked     masked
>    -----------------------------------------
>     runtime default  |    1     |   2
>     runtime suspend  |    0     |   1
> 
>                   irq disable depth
> 
> 
> only when sdio irq is enabled AND the module is idle, the reference
> count drops to zero and the gpio irq is effectively armed.
> 
> Patch was tested on AM335x/Stream800. Test setup was two modules
> with sdio wifi cards. Modules where connected to a dual-band AP, each
> module using a different band. One of module was running iperf as server
> the other as client connecting to the server in a while true loop. Test
> was running for 4+ weeks. There were about 60 Mio. suspend/resume
> transitions. Test was shut down regularly.
> 
> Cc: Andreas Fenkart <afenkart@gmail.com>
> Cc: Balaji T K <balajitk@ti.com>
> Signed-off-by: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
> Reviewed-by: Grant Likely <grant.likely@secretlab.ca>
> [tony at atomide.com: updated and separated out pin muxing]
> Signed-off-by: Tony Lindgren <tony@atomide.com>

right, as I discussed before the gpio part should also be split to a
separate patch. That's a workaround for broken HW anyway.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130708/faf18bc1/attachment.sig>
