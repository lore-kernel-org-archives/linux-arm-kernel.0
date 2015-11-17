From: sricharan@codeaurora.org (Sricharan R)
Date: Tue, 17 Nov 2015 17:15:21 +0530
Subject: [PATCH V5 0/6] i2c: qup: Add support for v2 tags and bam dma
Message-ID: <1447760727-4897-1-git-send-email-sricharan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

QUP from version 2.1.1 onwards, supports a new format of i2c command tags.
Tag codes instructs the controller to perform a operation like read/write.
This new tagging version supports and is required for adding bam dma
capabilities. V2 tags supports transfer of more than 256 bytes in a single i2c
transaction. Also adding bam dma support facilitates transferring each i2c_msg
in i2c_msgs without a 'stop' bit in between which is required for some of
the clients.

Tested this series on apq8074 dragon board eeprom client on i2c bus1

[V5] Addressed few more comments from Ivan T. Ivanov.
     Squashed patch 2 and 3 as no point in having only few lines of
     common code between v1 and v2 tags for increased complexity.
     Couple of non functional review comments fixes in patch 3, 4.
     Added a change in patch 4 to have proper transfer completion in
     a corner case. patch 5, 6 unchanged.

[V4] Added a patch to factor out some common code.
     Removed support for freq > 400KHZ as per comments.
     Addressed comments from Ivan T. Ivanov to keep the code for
     V2 support in a separate path. 
     Changed the authorship of V2 tags support patch.

[V3] Added support to coalesce each i2c_msg in i2c_msgs for fifo and
     block mode in Patch 2. Also addressed further code comments.

     http://comments.gmane.org/gmane.linux.drivers.i2c/22497

[V2] Addressed comments from Ivan T. Ivanov, Andy Gross [v1] Initial Version

Sricharan R (6):
  i2c: qup: Change qup_wait_writeready function to use for all timeouts
  i2c: qup: Add V2 tags support
  i2c: qup: Transfer each i2c_msg in i2c_msgs without a stop bit
  i2c: qup: Add bam dma capabilities
  dts: msm8974: Add blsp2_bam dma node
  dts: msm8974: Add dma channels for blsp2_i2c1 node

 arch/arm/boot/dts/qcom-msm8974.dtsi |  14 +-
 drivers/i2c/busses/i2c-qup.c        | 931 ++++++++++++++++++++++++++++++++++--
 2 files changed, 896 insertions(+), 49 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
