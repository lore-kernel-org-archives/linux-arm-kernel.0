From: yibin.gong@nxp.com (Robin Gong)
Date: Tue, 12 Jun 2018 08:58:49 +0000
Subject: [PATCH v3 0/6] add virt-dma support for imx-sdma
In-Reply-To: <1528714877.2842.3.camel@pengutronix.de>
References: <1528729173-28684-1-git-send-email-yibin.gong@nxp.com>
 <1528714877.2842.3.camel@pengutronix.de>
Message-ID: <1528822708.13468.9.camel@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lucas,
	Is the below DEAD LOCK issue same as your side? If yes, then
I'm afraid that we have to make another patch for uart to split dma
functions in uart driver out of the code area which protected by
port.lock. The warning make sense since allocate sdma bd memory
dynamically in virt-dma instead of static allocated as before. I'll
make another uart patch into my next version patchset.


[???46.155406] =====================================================
[???46.161503] WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order
detected
[???46.168122] 4.17.0-rc6-00008-g7caafa3-dirty #48 Not tainted
[???46.173696] -----------------------------------------------------
[???46.179795] mxc_uart_stress/419 [HC0[0]:SC0[0]:HE0:SE1] is trying to
acquire:
[???46.186934] fa7c1440 (fs_reclaim){+.+.}, at:
fs_reclaim_acquire.part.3+0x0/0x48
[???46.194270]
[???46.194270] and this task is already holding:
[???46.200106] 09a17fda (&port_lock_key){-.-.}, at:
uart_write+0x84/0x190
[???46.206658] which would create a new lock dependency:
[???46.211710]??(&port_lock_key){-.-.} -> (fs_reclaim){+.+.}
[???46.217132]
[???46.217132] but this new dependency connects a HARDIRQ-irq-safe
lock:
[???46.225051]??(&port_lock_key){-.-.}
[???46.225062]
[???46.225062] ... which became HARDIRQ-irq-safe at:
[???46.234740]???lock_acquire+0x70/0x90
[???46.238326]???_raw_spin_lock_irqsave+0x40/0x54
[???46.242777]???imx_uart_console_write+0x1bc/0x1e0
[???46.247402]???console_unlock+0x320/0x5f0
[???46.251329]???vprintk_emit+0x22c/0x3fc
[???46.255082]???vprintk_default+0x28/0x30
[???46.258923]???vprintk_func+0x78/0xcc
[???46.262503]???printk+0x34/0x54
[???46.265566]???crng_fast_load+0xf8/0x138
[???46.269407]???add_interrupt_randomness+0x21c/0x24c
[???46.274204]???handle_irq_event_percpu+0x40/0x84
[???46.278739]???handle_irq_event+0x40/0x64
[???46.282667]???handle_fasteoi_irq+0xbc/0x178
[???46.286854]???generic_handle_irq+0x28/0x3c
[???46.290954]???__handle_domain_irq+0x6c/0xe8
[???46.295148]???gic_handle_irq+0x64/0xc4
[???46.298904]???__irq_svc+0x70/0x98
[???46.302225]???_raw_spin_unlock_irq+0x30/0x34
[???46.306505]???finish_task_switch+0xc0/0x27c
[???46.310693]???__schedule+0x2c0/0x79c
[???46.314272]???schedule_idle+0x40/0x84
[???46.317941]???do_idle+0x178/0x2b4
[???46.321259]???cpu_startup_entry+0x20/0x24
[???46.325278]???rest_init+0x214/0x264
[???46.328775]???start_kernel+0x39c/0x424
[???46.332527]?????(null)
[???46.334891]
[???46.334891] to a HARDIRQ-irq-unsafe lock:
[???46.340379]??(fs_reclaim){+.+.}
[???46.340391]
[???46.340391] ... which became HARDIRQ-irq-unsafe at:
[???46.349885] ...
[???46.349895]???lock_acquire+0x70/0x90
[???46.355225]???fs_reclaim_acquire.part.3+0x38/0x48
[???46.359933]???fs_reclaim_acquire+0x1c/0x20
[???46.364036]???kmem_cache_alloc+0x2c/0x174
[???46.368051]???alloc_worker.constprop.10+0x1c/0x58
[???46.372759]???init_rescuer.part.4+0x18/0xa4
[???46.376952]???workqueue_init+0xc0/0x210
[???46.380793]???kernel_init_freeable+0x58/0x1d8
[???46.385156]???kernel_init+0x10/0x11c
[???46.388736]???ret_from_fork+0x14/0x20
[???46.392399]?????(null)
[???46.394762]
[???46.394762] other info that might help us debug this:
[???46.394762]
[???46.402769]??Possible interrupt unsafe locking scenario:
[???46.402769]
[???46.409560]????????CPU0????????????????????CPU1
[???46.414092]????????----????????????????????----
[???46.418622]???lock(fs_reclaim);
[???46.421772]????????????????????????????????local_irq_disable();
[???46.427693]????????????????????????????????lock(&port_lock_key);
[???46.433707]????????????????????????????????lock(fs_reclaim);
[???46.439372]???<Interrupt>
[???46.441993]?????lock(&port_lock_key);
[???46.445661]
[???46.445661]??*** DEADLOCK ***
[???46.445661]

