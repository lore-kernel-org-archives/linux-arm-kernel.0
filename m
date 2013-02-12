From: dianders@chromium.org (Doug Anderson)
Date: Mon, 11 Feb 2013 16:48:03 -0800
Subject: [PATCH v3 0/2] Add automatic bus number support for i2c busses with
 device tree
Message-ID: <1360630085-26874-1-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This was suggested by Mark Brown in response to a patch for adding
this functionality only for the s3c2410 bus:
  https://lkml.org/lkml/2012/11/20/681

I have also modified the i2c-pxa driver to use this new functionality.
The i2c-pxa driver changes have only been compile-tested and are just
for cleanup purposes.

Changes in v3:
- Addressed Wolfram's feedback; rebased atop idr-cleanup series.

Changes in v2:
- No longer tweak pdev->id as per Sylwester Nawrocki.
- No longer add the dev ID to the adap.name.  Other drivers don't
  include the device ID here and it doesn't make sense with
  dynamically (or automatically) allocated IDs.
- Use dev_name(&dev->dev) to register for the IRQ; this matches what
  the i2c-s3c2410.c does and handles dynamically allocated IDs.
- This change was only compile-tested (corgi_defconfig), since I don't
  have access to a board that uses this driver.

Doug Anderson (2):
  i2c-core: dt: Pick i2c bus number from i2c alias if present
  i2c: pxa: Use i2c-core to get bus number now

 drivers/i2c/busses/i2c-pxa.c | 20 ++++++++--------
 drivers/i2c/i2c-core.c       | 54 ++++++++++++++++++++++++++++++++------------
 2 files changed, 49 insertions(+), 25 deletions(-)

-- 
1.8.1
