From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Mon, 12 Dec 2016 13:23:06 +0300
Subject: =?UTF-8?B?aW14LXNkbWEgVUFSVCBzZXJpZXMgZmFpbGVkIGZvciBpLk1YNTE=?=
Message-ID: <1481538186.727700380@f399.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello all.

Upgrading the kernel from version 4.7 (to latest) has resulted in inoperable for i.MX51 DMA.
It appears on sound playback (fsl_ssi with DMA). The sound is intermittent and a feeling that
the each sound channel eats a part of buffer from another channel.
Git-bisect found a first bad commit "first bad commit: [5881826ded79cf3c3314ee2d84c3bfa94e111b42]
dmaengine: imx-sdma - update the residue calculation for cyclic channels" and after revert this commit,
the problem has gone.

Additionally, I had to disable DMA for the UART, because the revert the patch above led to the
inoperability of the UART receiving part, although even before the series of all UART-SDMA
patches still functioned normally (with imx6q check commented out).

Any ideas?

Thanks.

shc at shc /home/ARM/linux $ git bisect log
git bisect start
# good: [c8d2bc9bc39ebea8437fd974fdbc21847bb897a3] Linux 4.8
git bisect good c8d2bc9bc39ebea8437fd974fdbc21847bb897a3
# bad: [2e972325da7a2984b9045844d4185f4406e7a4b0] Revert "USB debug"
git bisect bad 2e972325da7a2984b9045844d4185f4406e7a4b0
# bad: [41844e36206be90cd4d962ea49b0abc3612a99d0] Merge tag 'staging-4.9-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging
git bisect bad 41844e36206be90cd4d962ea49b0abc3612a99d0
# bad: [d268dbe76a53d72cc41316eb59e7968db60e77ad] Merge tag 'pinctrl-v4.9-1' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl
git bisect bad d268dbe76a53d72cc41316eb59e7968db60e77ad
# bad: [02bafd96f3a5d8e610b19033ffec55b92459aaae] Merge tag 'docs-4.9' of git://git.lwn.net/linux
git bisect bad 02bafd96f3a5d8e610b19033ffec55b92459aaae
# good: [9929780e86854833e649b39b290b5fe921eb1701] Merge tag 'driver-core-4.9-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core
git bisect good 9929780e86854833e649b39b290b5fe921eb1701
# bad: [77b0a4aa0732f1856aef85b8db085864e5971a14] Merge tag 'hwmon-for-linus-v4.9' of git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging
git bisect bad 77b0a4aa0732f1856aef85b8db085864e5971a14
# good: [f21ca2c9999872da113a1fc70abb527129b72af3] Merge tag 'usb-ci-v4.9-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/peter.chen/usb into usb-testing
git bisect good f21ca2c9999872da113a1fc70abb527129b72af3
# bad: [e6dce825fba05f447bd22c865e27233182ab3d79] Merge tag 'tty-4.9-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty
git bisect bad e6dce825fba05f447bd22c865e27233182ab3d79
# bad: [5d7519dfc963ec8b6a10a51356840580fc005a1e] serial: mxs-auart: Disable clock on error path
git bisect bad 5d7519dfc963ec8b6a10a51356840580fc005a1e
# good: [a13e19cf3dc1080cf8a3a174cefd9199610faed7] serial: 8250_lpss: split LPSS driver to separate module
git bisect good a13e19cf3dc1080cf8a3a174cefd9199610faed7
# skip: [5d9b9530e36bca7cd8306c5097623692e1134c39] tty: serial: jsm_tty: constify uart_ops structures
git bisect skip 5d9b9530e36bca7cd8306c5097623692e1134c39
# skip: [fecdef932b0093b4a7e1ae88b1dbd63eb74ecc34] serial: 8250_lpss: enable DMA on Intel Quark UART
git bisect skip fecdef932b0093b4a7e1ae88b1dbd63eb74ecc34
# skip: [5c7dcdb60d88e4d68bc59eff7c6a5c418808552b] tty/serial: at91: constify uart_ops structures
git bisect skip 5c7dcdb60d88e4d68bc59eff7c6a5c418808552b
# bad: [b53761e36a509609e91a797fa63648ec43aecc13] Merge 4.8-rc5 into tty-next
git bisect bad b53761e36a509609e91a797fa63648ec43aecc13
# skip: [03bd797f33ddbe1d14de7abc70a9dd21b2a12d3f] serial: altera: constify uart_ops structures
git bisect skip 03bd797f33ddbe1d14de7abc70a9dd21b2a12d3f
# skip: [e06b6b854163a7f9931d6e0d859b9378a23fe7af] serial: 8250_dw: add ACPI support for uart on Hisilicon Hip05 SoC
git bisect skip e06b6b854163a7f9931d6e0d859b9378a23fe7af
# skip: [eeb8bc1a92751557d3eea69d54e1b422569e7238] serial: st-asc: constify uart_ops structures
git bisect skip eeb8bc1a92751557d3eea69d54e1b422569e7238
# good: [15f30f513111528c5b0c6185b2bfb7b1a58a6499] dmaengine: imx-sdma - reduce transfer latency for DMA cyclic clients
git bisect good 15f30f513111528c5b0c6185b2bfb7b1a58a6499
# bad: [069a47e5adfd5a1544c3c6d87a36889a691ea156] tty: serial: constify uart_ops structures
git bisect bad 069a47e5adfd5a1544c3c6d87a36889a691ea156
# bad: [8232884e2dfa606edef66b2c889d4d2ebe042cb8] serial/arc: constify uart_ops structures
git bisect bad 8232884e2dfa606edef66b2c889d4d2ebe042cb8
# bad: [41d98b5da92f8b7bd11885e7c4797197b5f3e2c3] serial: imx-serial - update RX error counters when DMA is used
git bisect bad 41d98b5da92f8b7bd11885e7c4797197b5f3e2c3
# bad: [5881826ded79cf3c3314ee2d84c3bfa94e111b42] dmaengine: imx-sdma - update the residue calculation for cyclic channels
git bisect bad 5881826ded79cf3c3314ee2d84c3bfa94e111b42
# first bad commit: [5881826ded79cf3c3314ee2d84c3bfa94e111b42] dmaengine: imx-sdma - update the residue calculation for cyclic channels

---
