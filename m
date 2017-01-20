From: ryder.lee@mediatek.com (Ryder Lee)
Date: Fri, 20 Jan 2017 13:41:07 +0800
Subject: [PATCH 0/8] update mediatek crypto driver
Message-ID: <1484890875-57105-1-git-send-email-ryder.lee@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series of patches is a global rework of the mtk driver.
Fix bug - incomplete DMA data transfer when SG buffer dst.len != src.len

It also updates some part of the code to make them more generic. For
instance the crypto request queue management supports both async block
cipher and AEAD requests, which allows us to add support the the GCM mode.
GMAC mode is not supported yet.

Current implementation was validated using the tcrypt
module running modes:
- 10: ecb(aes), cbc(aes), ctr(aes), rfc3686(ctr(aes))
- 35: gcm(aes)
- 2,6,11,12: sha1, sha2 family

tcrypt speed test was run with modes:
- 211: rfc4106(gcm(aes)), gcm(aes)
- 500: ecb(aes), cbc(aes), ctr(aes), rfc3686(ctr(aes))
- 403 ~ 406: sha1, sha2 family

IxChariot multiple pairs throughput 24 hours test:
- IPSec VPN
- MACSec

Ryder Lee (8):
  crypto: mediatek - move HW control data to transformation context
  crypto: mediatek - fix incorrect data transfer result
  crypto: mediatek - make crypto request queue management more generic
  crypto: mediatek - rework crypto request completion
  crypto: mediatek - regroup functions by usage
  crypto: mediatek - fix typo and indentation
  crypto: mediatek - add support to CTR mode
  crypto: mediatek - add support to GCM mode

 drivers/crypto/Kconfig                 |    2 +
 drivers/crypto/mediatek/mtk-aes.c      | 1026 ++++++++++++++++++++++++--------
 drivers/crypto/mediatek/mtk-platform.h |   47 +-
 drivers/crypto/mediatek/mtk-sha.c      |  170 +++---
 4 files changed, 886 insertions(+), 359 deletions(-)

-- 
1.9.1
