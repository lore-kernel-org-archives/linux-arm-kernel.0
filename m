From: pranavkumar@linaro.org (Pranavkumar Sawargaonkar)
Date: Mon,  6 May 2013 17:49:48 +0530
Subject: [PATCH V2 0/3] Emergency write support for virtio console devices.
Message-ID: <1367842791-30285-1-git-send-email-pranavkumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch-set implements early printk support for virtio console
devices by adding and using emergency write register to virtio console's 
config space.

The current virtio early printk code in kernel expects that hypervisor 
will provide some mechanism generally a hypercall to support early printk. 
This patch-set does not break existing hypercall based early print support.

This implementation adds:
1. Emergency writeonly register named emerg_wr in 
   virtio console's config space.
2. Host feature flags namely VIRTIO_CONSOLE_F_EMERG_WRITE
   for telling guest about early-write capability in console device.

Emergency write mechanism:
1. When a guest wants to out some character, it has to simply write 
   the character to emerg_wr register in config space of 
   virtio console device.

Pranavkumar Sawargaonkar (3):
  virtio: console: Add emergency writeonly register to config space
  Documentation: virtio: Add emergency write (emerg_wr) config register
        in virtio console.
  arm64: earlyprintk support for virtio-mmio console.

 Documentation/virtual/virtio-spec.txt |    8 +++++++-
 arch/arm64/kernel/early_printk.c      |   35 +++++++++++++++++++++++++++++++++
 include/uapi/linux/virtio_console.h   |    3 +++
 3 files changed, 45 insertions(+), 1 deletion(-)

-- 
1.7.9.5
