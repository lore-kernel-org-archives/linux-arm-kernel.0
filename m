From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 9 Feb 2015 20:02:44 +0100
Subject: [PATCH v2] drm: atmel-hlcdc: Atomic mode-setting conversion
In-Reply-To: <20150209182606.GA11712@gradator.net>
References: <1423236143-6494-1-git-send-email-boris.brezillon@free-electrons.com>
 <20150209182606.GA11712@gradator.net>
Message-ID: <20150209200244.5b3481b8@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hu Sylvain,

On Mon, 9 Feb 2015 19:26:06 +0100
Sylvain Rochet <sylvain.rochet@finsecur.com> wrote:

> Hello Boris,
> 
> On Fri, Feb 06, 2015 at 04:22:23PM +0100, Boris Brezillon wrote:
> > Convert the HLCDC driver to atomic mode-setting.
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > ---
> 
> I am getting the following trace with this patch applied, which seems 
> pretty straightforward to fix.

Yep, I thought DRM core was already checking the previous state before
calling the disable/enable callbacks, but it doesn't.

I'll add a field to store the previous state and check it before doing
any operation.

Thanks for pointing this out.

Regards,

Boris

> 
> Apart from that, it works perfectly, you can add my:
> 
> Tested-by: Sylvain Rochet <sylvain.rochet@finsecur.com>
> 
> 
> 
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 9 at drivers/clk/clk.c:992 clk_disable+0x28/0x34()
> Modules linked in:
> CPU: 0 PID: 9 Comm: kworker/0:1 Not tainted 3.19.0-rc7-next-20150204+ #90
> Hardware name: Atmel SAMA5 (Device Tree)
> Workqueue: events output_poll_execute
> [<c0013284>] (unwind_backtrace) from [<c0010f90>] (show_stack+0x10/0x14)
> [<c0010f90>] (show_stack) from [<c001b0fc>] (warn_slowpath_common+0x84/0xb0)
> [<c001b0fc>] (warn_slowpath_common) from [<c001b1c4>] (warn_slowpath_null+0x1c/0x24)
> [<c001b1c4>] (warn_slowpath_null) from [<c0355418>] (clk_disable+0x28/0x34)
> [<c0355418>] (clk_disable) from [<c024b1c0>] (atmel_hlcdc_crtc_disable+0xe8/0x114)
> [<c024b1c0>] (atmel_hlcdc_crtc_disable) from [<c02209dc>] (__drm_helper_disable_unused_functions+0xa4/0xd8)
> [<c02209dc>] (__drm_helper_disable_unused_functions) from [<c0220a24>] (drm_helper_disable_unused_functions+0x14/0x20)
> [<c0220a24>] (drm_helper_disable_unused_functions) from [<c022d078>] (drm_fbdev_cma_init+0x78/0xfc)
> [<c022d078>] (drm_fbdev_cma_init) from [<c024b7a8>] (atmel_hlcdc_fb_output_poll_changed+0x30/0x40)
> [<c024b7a8>] (atmel_hlcdc_fb_output_poll_changed) from [<c0222800>] (output_poll_execute+0x148/0x188)
> [<c0222800>] (output_poll_execute) from [<c002bf94>] (process_one_work+0xfc/0x310)
> [<c002bf94>] (process_one_work) from [<c002caec>] (worker_thread+0x60/0x478)
> [<c002caec>] (worker_thread) from [<c00305b4>] (kthread+0xd4/0xec)
> [<c00305b4>] (kthread) from [<c000e4a0>] (ret_from_fork+0x14/0x34)
> ---[ end trace 9500ebf8d7076b60 ]---
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 9 at drivers/clk/clk.c:898 clk_unprepare+0x24/0x2c()
> Modules linked in:
> CPU: 0 PID: 9 Comm: kworker/0:1 Tainted: G        W      3.19.0-rc7-next-20150204+ #90
> Hardware name: Atmel SAMA5 (Device Tree)
> Workqueue: events output_poll_execute
> [<c0013284>] (unwind_backtrace) from [<c0010f90>] (show_stack+0x10/0x14)
> [<c0010f90>] (show_stack) from [<c001b0fc>] (warn_slowpath_common+0x84/0xb0)
> [<c001b0fc>] (warn_slowpath_common) from [<c001b1c4>] (warn_slowpath_null+0x1c/0x24)
> [<c001b1c4>] (warn_slowpath_null) from [<c03553e8>] (clk_unprepare+0x24/0x2c)
> [<c03553e8>] (clk_unprepare) from [<c024b1c8>] (atmel_hlcdc_crtc_disable+0xf0/0x114)
> [<c024b1c8>] (atmel_hlcdc_crtc_disable) from [<c02209dc>] (__drm_helper_disable_unused_functions+0xa4/0xd8)
> [<c02209dc>] (__drm_helper_disable_unused_functions) from [<c0220a24>] (drm_helper_disable_unused_functions+0x14/0x20)
> [<c0220a24>] (drm_helper_disable_unused_functions) from [<c022d078>] (drm_fbdev_cma_init+0x78/0xfc)
> [<c022d078>] (drm_fbdev_cma_init) from [<c024b7a8>] (atmel_hlcdc_fb_output_poll_changed+0x30/0x40)
> [<c024b7a8>] (atmel_hlcdc_fb_output_poll_changed) from [<c0222800>] (output_poll_execute+0x148/0x188)
> [<c0222800>] (output_poll_execute) from [<c002bf94>] (process_one_work+0xfc/0x310)
> [<c002bf94>] (process_one_work) from [<c002caec>] (worker_thread+0x60/0x478)
> [<c002caec>] (worker_thread) from [<c00305b4>] (kthread+0xd4/0xec)
> [<c00305b4>] (kthread) from [<c000e4a0>] (ret_from_fork+0x14/0x34)
> ---[ end trace 9500ebf8d7076b61 ]--- 
> 
> 
> Sylvain



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
