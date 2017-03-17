From: horia.geanta@nxp.com (=?UTF-8?q?Horia=20Geant=C4=83?=)
Date: Fri, 17 Mar 2017 12:05:55 +0200
Subject: [PATCH 0/7] crypto: caam - add Queue Interface (QI) support
Message-ID: <20170317100602.2837-1-horia.geanta@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

RFC -> v1:
-rebased on latest cryptodev-2.6 tree
open-code tsk_cpus_allowed() - sync with commit
0c98d344fe5c "sched/core: Remove the tsk_cpus_allowed() wrapper"
-addressed Scott's feedback - removed most of the accessors
added in soc/qman (patch 4) and instead open-coded them in caam/qi


The patchset adds support for CAAM Queue Interface (QI), the additional
interface (besides job ring) available for submitting jobs to the engine
on platforms having DPAA (Datapath Acceleration Architecture).

Patches 1-4 are QMan dependencies.
During RFC stage, we agreed to go with them through the crypto tree:
https://www.mail-archive.com/linux-crypto at vger.kernel.org/msg24105.html

Patch 5 adds a missing double inclusion guard in desc_constr.h.

Patch 6 adds the caam/qi job submission backend.

Patch 7 adds algorithms (ablkcipher and authenc) that run on top
of caam/qi. For now, their priority is set lower than caam/jr.

Thanks,
Horia

Horia Geant? (7):
  soc/qman: export volatile dequeue related structs
  soc/qman: add dedicated channel ID for CAAM
  soc/qman: export non-programmable FQD fields query
  soc/qman: add macros needed by caam/qi driver
  crypto: caam - avoid double inclusion in desc_constr.h
  crypto: caam - add Queue Interface (QI) backend support
  crypto: caam/qi - add ablkcipher and authenc algorithms

 drivers/crypto/caam/Kconfig        |   20 +-
 drivers/crypto/caam/Makefile       |    5 +
 drivers/crypto/caam/caamalg.c      |    9 +-
 drivers/crypto/caam/caamalg_desc.c |   77 +-
 drivers/crypto/caam/caamalg_desc.h |   15 +-
 drivers/crypto/caam/caamalg_qi.c   | 2387 ++++++++++++++++++++++++++++++++++++
 drivers/crypto/caam/ctrl.c         |   58 +-
 drivers/crypto/caam/desc_constr.h  |    5 +
 drivers/crypto/caam/intern.h       |   24 +
 drivers/crypto/caam/qi.c           |  805 ++++++++++++
 drivers/crypto/caam/qi.h           |  201 +++
 drivers/crypto/caam/sg_sw_qm.h     |  108 ++
 drivers/soc/fsl/qbman/qman.c       |    4 +-
 drivers/soc/fsl/qbman/qman_ccsr.c  |    6 +-
 drivers/soc/fsl/qbman/qman_priv.h  |   97 --
 include/soc/fsl/qman.h             |  109 ++
 16 files changed, 3786 insertions(+), 144 deletions(-)
 create mode 100644 drivers/crypto/caam/caamalg_qi.c
 create mode 100644 drivers/crypto/caam/qi.c
 create mode 100644 drivers/crypto/caam/qi.h
 create mode 100644 drivers/crypto/caam/sg_sw_qm.h

-- 
2.12.0.264.gd6db3f216544
