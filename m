From: olivier.moysan@st.com (Olivier Moysan)
Date: Mon, 15 Oct 2018 16:03:32 +0200
Subject: [PATCH 0/4] ASoC: stm32: sai: add mclk clock provider
Message-ID: <1539612216-12602-1-git-send-email-olivier.moysan@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set allows to use STM32 SAI interface as a master clock provider.
The Cirrus cs42l51 codec patch gives the example of the source code required on codec side,
to use SAI mclk provider.

These patches allow to cover the following use cases:
	- SAI is master or slave and is master clock provider
	- SAI is master or slave and is not master clock provider (another sai provides the mclk clock)

Implementation overview:
- mclk configuration
	SAI is registered in clock framework:
		- either as a mclk provider (optional in DT). SAI generates mclk when requested by DAPM
		- or as a mclk consumer (optional in DT).
	cs42l51 codec is configured as a mclk consumer (optional in DT)

- mclk power
	A DAPM is registered in codec to handle mclk enable/disable (DAPM route is set in soundcard node)

- mclk rate:
	mclk rate is computed at runtime from stream rate and mclk-fs ratio provided in DT
	mclk rate is propagated through sysclk callback to the SAI which is mclk consumer.
	The mclk rate is set exclusively to avoid concurrent rate requests on SAI master.

Regards
Olivier

Olivier Moysan (4):
  ASoC: dt-bindings: add mclk provider support to stm32 sai
  ASoC: dt-bindings: add mclk support to cs42l51
  ASoC: stm32: sai: set sai as mclk clock provider
  ASoC: cs42l51: add mclk support

 .../devicetree/bindings/sound/cs42l51.txt          |  17 ++
 .../devicetree/bindings/sound/st,stm32-sai.txt     |   7 +
 .../devicetree/bindings/trivial-devices.txt        |   1 -
 sound/soc/codecs/cs42l51.c                         |   8 +
 sound/soc/stm/stm32_sai.h                          |   3 +
 sound/soc/stm/stm32_sai_sub.c                      | 275 ++++++++++++++++++---
 6 files changed, 274 insertions(+), 37 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/cs42l51.txt

-- 
2.7.4
