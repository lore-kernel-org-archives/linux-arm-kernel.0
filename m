From: dianders@chromium.org (Doug Anderson)
Date: Mon, 14 Jan 2013 10:53:20 -0800
Subject: [PATCH v2 0/2] Add automatic bus number support for i2c busses with
 device tree
In-Reply-To: <1357927027-4857-2-git-send-email-dianders@chromium.org>
References: <1357927027-4857-2-git-send-email-dianders@chromium.org>
Message-ID: <1358189602-24180-1-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This was suggested by Mark Brown in response to a patch for adding
this functionality only for the s3c2410 bus:
  https://lkml.org/lkml/2012/11/20/681

I have also modified the i2c-pxa driver to use this new functionality.

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

 drivers/i2c/busses/i2c-pxa.c |   20 ++++----
 drivers/i2c/i2c-core.c       |  105 ++++++++++++++++++++++++++++++-----------
 2 files changed, 86 insertions(+), 39 deletions(-)

-- 
1.7.7.3
