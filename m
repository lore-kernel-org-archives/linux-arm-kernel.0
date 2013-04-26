From: agraf@suse.de (Alexander Graf)
Date: Fri, 26 Apr 2013 13:19:50 +0200
Subject: [PATCH 0/2] Early printk support for virtio console devices.
In-Reply-To: <1366974299-17877-1-git-send-email-pranavkumar@linaro.org>
References: <1366974299-17877-1-git-send-email-pranavkumar@linaro.org>
Message-ID: <BA2076A6-0688-4E5C-85F9-A9CA8FD75782@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 26.04.2013, at 13:04, Pranavkumar Sawargaonkar wrote:

> This patch-set implements early printk support for virtio console devices without using any hypercalls.
> 
> The current virtio early printk code in kernel expects that hypervisor will provide some mechanism generally a hypercall to support early printk. This patch-set does not break existing hypercall based early print support.
> 
> This implementation adds:
> 1. Early writeonly register named early_wr in virtio console's config space.
> 2. Host feature flags namely VIRTIO_CONSOLE_F_EARLY_WRITE for telling guest about early-write capability in console device.
> 
> Early write mechanism:
> 1. When a guest wants to out some character, it has to simply write the character to early_wr register in config space of virtio console device.

I won't nack this patch set, but I'll definitely express that I'm not happy with it.

MMIO registers are handled by a different layer than the virtio console itself. After the virtio refactoring in QEMU, they will be completely separate drivers. So we'll be in a similar mess with early printk as we are on the s390-virtio machine, where early printk is done through hypercalls and thus we can't directly link it to the console output.

I still don't see what the issue is with just implementing a small irq-less virtio driver for early printk.


Alex
