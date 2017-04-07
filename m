From: jbrunet@baylibre.com (Jerome Brunet)
Date: Fri,  7 Apr 2017 17:34:31 +0200
Subject: [PATCH v2 0/2] clk: meson: MPLL fixes for Meson8b
Message-ID: <20170407153433.18640-1-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MPLL clocks have been recently added to the Meson8b clock driver: [0]

On meson8b boards this unfortunately causes a division by zero error which
is fixed by patch #1 in this series.

While investigating this I found that there also seems to be a 32bit
overflow in the calculation in rate_from_params(), which is fixed by
patch #2 in this series.

Changes since v1: [1]
 - Return an error code when the mpll parameters are out of the specified
   range.
 - As agreed with martin, use DIV_ROUND_UP_ULL instead of mul_u64_u32_div.

[0] http://lists.infradead.org/pipermail/linux-amlogic/2017-March/002757.html
[1] https://lkml.kernel.org/r/20170401130225.8811-1-martin.blumenstingl at googlemail.com

Martin Blumenstingl (2):
  clk: meson: mpll: fix division by zero in rate_from_params
  clk: meson: mpll: use 64bit math in rate_from_params

 drivers/clk/meson/clk-mpll.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

-- 
2.9.3
