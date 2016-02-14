From: linux.amoon@gmail.com (Anand Moon)
Date: Mon, 15 Feb 2016 00:42:12 +0530
Subject: lockdep: INFO: possible irq lock inversion dependency detected on
 Odroid U3
In-Reply-To: <56C0404E.7080707@samsung.com>
References: <CANAwSgRgFMNWGhTe7xsHqkQQ1JS0XW6pO8LT8c6rZm=3cEBcbg@mail.gmail.com>
 <56C0404E.7080707@samsung.com>
Message-ID: <CANAwSgS1KPwDCn5eQr0VqTWDNW2T2oykmYr+0rdMCza6C+BPSw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof

On 14 February 2016 at 14:22, Krzysztof Kozlowski
<k.kozlowski@samsung.com> wrote:
> W dniu 10.02.2016 o 16:27, Anand Moon pisze:
>> Hi all,
>>
>> I am observing following lockdep info.
>
> Hi,
>
> Thanks for report. When pasting dmesg output, please do not wrap the
> lines because it is difficult to read it.
>
> This looks like known issue:
> https://wiki.tizen.org/wiki/Exynos_Mainline_Kernel_TODO/Odroid_XU3_lockdep_warn_during_music_playback
>
> Waiting for someone brave enough to fix it...
>
> But actually more important item is following real lockup, failing
> multi_v7 boot ~20% of times:
> http://www.krzk.eu/builders/boot-odroid-xu3-multi_v7/builds/34
> http://www.krzk.eu/builders/boot-odroid-xu3-multi_v7
>
> Best regards,
> Krzysztof
>

I have manage to fix the issue using below changes.

root at odroidu3:/usr/src/odroidxu3-4.y-devel# git diff drivers/dma/pl330.c
diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 17ee758..b651443 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -1973,10 +1973,9 @@ static void pl330_tasklet(unsigned long data)
 {
        struct dma_pl330_chan *pch = (struct dma_pl330_chan *)data;
        struct dma_pl330_desc *desc, *_dt;
-       unsigned long flags;
        bool power_down = false;

-       spin_lock_irqsave(&pch->lock, flags);
+       spin_lock_irq(&pch->lock);

        /* Pick up ripe tomatoes */
        list_for_each_entry_safe(desc, _dt, &pch->work_list, node)
@@ -2028,12 +2027,12 @@ static void pl330_tasklet(unsigned long data)
                dma_descriptor_unmap(&desc->txd);

                if (callback) {
-                       spin_unlock_irqrestore(&pch->lock, flags);
+                       spin_unlock_irq(&pch->lock);
                        callback(callback_param);
-                       spin_lock_irqsave(&pch->lock, flags);
+                       spin_lock_irq(&pch->lock);
                }
        }
-       spin_unlock_irqrestore(&pch->lock, flags);
+       spin_unlock_irq(&pch->lock);

        /* If work list empty, power down */
        if (power_down) {
@@ -2091,10 +2090,10 @@ static int pl330_alloc_chan_resources(struct
dma_chan *chan)
                return -ENOMEM;
        }

-       tasklet_init(&pch->task, pl330_tasklet, (unsigned long) pch);
-
        spin_unlock_irqrestore(&pch->lock, flags);

+       tasklet_init(&pch->task, pl330_tasklet, (unsigned long) pch);
+
        return 1;
 }

------
Test on Odroid U3.

But below changes introduce below WARNING.

[   14.818967] ------------[ cut here ]------------
[   14.819517] WARNING: CPU: 0 PID: 486 at
kernel/locking/lockdep.c:2608 _raw_spin_unlock_irq+0x24/0x5c()
[   14.828791] DEBUG_LOCKS_WARN_ON(current->hardirq_context)
[   14.833995] Modules linked in:
[   14.837209] CPU: 0 PID: 486 Comm: plymouth Tainted: G        W
 4.5.0-rc3-xu3s #55
