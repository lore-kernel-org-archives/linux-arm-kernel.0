From: tiwai@suse.de (Takashi Iwai)
Date: Sun, 21 May 2017 21:02:51 +0200
Subject: [PATCH 0/7] ALSA: Fix/improve PCM ack callback
Message-ID: <20170521190258.1178-1-tiwai@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this is a series of patches to fix the potential bugs in PCM ack
callback using the pcm-indirect helper functions, and also to enhance
the ack callback to be called properly in all appl_ptr updates, as
similarly done by Pierre and Subhransu's patches.

The changes in the pcm-indirect helper code and its users are fairly
trivial, just passing the error code back.

ARM/R-Pi people are Cc'ed because of bcm2835-audio driver.


Takashi

===

Takashi Iwai (7):
  ALSA: pcm: Fix negative appl_ptr handling in pcm-indirect helpers
  ALSA: mips: Deliver indirect-PCM transfer error
  ALSA: cs46xx: Deliver indirect-PCM transfer error
  ALSA: emu10k1: Deliver indirect-PCM transfer error
  ALSA: rme32: Deliver indirect-PCM transfer error
  staging: bcm2835-audio: Deliver indirect-PCM transfer error
  ALSA: pcm: Call ack() whenever appl_ptr is updated

 .../vc04_services/bcm2835-audio/bcm2835-pcm.c      |  5 +--
 include/sound/pcm-indirect.h                       | 10 ++++-
 sound/core/pcm_native.c                            | 46 +++++++++++++++++-----
 sound/mips/hal2.c                                  | 14 +++----
 sound/pci/cs46xx/cs46xx_lib.c                      |  8 ++--
 sound/pci/emu10k1/emupcm.c                         |  4 +-
 sound/pci/rme32.c                                  | 10 ++---
 7 files changed, 63 insertions(+), 34 deletions(-)

-- 
2.13.0
