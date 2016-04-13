From: ezequiel@vanguardiasur.com.ar (Ezequiel Garcia)
Date: Wed, 13 Apr 2016 15:08:16 -0300
Subject: [PATCH v2 0/3] Extend the LED panic trigger
Message-ID: <1460570899-24642-1-git-send-email-ezequiel@vanguardiasur.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As per commit 916fe619951f ("leds: trigger: Introduce a kernel
panic LED trigger"), the kernel now supports a new LED trigger
to hook on the panic blink.

However, the only way of using this is to dedicate a LED device
to this function.

To overcome this limitation, the present series introduces the
capability to switch the LED trigger of certain LED devices upon
a kernel panic (using the panic notifier).

The decision of which LEDs should be switched to the panic trigger
is left to each LED device driver. As an example, a devicetree
boolean property is introduced and used in the leds-gpio driver.

Feedback and other ideas on how to implement this are most welcomed.

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

 Documentation/devicetree/bindings/leds/common.txt |  3 ++
 drivers/leds/led-triggers.c                       | 57 +++++++++++++++++++++++
 drivers/leds/leds-gpio.c                          |  4 ++
 include/linux/leds.h                              |  2 +
 4 files changed, 66 insertions(+)

-- 
2.7.0
