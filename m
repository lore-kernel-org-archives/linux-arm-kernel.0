From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 11 May 2017 16:01:54 +0200
Subject: [PATCH] pinctrl: use non-devm kmalloc versions for free functions
In-Reply-To: <1493855857-4453-1-git-send-email-andre.przywara@arm.com>
References: <1493855857-4453-1-git-send-email-andre.przywara@arm.com>
Message-ID: <CACRpkdasvjBPcr5RrPwtTYaoGeTEJMWqXbSRaB5-cOEKXbpfRg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 4, 2017 at 1:57 AM, Andre Przywara <andre.przywara@arm.com> wrote:

> When a pinctrl driver gets interrupted during its probe process
> (returning -EPROBE_DEFER), the devres system cleans up all allocated
> resources. During this process it calls pinmux_generic_free_functions()
> and pinctrl_generic_free_groups(), which in turn use managed kmalloc
> calls for temporarily allocating some memory. Now those calls seem to
> get added to the devres list, but are apparently not covered by the
> cleanup process, because this is actually just running and iterating the
> existing list. This leads to those mallocs being left with the device,
> which the devres manager complains about when the driver eventually gets
> probed again:
> [    0.825239] ------------[ cut here ]------------
> [    0.825256] WARNING: CPU: 1 PID: 89 at drivers/base/dd.c:349 driver_probe_device+0x2ac/0x2e8
> [    0.825258] Modules linked in:
> [    0.825262]
> [    0.825270] CPU: 1 PID: 89 Comm: kworker/1:1 Not tainted 4.11.0 #307
> [    0.825272] Hardware name: Pine64+ (DT)
> [    0.825283] Workqueue: events deferred_probe_work_func
> [    0.825288] task: ffff80007c19c100 task.stack: ffff80007c16c000
> [    0.825292] PC is at driver_probe_device+0x2ac/0x2e8
> [    0.825296] LR is at driver_probe_device+0x108/0x2e8
> [    0.825300] pc : [<ffff000008559234>] lr : [<ffff000008559090>] pstate: 20000045
> ....
> This warning is triggered because the devres list is not empty. In this
> case the allocations were using 0 bytes, so no real leaks, but still this
> ugly warning.
> Looking more closely at these *cleanup* functions, devm_kzalloc() is actually
> not needed, because the memory is just allocated temporarily and can be
> freed just before returning from this function.
> So fix this issue by using the bog standard kcalloc() call instead of
> devm_kzalloc() and kfree()ing the memory at the end.
>
> This fixes above warnings on boot, which can be observed on *some* builds
> for the Pine64, where the pinctrl driver gets loaded early, but it missing
> resources, so gets deferred and is loaded again (successfully) later.
> kernelci caught this as well [1].
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>
> [1] https://storage.kernelci.org/net-next/master/v4.11-rc8-2122-gc08bac03d289/arm64/defconfig/lab-baylibre-seattle/boot-sun50i-a64-pine64-plus.html
> ---
> Hi,
>
> not sure this is the right fix, I am open to suggestions.

I have queued this as a tentative v4.12-rc1 fix, but a bit undertain.

Tejun, do I read your comments on the patch as an ACK?

Yours,
Linus Walleij
