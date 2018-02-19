From: olivier.moysan@st.com (Olivier Moysan)
Date: Mon, 19 Feb 2018 16:00:34 +0100
Subject: [RFC PATCH 0/3] ASoC: stm32: add S/PDIF support to SAI
Message-ID: <1519052437-24011-1-git-send-email-olivier.moysan@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch-set adds S/PDIF IEC6958 protocol support to STM32 SAI.
Only S/PDIF playback is supported here, as SAI peripheral does not support S/PDIF capture.

SAI peripheral does not take as input full IEC60958 frames as it generates preamble and parity bit.
However, it cannot handle raw PCM data, as it is not designed to insert channel status and user data
in the generated IEC frames.

Moreover, SAI data register format does not match exactly IEC60958 subframe format.
(see figure below). Channel status (C) and User data (U) are at 26-25 bits position,
in data register, instead of 30-29 bits position.
    
IEC60958 subframe bits:
31-28                       27-4                         3-0
P    C    U    V            data (16|24 bits)            preamble

SAI data register format:
27-24                        23-0						
P     C    U    V            data (16|24 bits)

The impact in software is that the data have to be processed before DMA transfer.
These constraints should be managed at driver level to minimize the impact on application.
This means that a callback is necessary to perform data processing (shift and channel status insertion)

This patch-set introduces a callback to allow processing on samples.
The implementation is based on previous discussions available here:
https://patchwork.kernel.org/patch/9570255/

BRs
Olivier

Olivier Moysan (3):
  ASoC: stm32: Add S/PDIF to SAI bindings
  ASoC: dmaengine_pcm: add processing support
  ASoC: stm32: sai: Add support of S/PDIF playback

 .../devicetree/bindings/sound/st,stm32-sai.txt     |   6 +
 include/sound/dmaengine_pcm.h                      |   3 +
 sound/soc/soc-generic-dmaengine-pcm.c              |  62 ++++++++-
 sound/soc/stm/stm32_sai.c                          |   2 +
 sound/soc/stm/stm32_sai.h                          |   2 +
 sound/soc/stm/stm32_sai_sub.c                      | 153 +++++++++++++++++----
 6 files changed, 202 insertions(+), 26 deletions(-)

-- 
1.9.1
