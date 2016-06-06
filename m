From: lee.jones@linaro.org (Lee Jones)
Date: Mon,  6 Jun 2016 16:56:48 +0100
Subject: [PATCH 0/7] reset: Consumers to explicitly request 'exclusive' or
 'shared' lines
Message-ID: <20160606155655.10860-1-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Phasing out generic reset line requests enables us to make some better
decisions on when and how to (de)assert said lines.  If an 'exclusive'
line is requested, we know a device *requires* a reset and that it's
preferable to act upon a request right away.  However, if a 'shared'
reset line is requested, we can reasonably assume sure that placing a
device into reset isn't a hard requirement, but probably a measure to
save power and is thus able to cope with not being asserted if another
device is still in use.

In order allow gentle adoption and not to forcing all consumers to
move to the API immediately, causing administration headache between
subsystems, this patch adds some temporary stand-in shim-calls.  This
will ease the burden at merge time and allow subsystems to migrate over
to the new API in a more realistic time-frame.

Lee Jones (7):
  reset: Reorder inline reset_control_get*() wrappers
  reset: Ensure drivers are explicit when requesting reset lines
  reset: Supply *_shared variant calls when using of_* API
  reset: Supply *_shared variant calls when using *_optional APIs
  reset: TRIVIAL: Add line break at same place for similar APIs
  phy: miphy28lp: Inform the reset framework that our reset line may be
    shared
  usb: dwc3: st: Inform the reset framework that our reset line may be
    shared

 drivers/phy/phy-miphy28lp.c |   3 +-
 drivers/usb/dwc3/dwc3-st.c  |   6 +-
 include/linux/reset.h       | 211 +++++++++++++++++++++++++++++++++++---------
 3 files changed, 173 insertions(+), 47 deletions(-)

-- 
2.8.3
