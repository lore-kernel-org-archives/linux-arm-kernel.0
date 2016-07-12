From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 12 Jul 2016 17:19:25 +0100
Subject: [PATCH 0/2] core: Ensure drivers are given a chance to re-probe()
 late-on
Message-ID: <20160712161927.7521-1-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If a driver's resources are not available at probe() time, it is
common practice to defer probe (return -EPROBE_DEFER) until a time
where the required dependencies have been satisfied.  However, if a
driver's resources are not provided by other drivers probe()ing
e.g. in a case where a driver is waiting for initramfs or rootfs to
be mounted in order to retrieve firmware located within, then
eventually we will run out of binding drivers (the trigger to re-run
deferred driver's probe()), and another re-probe() opportunity will
not be given.

This patch ensures that all drivers still on the deferred list are
given at least one more shot at probe()ing very late on in boot.  This
ensures drivers who find themselves in the position explained in the
aforementioned example are able to locate their resources, resulting
in a successful probe().

Lee Jones (2):
  driver-core: Add externally callable function to trigger deferred
    probes
  init/main: Trigger re-execution of deferred deferred probe()s

 drivers/base/dd.c      | 8 ++++++++
 include/linux/device.h | 1 +
 init/main.c            | 1 +
 3 files changed, 10 insertions(+)

-- 
2.9.0
