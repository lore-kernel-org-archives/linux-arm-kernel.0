From: r.baldyga@samsung.com (Robert Baldyga)
Date: Tue, 28 Jul 2015 07:19:57 +0200
Subject: [PATCH 0/7] usb: gadget: get rid of UDC name-based quirks
Message-ID: <1438060804-21706-1-git-send-email-r.baldyga@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch set replaces quirks based on UDC name with generic quirk
bitfields in struct usb_gadget. It allows to avoid checking for UDC
name in USB function drivers. Instead we have few quirk bitfields
informing rather about chip-specific limitations than specific chip
name. Thanks to this it's possible to handle new chips with similar
hardware limitations without changing code of USB functions.

IMPORTANT
This patch set depends on my previous patch series. They should be
applied in following order:
1. "usb: gadget: miscellaneous fixes"
   https://lkml.org/lkml/2015/7/13/122
2. "usb: gadget: rework ep matching and claiming mechanism"
   https://lkml.org/lkml/2015/7/27/181
3. this patchset

Best regards,
Robert Baldyga

Robert Baldyga (7):
  usb: gadget: add 'quirk_altset_not_supp' to usb_gadget
  usb: gadget: add 'quirk_stall_not_supp' to usb_gadget
  usb: gadget: add 'quirk_zlp_not_supp' to usb_gadget
  usb: gadget: f_mass_storage: check quirk instead of UDC name
  usb: gadget: f_ecm/f_ncm: check quirk instead of UDC name
  usb: gadget: apply generic altsetting support check mechanism
  usb: gadget: remove gadget_chips.h

 drivers/usb/gadget/epautoconf.c              |  2 -
 drivers/usb/gadget/function/f_acm.c          |  1 -
 drivers/usb/gadget/function/f_ecm.c          |  4 +-
 drivers/usb/gadget/function/f_mass_storage.c |  4 +-
 drivers/usb/gadget/function/f_ncm.c          |  5 +--
 drivers/usb/gadget/function/f_obex.c         |  3 +-
 drivers/usb/gadget/function/f_serial.c       |  1 -
 drivers/usb/gadget/function/f_sourcesink.c   |  1 -
 drivers/usb/gadget/function/u_ether.h        |  4 +-
 drivers/usb/gadget/function/u_uac1.h         |  2 -
 drivers/usb/gadget/legacy/audio.c            |  1 -
 drivers/usb/gadget/legacy/gmidi.c            |  2 -
 drivers/usb/gadget/legacy/hid.c              |  1 -
 drivers/usb/gadget/legacy/nokia.c            |  3 +-
 drivers/usb/gadget/legacy/printer.c          |  2 -
 drivers/usb/gadget/legacy/serial.c           |  1 -
 drivers/usb/gadget/udc/at91_udc.c            |  1 +
 drivers/usb/gadget/udc/gadget_chips.h        | 55 ----------------------------
 drivers/usb/gadget/udc/pxa25x_udc.c          |  1 +
 drivers/usb/gadget/udc/pxa27x_udc.c          |  1 +
 drivers/usb/musb/musb_gadget.c               |  1 +
 include/linux/usb/gadget.h                   | 31 ++++++++++++++++
 22 files changed, 44 insertions(+), 83 deletions(-)
 delete mode 100644 drivers/usb/gadget/udc/gadget_chips.h

-- 
1.9.1
