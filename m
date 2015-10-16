From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 16 Oct 2015 08:21:26 +0100
Subject: [RESEND v4.1 0/5] Mailbox: Provide support STi based platforms
Message-ID: <1444980091-16728-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jassi,

[Resending the updated patch-set this time]

This should be it.  Exciting times!
  
ST's platforms currently support a maximum of 5 Mailboxes, one for
each of the supported co-processors situated on the platform.  Each
Mailbox is divided up into 4 instances which consist of 32 channels.
Messages are passed between the application and co-processors using
shared memory areas.
  
Also included in the set is an example Client which should be generic
enough to use as a testing environment for all Mailbox IPs which use
shared memory or the API to pass messages.  With small changes, it
should also be able to test more extravagant implementations.
  
v3 -> v4:
 - More protection in MBOX_BASE() MACRO
 - Remove unused tx-only marker
  
v2 => v3:
 - Controller
   - Shared (DT <=> Device Driver) defines removed
   - Return actual error codes instead of NULL in xlate()
   - Not passing 'direction' configuration via DT anymore
     - Removed all accompanying configuration checking code
 - Test F/W
   - Allow Rx-only and Tx-only controllers to be tested
   - Cater for controllers requiring pre-Tx 'signal' to be sent
   - Supply 'wr-' message debugfs file
     - When written to, will Tx message through Mailbox Framework
     - When read from, will print out a hexdump of Rx'ed message
  
v1 => v2:
 - New MACRO() to obtain base address for a given instance
 - Move locking into the structure it protects
 - Stop checking for 'ready' state when sending data
 - Don't clear channel data (that belongs to the API)
 - #define register offsets instead of providing via pdata
 - Register driver with module_platform_driver()

Lee Jones (5):
  mailbox: dt: Supply bindings for ST's Mailbox IP
  mailbox: Add support for ST's Mailbox IP
  ARM: STi: stih407-family: Add nodes for Mailbox
  mailbox: Add generic mechanism for testing Mailbox Controllers
  ARM: STi: DT: STiH407: Enable Mailbox testing facility

 .../devicetree/bindings/mailbox/sti-mailbox.txt    |  51 ++
 arch/arm/boot/dts/stih407-family.dtsi              |  39 ++
 drivers/mailbox/Kconfig                            |  14 +
 drivers/mailbox/Makefile                           |   4 +
 drivers/mailbox/mailbox-sti.c                      | 513 +++++++++++++++++++++
 drivers/mailbox/mailbox-test.c                     | 361 +++++++++++++++
 6 files changed, 982 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/sti-mailbox.txt
 create mode 100644 drivers/mailbox/mailbox-sti.c
 create mode 100644 drivers/mailbox/mailbox-test.c

-- 
1.9.1
