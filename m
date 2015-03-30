From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Mon, 30 Mar 2015 17:53:20 +0200
Subject: [RFC PATCH v3 0/2] ARM: EXYNOS: Fix Suspend-to-RAM on Exynos5420
Message-ID: <1427730803-28635-1-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series is a 3rd version of a RFC to fix Suspend-to-RAM on Exynos5420.
Abhilash Kesavan traced down to the MDMA0 DMA controller clock needed to
be enabled during suspend in order to make the system resume correctly.

I posted a RFC that grabbed the clock in the Exynos5420 specific suspend
and resume callbacks [0] and a re-spin [1] but was asked by Abhilash and
Chanwoo to do it in the clock driver instead.

So this series is an attempt to fix the issue and is composed of patches:

Javier Martinez Canillas (2):
  clk: samsung: Add a clock lookup function
  clk: exynos5420: Make sure MDMA0 clock is enabled during suspend

 drivers/clk/samsung/clk-exynos5420.c | 26 ++++++++++++++++++++++++--
 drivers/clk/samsung/clk.c            |  6 ++++++
 drivers/clk/samsung/clk.h            |  3 +++
 3 files changed, 33 insertions(+), 2 deletions(-)

Patch #1 just adds a function to lookup the provider clock instances.

Patch #2 enables the MDMA0 clock before entering into a suspend state and
disables it again once the system has been resumed.

The patches are again an RFC because I'm not sure if this is the best
approach to solve the issue. So feedback will be highly appreciated.

Best regards,
Javier

[0]: https://lkml.org/lkml/2015/3/27/397
[1]: https://lkml.org/lkml/2015/3/27/770
