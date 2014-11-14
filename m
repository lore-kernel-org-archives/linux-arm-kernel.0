From: arno@natisbad.org (Arnaud Ebalard)
Date: Sat, 15 Nov 2014 00:06:17 +0100
Subject: [PATCHv1 0/6] rtc: rtc-isl12057: fixes and alarm support
Message-ID: <cover.1416006090.git.arno@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series includes six patches for Intersil ISL12057 driver.

 - First patch is a fix for masking issues which dates back to driver
   inclusion. Even if those issues are not critical per se, the patch is
   a good candidate for stable down to 3.14.

 - As suggested by Uwe, second patch adds proper support for century bit
   provided by the driver. This will allow to use the chip until 2199
   if we manage to pass 2038.

 - Following another comment by Uwe, third patch corrects the handling
   of oscillator failure bit.

 - fourth patch fixes remaining places where 'isl' is used instead of the
   expected NASDAQ symbol for Intersil (i.e. isil) after commit
   7a6540ca856ae ("ARM: mvebu: Change vendor prefix for Intersil 
   Corporation to isil"). 

 - As suggested by Mark, fifth patch improves failure reports by providing
   error code in dev_err() code.

 - Sixth patch provides alarm support for Intersil ISL12057. This
   support was not added when the driver was initially pushed in 3.14
   kernel due to the inability to check interrupt support. After some
   soldering, this tests have been performed. More time was also
   spent on testing.

Comments are welcome,

Cheers,

a+

Changes since v0:

- Kept an "isl,isl12057" compatible string for out-of-tree users w/
  a comment this is obsolete as suggested by Mark and Uwe.
- Changed function name from toggle to update for helper as suggested
  by Uwe and Guenter.
- As suggested by Mark, added a patch to improve error reporting and
  log the error code 
- Driver now handles lack of IRQ correctly by returning -ENOTTY
  if alarm_irq_enable() handler is called and no IRQ has been
  provided. Additionally, the device is marked as not supporting UIE
  when no IRQ is available.
- Following comments from Mark, added a local copy of IRQ (or lack
  of) in driver's private structure
- Following comments from Mark, removed a useless call to free_irq()
  (driver makes use of devm_request_threaded_irq() which makes the
  call pointless)
- Following report from Uwe, added a patch to handle oscillator
  failure bit properly
- Following suggestions from Uwe, added a patch to handle the century
  bit the device provides

Arnaud Ebalard (6):
  rtc: rtc-isl12057: fix masking of register values
  rtc: rtc-isl12057: add support for century bit
  rtc: rtc-isl12057: add proper handling of oscillator failure bit
  rtc: rtc-isl12057: fix isil vs isl naming for intersil
  rtc: rtc-isl12057: report error code upon failure in dev_err() calls
  rtc: rtc-isl12057: add alarm support to Intersil ISL12057 RTC driver

 .../devicetree/bindings/i2c/trivial-devices.txt    |   2 +-
 .../devicetree/bindings/vendor-prefixes.txt        |   2 +-
 drivers/rtc/rtc-isl12057.c                         | 408 +++++++++++++++++++--
 3 files changed, 377 insertions(+), 35 deletions(-)

-- 
2.1.1
