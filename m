From: broonie@kernel.org (Mark Brown)
Date: Tue, 30 Jul 2013 12:45:02 +0100
Subject: [PATCH 0/5] Optional regulator support
Message-ID: <20130730114502.GQ9858@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds a variant of regulator_get() which allows
regulator consumers to tell the core that the supply they are requesting
may genuinely be absent in the system.  The goal is to help address some
of the problems with handling errors in regulator_get() in drivers that
are newly converted to the regulator API by allowing the core to provide
stub regulators for supplies that aren't hooked up without disrupting
the operation of drivers like MMC drivers which may genuinely not have
some of their supplies hooked up.

Currently the code simply introduces a new API call with exactly the
same implementation as regulator_get() so there should be zero impact
from the series other than a slightly larger kernel.

Right now all the MMC users are converted over as-is, though it does
look like drivers such as sdhci really ought to be insisting on having a
regulator for VMMC in the same way that the MMC core helper does (and
indeed in that case it looks like it ought to be converted over to the
core code).

If this series is OK I'd like to merge it via the regulator tree so that
the functionality to make use of the optional regulators can be built
out on top of it.

Mark Brown (5):
      regulator: core: Provide hints to the core about optional supplies
      mmc: core: Indicate that vmmcq may be absent
      mmc: sdhci: Indicate that regulators may be absent
      mmc: dw_mmc: Indicate that regulators may be absent
      mmc: pxamci: Indicate that regulators may be absent

 drivers/mmc/core/core.c            |  2 +-
 drivers/mmc/host/dw_mmc.c          |  2 +-
 drivers/mmc/host/pxamci.c          |  2 +-
 drivers/mmc/host/sdhci.c           |  4 +--
 drivers/regulator/core.c           | 59 ++++++++++++++++++++++++++++++++++++++
 include/linux/regulator/consumer.h | 18 +++++++++++-
 6 files changed, 81 insertions(+), 6 deletions(-)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130730/ff9caa64/attachment-0001.sig>