[   14.845191] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[   14.851282] [<c0016eac>] (unwind_backtrace) from [<c0013b30>]
(show_stack+0x10/0x14)
[   14.859001] [<c0013b30>] (show_stack) from [<c02943e4>]
(dump_stack+0x98/0xc4)
[   14.866204] [<c02943e4>] (dump_stack) from [<c0029fcc>]
(warn_slowpath_common+0x80/0xb0)
[   14.874273] [<c0029fcc>] (warn_slowpath_common) from [<c002a02c>]
(warn_slowpath_fmt+0x30/0x40)
[   14.882956] [<c002a02c>] (warn_slowpath_fmt) from [<c068029c>]
(_raw_spin_unlock_irq+0x24/0x5c)
[   14.891637] [<c068029c>] (_raw_spin_unlock_irq) from [<c02ef1c8>]
(pl330_tasklet+0x1a8/0x504)
[   14.900142] [<c02ef1c8>] (pl330_tasklet) from [<c0325028>]
(s3c24xx_serial_start_tx_dma+0x154/0x198)
[   14.909253] [<c0325028>] (s3c24xx_serial_start_tx_dma) from
[<c032526c>] (s3c24xx_serial_tx_chars+0x200/0x204)
[   14.919236] [<c032526c>] (s3c24xx_serial_tx_chars) from
[<c03265a8>] (s3c64xx_serial_handle_irq+0x34/0x60)
[   14.928873] [<c03265a8>] (s3c64xx_serial_handle_irq) from
[<c0087e48>] (handle_irq_event_percpu+0x9c/0x150)
[   14.938593] [<c0087e48>] (handle_irq_event_percpu) from
[<c0087f34>] (handle_irq_event+0x38/0x5c)
[   14.947446] [<c0087f34>] (handle_irq_event) from [<c008b1f4>]
(handle_fasteoi_irq+0xd0/0x1a8)
[   14.955952] [<c008b1f4>] (handle_fasteoi_irq) from [<c0087464>]
(generic_handle_irq+0x24/0x34)
[   14.964545] [<c0087464>] (generic_handle_irq) from [<c0087778>]
(__handle_domain_irq+0x7c/0xec)
[   14.973225] [<c0087778>] (__handle_domain_irq) from [<c0009514>]
(gic_handle_irq+0x54/0x94)
[   14.981557] [<c0009514>] (gic_handle_irq) from [<c0014638>]
(__irq_svc+0x58/0x98)
[   14.989019] Exception stack(0xed385e90 to 0xed385ed8)
[   14.994055] 5e80:                                     00000000
2e07c000 00000000 edb4e480
[   15.002215] 5ea0: 00000053 c136c014 ed048780 ed048800 c136c014
c0adb108 ed048000 00000002
[   15.010373] 5ec0: 00000000 ed385ee0 c0076edc c0680274 20000053 ffffffff
[   15.016973] [<c0014638>] (__irq_svc) from [<c0680274>]
(_raw_spin_unlock_irqrestore+0x70/0x74)
[   15.025569] [<c0680274>] (_raw_spin_unlock_irqrestore) from
[<c02bd7a4>] (__debug_check_no_obj_freed+0x128/0x220)
[   15.035811] [<c02bd7a4>] (__debug_check_no_obj_freed) from
[<c0127940>] (kmem_cache_free+0x150/0x1ec)
[   15.045011] [<c0127940>] (kmem_cache_free) from [<c002bd70>]
(do_exit+0x32c/0xaf4)
[   15.052560] [<c002bd70>] (do_exit) from [<c002dbc0>]
(do_group_exit+0x3c/0xbc)
[   15.059764] [<c002dbc0>] (do_group_exit) from [<c002dc50>]
(__wake_up_parent+0x0/0x18)
[   15.067660] ---[ end trace 27c09e22f2a7458b ]---

Any comments are valuable.

Best Regards.
-Anand Moon
