From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 7 Jul 2015 10:41:39 +0900
Subject: [PATCH] ARM: dts: exynos4: add DMA support for serial ports
In-Reply-To: <5591E92B.4020809@samsung.com>
References: <1435584154-4969-1-git-send-email-r.baldyga@samsung.com>
 <5591E92B.4020809@samsung.com>
Message-ID: <CAJKOXPfaDXVoYEBsV6_XVKF9D8WfKx-dub6NrWZb73_C6SKckQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-06-30 9:56 GMT+09:00 Krzysztof Kozlowski <k.kozlowski@samsung.com>:
> On 29.06.2015 22:22, Robert Baldyga wrote:
>> Enable DMA transfers for serial ports.
>>
>> Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
>> ---
>>  arch/arm/boot/dts/exynos4.dtsi | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Unfortunately the commit (applied on 4.2-rc1) exposes lock-ups during
Trats2 boot.

Board: Trats2
Config: exynos
Tree: https://github.com/krzk/linux.git
branch: for-next (v4.2-rc1-29-g1ce41c343055)

Lockdep indicated issue in Samsung serial driver
(dma_async_issue_pending called while holding port->lock which leads
to calling back the driver's tx_dma_complete).

I tried to locate the dead lock. To me the excessive locking in serial
driver causes such recursive locking but I am not quite sure (I am not
familiar with the serial driver).

Anyway, till this get fixed I am dropping the patch from my tree.

Best regards,
Krzysztof


Bug (I hope line wrapping won't mess up with it...):

[   74.480535] BUG: spinlock recursion on CPU#1, systemd/1
[   74.484293]  lock: 0xeeb1a9f4, .magic: dead4ead, .owner: systemd/1,
.owner_cpu: 1
[   74.491756] CPU: 1 PID: 1 Comm: systemd Not tainted
4.2.0-rc1-00029-g1ce41c343055 #100
[   74.499649] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[   74.505752] [<c0014d2c>] (unwind_backtrace) from [<c0011c98>]
(show_stack+0x10/0x14)
[   74.513461] [<c0011c98>] (show_stack) from [<c051f198>]
(dump_stack+0x70/0xbc)
[   74.520668] [<c051f198>] (dump_stack) from [<c00562b0>]
(do_raw_spin_lock+0x178/0x1a0)
[   74.528568] [<c00562b0>] (do_raw_spin_lock) from [<c0524e90>]
(_raw_spin_lock_irqsave+0x20/0x28)
[   74.537330] [<c0524e90>] (_raw_spin_lock_irqsave) from [<c024288c>]
(dma_pl330_rqcb.isra.4+0x24/0x58)
[   74.546529] [<c024288c>] (dma_pl330_rqcb.isra.4) from [<c0242d78>]
(pl330_release_channel.part.5+0x38/0x98)
[   74.556249] [<c0242d78>] (pl330_release_channel.part.5) from
[<c0242e2c>] (pl330_free_chan_resources+0x54/0xd8)
[   74.566324] [<c0242e2c>] (pl330_free_chan_resources) from
[<c0240144>] (dma_chan_put+0x88/0x8c)
[   74.575001] [<c0240144>] (dma_chan_put) from [<c024016c>]
(dma_release_channel+0x24/0x94)
[   74.583163] [<c024016c>] (dma_release_channel) from [<c0271498>]
(s3c24xx_serial_shutdown+0x18c/0x1d8)
[   74.592447] [<c0271498>] (s3c24xx_serial_shutdown) from
[<c026ab28>] (uart_port_shutdown+0x2c/0x38)
[   74.601472] [<c026ab28>] (uart_port_shutdown) from [<c026acc4>]
(uart_shutdown+0xac/0xec)
[   74.609630] [<c026acc4>] (uart_shutdown) from [<c026ae3c>]
(uart_close+0x64/0x1f0)
[   74.617184] [<c026ae3c>] (uart_close) from [<c0251544>]
(tty_release+0xf0/0x464)
[   74.624566] [<c0251544>] (tty_release) from [<c00cca38>] (__fput+0x80/0x1bc)
[   74.631594] [<c00cca38>] (__fput) from [<c00384d0>] (task_work_run+0xa8/0xdc)
[   74.638711] [<c00384d0>] (task_work_run) from [<c00118dc>]
(do_work_pending+0x94/0xb4)
[   74.646610] [<c00118dc>] (do_work_pending) from [<c000f54c>]
(work_pending+0xc/0x20)

Lockdep:

[  109.696678] #### Requested RX ee0d4a2c at TX ee0d4ac4
[  109.701699]
[  109.701928] =============================================
[  109.707310] [ INFO: possible recursive locking detected ]
[  109.712694] 4.2.0-rc1-00029-g1ce41c343055-dirty #111 Not tainted
[  109.718680] ---------------------------------------------
[  109.724063] swapper/0/0 is trying to acquire lock:
[  109.728836]  (&port_lock_key){-.-...}, at: [<c02ad78c>]
s3c24xx_serial_tx_dma_complete+0x8c/0xfc
[  109.737603]
[  109.737603] but task is already holding lock:
[  109.743418]  (&port_lock_key){-.-...}, at: [<c02ac014>]
s3c24xx_serial_tx_chars+0x18/0x180
[  109.751664]
[  109.751664] other info that might help us debug this:
[  109.758174]  Possible unsafe locking scenario:
[  109.758174]
[  109.764076]        CPU0
[  109.766507]        ----
[  109.768936]   lock(&port_lock_key);
[  109.772408]   lock(&port_lock_key);
[  109.775881]
[  109.775881]  *** DEADLOCK ***
[  109.775881]
[  109.781784]  May be due to missing lock nesting notation
[  109.781784]
[  109.788556] 1 lock held by swapper/0/0:
[  109.792373]  #0:  (&port_lock_key){-.-...}, at: [<c02ac014>]
s3c24xx_serial_tx_chars+0x18/0x180
[  109.801053]
[  109.801053] stack backtrace:
[  109.805399] CPU: 0 PID: 0 Comm: swapper/0 Not tainted
4.2.0-rc1-00029-g1ce41c343055-dirty #111
[  109.813988] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[  109.820084] [<c0015e9c>] (unwind_backtrace) from [<c0012c18>]
(show_stack+0x10/0x14)
[  109.827801] [<c0012c18>] (show_stack) from [<c0599b7c>]
(dump_stack+0x70/0xbc)
[  109.835003] [<c0599b7c>] (dump_stack) from [<c00649ec>]
(validate_chain.isra.24+0x7b4/0x8b8)
[  109.843419] [<c00649ec>] (validate_chain.isra.24) from [<c00656c4>]
(__lock_acquire+0x464/0xb28)
[  109.852185] [<c00656c4>] (__lock_acquire) from [<c0066100>]
(lock_acquire+0x6c/0x8c)
[  109.859915] [<c0066100>] (lock_acquire) from [<c05a0e68>]
(_raw_spin_lock_irqsave+0x48/0x5c)
[  109.868335] [<c05a0e68>] (_raw_spin_lock_irqsave) from [<c02ad78c>]
(s3c24xx_serial_tx_dma_complete+0x8c/0xfc)
[  109.878322] [<c02ad78c>] (s3c24xx_serial_tx_dma_complete) from
[<c027b57c>] (pl330_tasklet+0x16c/0x4cc)
[  109.887690] [<c027b57c>] (pl330_tasklet) from [<c02abf4c>]
(s3c24xx_serial_start_tx_dma+0x1a4/0x1f4)
[  109.896803] [<c02abf4c>] (s3c24xx_serial_start_tx_dma) from
[<c02ac154>] (s3c24xx_serial_tx_chars+0x158/0x180)
[  109.906784] [<c02ac154>] (s3c24xx_serial_tx_chars) from
[<c02ad5ec>] (s3c64xx_serial_handle_irq+0x34/0x60)
[  109.916424] [<c02ad5ec>] (s3c64xx_serial_handle_irq) from
[<c0070f7c>] (handle_irq_event_percpu+0x50/0x154)
[  109.926142] [<c0070f7c>] (handle_irq_event_percpu) from
[<c00710c0>] (handle_irq_event+0x40/0x64)
[  109.934995] [<c00710c0>] (handle_irq_event) from [<c0073fec>]
(handle_fasteoi_irq+0xdc/0x1a4)
[  109.943501] [<c0073fec>] (handle_fasteoi_irq) from [<c0070850>]
(generic_handle_irq+0x20/0x30)
[  109.952095] [<c0070850>] (generic_handle_irq) from [<c007096c>]
(__handle_domain_irq+0x6c/0xe4)
[  109.960774] [<c007096c>] (__handle_domain_irq) from [<c0009474>]
(gic_handle_irq+0x2c/0x68)
[  109.969105] [<c0009474>] (gic_handle_irq) from [<c0013744>]
(__irq_svc+0x44/0x7c)
[  109.976566] Exception stack(0xc085df28 to 0xc085df70)
[  109.981603] df20:                   00000001 00000001 00000000
c0860e78 8a83f452 00000019
[  109.989763] df40: 8a95ae3e 00000019 eef70490 c088b8c4 00000000
c088b8c4 00000000 c085df70
[  109.997919] df60: c0066a34 c04154b4 200b0013 ffffffff
[  110.002965] [<c0013744>] (__irq_svc) from [<c04154b4>]
(cpuidle_enter_state+0x1f8/0x28c)
[  110.011037] [<c04154b4>] (cpuidle_enter_state) from [<c005d464>]
(cpu_startup_entry+0x158/0x26c)
[  110.019804] [<c005d464>] (cpu_startup_entry) from [<c07f8c48>]
(start_kernel+0x370/0x3dc)
[  120.694973] BUG: spinlock lockup suspected on CPU#0, swapper/0/0
[  120.699509]  lock: s3c24xx_serial_ports+0x2dc/0x560, .magic:
dead4ead, .owner: swapper/0/0, .owner_cpu: 0
[  120.709050] CPU: 0 PID: 0 Comm: swapper/0 Not tainted
4.2.0-rc1-00029-g1ce41c343055-dirty #111
[  120.717638] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[  120.723727] [<c0015e9c>] (unwind_backtrace) from [<c0012c18>]
(show_stack+0x10/0x14)
[  120.731450] [<c0012c18>] (show_stack) from [<c0599b7c>]
(dump_stack+0x70/0xbc)
[  120.738652] [<c0599b7c>] (dump_stack) from [<c0069ca4>]
(do_raw_spin_lock+0x114/0x1a0)
[  120.746552] [<c0069ca4>] (do_raw_spin_lock) from [<c05a0e70>]
(_raw_spin_lock_irqsave+0x50/0x5c)
[  120.755321] [<c05a0e70>] (_raw_spin_lock_irqsave) from [<c02ad78c>]
(s3c24xx_serial_tx_dma_complete+0x8c/0xfc)
[  120.765304] [<c02ad78c>] (s3c24xx_serial_tx_dma_complete) from
[<c027b57c>] (pl330_tasklet+0x16c/0x4cc)
[  120.774675] [<c027b57c>] (pl330_tasklet) from [<c02abf4c>]
(s3c24xx_serial_start_tx_dma+0x1a4/0x1f4)
[  120.783788] [<c02abf4c>] (s3c24xx_serial_start_tx_dma) from
[<c02ac154>] (s3c24xx_serial_tx_chars+0x158/0x180)
[  120.793770] [<c02ac154>] (s3c24xx_serial_tx_chars) from
[<c02ad5ec>] (s3c64xx_serial_handle_irq+0x34/0x60)
[  120.803408] [<c02ad5ec>] (s3c64xx_serial_handle_irq) from
[<c0070f7c>] (handle_irq_event_percpu+0x50/0x154)
[  120.813128] [<c0070f7c>] (handle_irq_event_percpu) from
[<c00710c0>] (handle_irq_event+0x40/0x64)
[  120.821980] [<c00710c0>] (handle_irq_event) from [<c0073fec>]
(handle_fasteoi_irq+0xdc/0x1a4)
[  120.830486] [<c0073fec>] (handle_fasteoi_irq) from [<c0070850>]
(generic_handle_irq+0x20/0x30)
[  120.839080] [<c0070850>] (generic_handle_irq) from [<c007096c>]
(__handle_domain_irq+0x6c/0xe4)
[  120.847759] [<c007096c>] (__handle_domain_irq) from [<c0009474>]
(gic_handle_irq+0x2c/0x68)
[  120.856090] [<c0009474>] (gic_handle_irq) from [<c0013744>]
(__irq_svc+0x44/0x7c)
[  120.863550] Exception stack(0xc085df28 to 0xc085df70)
[  120.868588] df20:                   00000001 00000001 00000000
c0860e78 8a83f452 00000019
[  120.876748] df40: 8a95ae3e 00000019 eef70490 c088b8c4 00000000
c088b8c4 00000000 c085df70
[  120.884904] df60: c0066a34 c04154b4 200b0013 ffffffff
[  120.889946] [<c0013744>] (__irq_svc) from [<c04154b4>]
(cpuidle_enter_state+0x1f8/0x28c)
[  120.898019] [<c04154b4>] (cpuidle_enter_state) from [<c005d464>]
(cpu_startup_entry+0x158/0x26c)
[  120.906785] [<c005d464>] (cpu_startup_entry) from [<c07f8c48>]
(start_kernel+0x370/0x3dc)
