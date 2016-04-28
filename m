From: ezequiel@vanguardiasur.com.ar (Ezequiel Garcia)
Date: Thu, 28 Apr 2016 19:03:37 -0300
Subject: [PATCH v3 0/3] Extend the LED panic trigger
Message-ID: <1461881020-13964-1-git-send-email-ezequiel@vanguardiasur.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As per commit 916fe619951f ("leds: trigger: Introduce a kernel
panic LED trigger"), the kernel now supports a new LED trigger
to hook on the panic blink.

However, the only way of using this is to dedicate a LED device,
making it rather useless.

To overcome this limitation, the present series introduces the
capability to switch the LED trigger of certain LED devices upon
a kernel panic (using the panic notifier).

The decision of which LEDs should be switched to the panic trigger
is left to each LED device driver. As an example, a devicetree
boolean property is introduced and used in the leds-gpio driver.

The big change in this v3 is that I've moved the panic trigger
switching away from the core code and it's now part of
ledtrig-panic.c. Pavel, Jacek: How does it look?

Changes from v2:

  * Added Rob's "panic-indicator" devicetree property Acked-by.

  * Fix typo, as pointed out by Robin Murphy.

  * Documented "panic-indicator" in bindings/leds/leds-gpio.txt.

  * Moved the panic trigger switching from the trigger core code,
    to ledtrig-panic.c.

Changes from v1:

  * Dropped the led_trigger_event_nosleep API, and instead just
    clear the blink_delay_{on, off} when the panic is notified. 
    This results in less changes.

  * Changed the flag to LED_PANIC_INDICATOR, as requested by Jacek.

  * Changed the firmware property name to "panic-indicator", as
    requested by Jacek. 

Ezequiel Garcia (3):
  leds: triggers: Allow to switch the trigger to "panic" on a kernel
    panic
  devicetree: leds: Introduce "panic-indicator" optional property
  leds: gpio: Support the "panic-indicator" firmware property

 Documentation/devicetree/bindings/leds/common.txt  |  3 ++
 .../devicetree/bindings/leds/leds-gpio.txt         |  2 +
 drivers/leds/led-triggers.c                        |  2 +-
 drivers/leds/leds-gpio.c                           |  4 ++
 drivers/leds/leds.h                                |  1 +
 drivers/leds/trigger/Kconfig                       |  3 ++
 drivers/leds/trigger/ledtrig-panic.c               | 47 ++++++++++++++++++++++
 include/linux/leds.h                               |  2 +
 8 files changed, 63 insertions(+), 1 deletion(-)

-- 
2.7.0