On ?, 2018-06-11 at 13:01 +0200, Lucas Stach wrote:
> Hi Robin,
> 
> this series breaks serial DMA for me. I wasn't able to dig in deeper
> yet. Please let me know if you can test/reproduce at your side, if
> not
> I'll try to find some time to collect some more debug info.
> 
> Regards,
> Lucas
> 
> Am Montag, den 11.06.2018, 22:59 +0800 schrieb Robin Gong:
> > 
> > The legacy sdma driver has below limitations or drawbacks:
> > ? 1. Hardcode the max BDs number as "PAGE_SIZE / sizeof(*)", and
> > alloc
> > ?????one page size for one channel regardless of only few BDs
> > needed
> > ?????most time. But in few cases, the max PAGE_SIZE maybe not
> > enough.
> > ? 2. One SDMA channel can't stop immediatley once channel disabled
> > which
> > ?????means SDMA interrupt may come in after this channel
> > terminated.There
> > ?????are some patches for this corner case such as commit
> > "2746e2c389f9",
> > ?????but not cover non-cyclic.
> > 
> > The common virt-dma overcomes the above limitations. It can alloc
> > bd
> > dynamically and free bd once this tx transfer done. No memory
> > wasted or
> > maximum limititation here, only depends on how many memory can be
> > requested
> > from kernel. For No.2, such issue can be workaround by checking if
> > there
> > is available descript("sdmac->desc") now once the unwanted
> > interrupt
> > coming. At last the common virt-dma is easier for sdma driver
> > maintain.
> > 
> > Change from v2:
> > ? 1. include Sascha's patch to make the main patch easier to
> > review.
> > ?????Thanks Sacha.
> > ? 2. remove useless 'desc'/'chan' in struct sdma_channe.
> > 
> > Change from v1:
> > ? 1. split v1 patch into 5 patches.
> > ? 2. remove some unnecessary condition check.
> > ? 3. remove unnecessary 'pending' list.
> > 
> > Robin Gong (5):
> > ? dmaengine: imx-sdma: add virt-dma support
> > ? Revert "dmaengine: imx-sdma: fix pagefault when channel is
> > disabled
> > ????during interrupt"
> > ? dmaengine: imx-sdma: remove usless lock
> > ? dmaengine: imx-sdma: remove the maximum limation for bd numbers
> > ? dmaengine: imx-sdma: add sdma_transfer_init to decrease code
> > overlap
> > 
> > ?drivers/dma/Kconfig????|???1 +
> > ?drivers/dma/imx-sdma.c | 392 ++++++++++++++++++++++++++++---------
> > ------------
> > ?2 files changed, 227 insertions(+), 166 deletions(-)
> > 
> > --?
> > 2.7.4
> > 
> > Robin Gong (5):
> > ? dmaengine: imx-sdma: add virt-dma support
> > ? Revert "dmaengine: imx-sdma: fix pagefault when channel is
> > disabled
> > ????during interrupt"
> > ? dmaengine: imx-sdma: remove usless lock
> > ? dmaengine: imx-sdma: remove the maximum limation for bd numbers
> > ? dmaengine: imx-sdma: add sdma_transfer_init to decrease code
> > overlap
> > 
> > Sascha Hauer (1):
> > ? dmaengine: imx-sdma: factor out a struct sdma_desc from struct
> > ????sdma_channel
> > 
> > ?drivers/dma/Kconfig????|???1 +
> > ?drivers/dma/imx-sdma.c | 391 ++++++++++++++++++++++++++++---------
> > ------------
> > ?2 files changed, 226 insertions(+), 166 deletions(-)
> > 
