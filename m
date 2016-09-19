From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 19 Sep 2016 10:47:46 +0200
Subject: [PATCH v2] ARM: dts: exynos: Add entries for sound support on
 Odroid-XU board
In-Reply-To: <20160917200017.GA13666@kozik-lap>
References: <CGME20160916112217eucas1p1694395dda2a1e8cdf562007ed8141542@eucas1p1.samsung.com>
 <1474024920-32744-1-git-send-email-s.nawrocki@samsung.com>
 <f4d204d8-b6b8-5173-c530-bfea1ec9ed7d@samsung.com>
 <71286ef8-4b7f-cfde-7bb9-9f3bd2289527@samsung.com>
 <20160917200017.GA13666@kozik-lap>
Message-ID: <5fef2bec-adcf-0230-cd00-7fc29cbbcd32@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/17/2016 10:00 PM, Krzysztof Kozlowski wrote:
> On Fri, Sep 16, 2016 at 01:58:32PM +0200, Krzysztof Kozlowski wrote:
>> > On 09/16/2016 01:25 PM, Sylwester Nawrocki wrote:
>>> > > On 09/16/2016 01:22 PM, Sylwester Nawrocki wrote:
>>>> > >> This patch adds device nodes for the AUDSS clock controller,
>>>> > >> peripheral DMA 0/1 controllers and the Audio Subsystem I2S controller.
>>>> > >> These entries are required for sound support on Odroid-XU board.
>>>> > >>
>>>> > >> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
>>>> > >> ---
>>>> > >> This patch depends on a patch adding clock ID macro definitions.
>>>> > >> I'm going to provide a topic branch containing required changes.
>>>> > >>
>>>> > >> Changes since v1:
>>>> > >>  - GIC_SPI, IRQ_TYPE_NONE used in the PDMA and max98080 interrupt
>>>> > >>    specifiers,
>>>> > >>  - assigned-clock-* properties moved to respective controller
>>>> > >>    nodes.
>>> > > 
>>> > > And here is a pull request containing clk dependency patches:
>>> > > 
>>> > > The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:
>>> > > 
>>> > >   Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)
>>> > > 
>>> > > are available in the git repository at:
>>> > > 
>>> > >   git://linuxtv.org/snawrocki/samsung.git tags/clk-v4.9-exynos54x0-dt
>>> > > 
>>> > > for you to fetch changes up to 58d6506f327e3d192998ba03632f546da221b8d8:
>>> > > 
>>> > >   clk: samsung: exynos5410: Add clock IDs for PDMA and EPLL clocks (2016-09-09
>>> > > 10:13:02 +0200)
>>> > > 
>> > 
>> > Pulled and applied, thanks!
>
> This does not boot...
> http://www.krzk.eu/builders/boot-odroid-xu-exynos/builds/216
> http://www.krzk.eu/builders/boot-odroid-xu-multi_v7/builds/195
> 
> I am going to send pull request this weekend (or Monday) so probably this
> won't be included. If by any chance you prepare a fix soon, then it
> will save me from rebasing the branch.

Oops, indeed, I didn't test with just that part of clk changes applied.
The only resolution here I can see is to pull my whole clk branch,
it has already been pulled to the upstream clk tree.

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  git://linuxtv.org/snawrocki/samsung.git tags/clk-v4.9-samsung

for you to fetch changes up to be95d2c7d918b2b7b973378a1e92bdc6559c21f9:

  clk: samsung: Add support for EPLL on exynos5410 (2016-09-09 17:35:13 +0200)

----------------------------------------------------------------
In addition to a few clean up and code consolidation patches this
includes:
- addition of sound subsystem related clocks for Exynos5410 SoC
  (EPLL, PDMA) and support for "samsung,exynos5410-audss-clock"
  compatible in the clk-exynos-audss driver,
- addition of DRAM controller related clocks for exynos5420,
- MAINTAINERS update adding Chanwoo Choi as the Samsung SoC
  clock drivers co-maintainer.

----------------------------------------------------------------
Chanwoo Choi (5):
      clk: samsung: Add clock IDs for the CMU_CDREX (DRAM Express Controller)
      MAINTAINERS: Add myself as Samsung SoC clock drivers co-maintainer
      clk: samsung: exynos5260: Move struct samsung_cmu_info to init section
      clk: samsung: exynos5410: Use samsung_cmu_register_one() to simplify code
      clk: samsung: exynos5420: Add clocks for CMU_CDREX domain

Sylwester Nawrocki (7):
      clk: samsung: exynos5410: Add clock IDs for PDMA and EPLL clocks
      clk: samsung: exynos5410: Expose the peripheral DMA gate clocks
      clk: samsung: Use common registration function for pll2550x
      clk: samsung: clk-exynos-audss: controller variant handling rework
      clk: samsung: clk-exynos-audss: Add exynos5410 compatible
      clk: samsung: clk-exynos-audss: Whitespace and debug trace cleanup
      clk: samsung: Add support for EPLL on exynos5410

 .../devicetree/bindings/clock/clk-exynos-audss.txt  |   4 +-
 .../devicetree/bindings/clock/exynos5410-clock.txt  |  21 +-
 MAINTAINERS                                         |   3 +
 drivers/clk/samsung/clk-exynos-audss.c              |  84 +++--
 drivers/clk/samsung/clk-exynos5260.c                | 350 ++++++++++-----------
 drivers/clk/samsung/clk-exynos5410.c                |  61 ++--
 drivers/clk/samsung/clk-exynos5420.c                |  37 +++
 drivers/clk/samsung/clk-exynos5440.c                |   9 +-
 drivers/clk/samsung/clk-pll.c                       | 154 ++++++---
 drivers/clk/samsung/clk-pll.h                       |   2 +
 include/dt-bindings/clock/exynos5410.h              |   3 +
 include/dt-bindings/clock/exynos5420.h              |  11 +-
 include/dt-bindings/clock/exynos5440.h              |   2 +
 13 files changed, 453 insertions(+), 288 deletions(-)

--
Thanks,
Sylwester
