From: olivier.moysan@st.com (olivier moysan)
Date: Thu, 18 May 2017 17:19:50 +0200
Subject: [PATCH v4 0/3] ASoC: Add STM32 I2S support
Message-ID: <1495120793-11687-1-git-send-email-olivier.moysan@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch-set handles the SPI/I2S IP on STM32 platforms.

It applies to STM32 platforms implementing version 2 of SPI/I2S IP like STM32H7 series.

The SPI/I2S block is a serial peripheral interface (SPI), which can also be configured to work on I2S/PCM mode.
ASoC STM32 I2S driver only supports this I2S/PCM mode.

The I2S/PCM interface can either support full duplex or half-duplex communication
(transmitter or receiver only). The change of mode requires to stop the interface.
This means that the two audio paths cannot be basically managed independently.

The driver supports playback and capture through a single bidirectionnal DAI. 
In the first version of the driver, playback and capture paths are made mutually exclusive.

A second patch introduces support of full duplex mode. 
In this implementation the interface is systematically configured in full-duplex mode
from hardware point of view. So, when managing a single audio path, the interface
is not configured as transmit or receive only, as it should be.
This restriction is handled by masking underrun/overrun errors from the unused path.

The I2S/PCM interface supports four audio standards:
I2S Philips standard, MSB justified standard, LSB justified standard, PCM standard
PCM standard is declined in two versions, PCM short and long,
according frame synchronization duration.

These standards can be mapped to ASoC standards as follows:
	- I2S: i2s
	- MSB justified standard: left_j
	- LSB justified standard: right_j
	- PCM short: dsp_a
PCM long format is not exposed as it does not match supported ASoC standards.

v3 -> v4
	- update example in dt bindings

olivier moysan (3):
  dt-bindings: Document STM32 I2S bindings
  ASoC: stm32: Add I2S driver
  ASoC: stm32: Add full duplex support to i2s

 .../devicetree/bindings/sound/st,stm32-i2s.txt     |  62 ++
 sound/soc/stm/Kconfig                              |   2 +-
 sound/soc/stm/Makefile                             |   4 +
 sound/soc/stm/stm32_i2s.c                          | 946 +++++++++++++++++++++
 4 files changed, 1013 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/sound/st,stm32-i2s.txt
 create mode 100644 sound/soc/stm/stm32_i2s.c

-- 
1.9.1
