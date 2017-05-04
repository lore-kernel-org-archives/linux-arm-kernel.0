From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Thu,  4 May 2017 20:19:18 +0200
Subject: [PATCH v2 0/2] remove the "cpu_clk" from the GXBB/GXL/GXM driver
In-Reply-To: <20170401125519.7339-1-martin.blumenstingl@googlemail.com>
References: <20170401125519.7339-1-martin.blumenstingl@googlemail.com>
Message-ID: <20170504181920.21880-1-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The quick summary for this patch is that the "cpu_clk" seems to have
been copied from the Meson8b clock driver when the GXBB clock driver
was initially added. However, on GXBB (and the other GX SoCs) the
actual CPU clock is provided by a SCPI DVFS clock.
More details can be found in the description of the actual patch (#2).

This was tested on a Khadas VIM board (GXL S905X).


Changes since v1:
- split the patch into two patches: one which un-exports the clock ID
  first and a second which does the actual cleanup. This was done based
  on the recent discussion that new clocks should be added first and then
  exported in a second patch (this patch does the same, just the other
  way round: un-exporting first, then removing the actual clock)

Changes since the RFC version from [0]:
- rebased to the "clk-meson" branch (e65ae3fb97b4 "dt-bindings: clock:
  gxbb-clkc: Add GXL compatible variant") and Jerome's audio clock
  patches (in version 2: [1])
- remove the now unused cpu_div_table (which was left over in the RFC
  version)
- slightly updated the comment for the now unused clock ID 1 in
  drivers/clk/meson/gxbb.h


[0] https://patchwork.kernel.org/patch/9644993/
[1] http://lists.infradead.org/pipermail/linux-amlogic/2017-March/003200.html

Martin Blumenstingl (2):
  clk: meson-gxbb: un-export the CPU clock
  clk: meson: gxbb: remove the "cpu_clk" from the GXBB and GXL driver

 drivers/clk/meson/gxbb.c              | 64 ++---------------------------------
 drivers/clk/meson/gxbb.h              |  2 +-
 include/dt-bindings/clock/gxbb-clkc.h |  1 -
 3 files changed, 4 insertions(+), 63 deletions(-)

-- 
2.12.2
