From: gsi@denx.de (Gerhard Sittig)
Date: Fri, 21 Jun 2013 20:09:46 +0200
Subject: [PATCH v1 00/12] input: keypad-matrix: doc update, hw separation,
 polling, binary columns
Message-ID: <1371838198-7327-1-git-send-email-gsi@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

this series addresses one style nit in the matrix-keymap helper (bool vs
error code for function calls), and brings the following changes to the
matrix-keypad driver
- documentation update (device tree bindings), comments update (driver's
  program flow as well as data structures), diagnostics rephrased
- more finegrained hardware control (individual polarity for row and for
  column pins, push-pull operation of column pins)
- clean separation of the physical hardware attachment and the logical
  keyboard handling (tell GPIO pins and matrix lines apart)
- introduce support for polling vs interrupt driven change detection
  (more reliable detection of multi key press events)
- optionally reduce timer management overhead by using a range instead
  of a fixed value for a microseconds delay
- introduce support for keyboard layouts where fewer column gpio pins
  control more matrix column lines (binary column address encoding)
- adapt a board's device tree to the new features

for unadjusted code and configuration the behaviour remains fully
backwards compatible, using any of the new features is completely
optional


I'm aware of my introducing many new options, and not removing any of
the flexibility to reduce complexity -- but I feel that there's nothing
that can get removed without breaking compatibility, while all of the
new options and features are desirable or just essential for the end
result of binary encoded columns with push/pull requirements for the
pins including reliable detection of multi key press events

even if it were not for the binary column addressing, most of the
changes are desirable and removing the binary encoding doesn't
significantly cut on the complexity

I'd happily trim flexibility and reduce complexity if it turns out that
the former support which I did not want to break isn't required any
longer (the open collector emulation might be one such candidate)


the series was build tested on PowerPC (mpc512x generic plus
matrix-keypad), ARM (omap2plus plus matrix-keypad) and MIPS (bcm47xx
plus matrix-keypad) and was run tested on PowerPC (mpc512x generic on an
ifm AC14xx board)

test feedback from ARM users (palm tungsten, spitz, corgi with platform
data, any recent ARM with matrix-keypad and device tree) is very welcome
and greatly appreciated

the series is checkpatch clean in regular mode, and spots one condition
in strict mode which I consider acceptable since memset() would be too
much for two u32 values and individual assignments appear clumsy to me
in this very case

    CHECK: multiple assignments should be avoided
    #114: FILE: drivers/input/keyboard/matrix_keypad.c:671:
    +	us[0] = us[1] = 0;

    total: 0 errors, 0 warnings, 1 checks, 95 lines checked


Gerhard Sittig (12):
  input: matrix-keypad: update devicetree binding doc
  input: matrix-keymap: func call coding style nit
  input: matrix-keypad: rename variables and funcs
  input: matrix-keypad: push/pull, separate polarity
  input: matrix-keypad: update comments, diagnostics
  input: keypad-matrix: refactor matrix scan logic
  input: keypad-matrix: introduce polling support
  input: keypad-matrix: tell GPIO pins from matrix lines
  input: matrix-keypad: add binary column encoding
  input: keypad_matrix: use usleep_range() for scan delay
  input: keypad-matrix: AC14xx device tree update
  input: matrix-keypad: add diagnostics in probe()

 .../bindings/input/gpio-matrix-keypad.txt          |  138 ++++++-
 arch/arm/mach-davinci/board-tnetv107x-evm.c        |    3 +-
 arch/arm/mach-omap2/board-h4.c                     |    3 +-
 arch/arm/mach-pxa/palmtc.c                         |    3 +-
 arch/mips/jz4740/board-qi_lb60.c                   |    3 +-
 arch/powerpc/boot/dts/ac14xx.dts                   |   13 +-
 drivers/input/keyboard/matrix_keypad.c             |  399 +++++++++++++++++---
 drivers/input/matrix-keymap.c                      |   23 +-
 include/linux/input/matrix_keypad.h                |   44 ++-
 9 files changed, 538 insertions(+), 91 deletions(-)

-- 
1.7.10.4
