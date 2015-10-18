From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Sun, 18 Oct 2015 18:21:13 -0400
Subject: [PATCH 0/5] drivers/tty: make more bool drivers explicitly non-modular
Message-ID: <1445206878-12455-1-git-send-email-paul.gortmaker@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This next set of patches to drivers/tty fixes up more drivers that would
perhaps appear modular when looking at the code, but are controlled by
a bool Kconfig.  We make sure they don't look modular and get rid
of module related code in the drivers that would never be used.

The one common thread here for all the patches is that we also
scrap the .remove functions which would only be used for module
unload (impossible) and driver unbind.  For the drivers here, there
doesn't seem to be a sensible unbind use case (vs. e.g. a multiport
PCI ethernet driver where one port is unbound and passed through to
a kvm guest or similar).  Hence we just explicitly disallow any
driver unbind operations to help prevent root from doing something
illogical to the machine that they could have done previously.

We've already done this for drivers/tty/serial/mpsc.c previously.

Build tested for allmodconfig on ARM64 and powerpc for tty/tty-testing.

Paul.

---

Cc: Andy Gross <agross@codeaurora.org>
Cc: Anton Blanchard <anton@samba.org>
Cc: David Brown <davidb@codeaurora.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Kumar Gala <galak@codeaurora.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-arm-msm at vger.kernel.org
Cc: linux-mediatek at lists.infradead.org
Cc: linuxppc-dev at lists.ozlabs.org
Cc: linux-serial at vger.kernel.org
Cc: linux-soc at vger.kernel.org

Paul Gortmaker (5):
  drivers/tty: make hvc/hvc_vio.c explicitly non-modular
  drivers/tty: make ehv_bytechan.c explicitly non-modular
  drivers/tty/serial: make serial/atmel_serial.c explicitly non-modular
  drivers/tty/serial: make msm_serial.c explicitly non-modular
  drivers/tty/serial: make 8250/8250_mtk.c explicitly non-modular

 drivers/tty/ehv_bytechan.c         | 40 +++------------------------------
 drivers/tty/hvc/hvc_vio.c          | 29 ++++--------------------
 drivers/tty/serial/8250/8250_mtk.c | 35 ++++++-----------------------
 drivers/tty/serial/atmel_serial.c  | 45 ++++----------------------------------
 drivers/tty/serial/msm_serial.c    | 30 ++++---------------------
 5 files changed, 22 insertions(+), 157 deletions(-)

-- 
2.6.1
