From: olivier.moysan@st.com (olivier moysan)
Date: Mon, 10 Apr 2017 17:19:54 +0200
Subject: [PATCH v3 0/2] Add STM32 SAI support
Message-ID: <1491837596-2924-1-git-send-email-olivier.moysan@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch-set handles the Serial Audio Interface (SAI) IP on STM32 platforms.

The SAI IP is composed of two Sub-block A and B. (see the figure below)
Each sub-block makes use of individual and shared resources.

Shared resources:
	- Reset line. Reset common and sub-block registers.
	- Bus interface clocks. This clock is not exposed in device
	as it it managed by clock driver, according to kernel clocks gating.
	- Common register. SAI IP exhibits a common configuration register
	to manage synchronization modes. NB: These modes are not yet implemented
	in this version of the SAI driver.
	- Interrupt. Sub-blocks have their own interrupt status registers but they 
	share the same interrupt line.

Individual resources:
	- Register set
	- DMA request line.
	- Communication interface. 
	Each sub-block has its own GPIOs and associated bus lines.
	- Kernel clock. 
	Each sub-block has its own dedicated clock for its communication interface.

To reflect this architecture Sub-block A and B are handled by 2 child devices.
Sub-block A and B devices can be configured independently either as transmitter
or receiver. A PCM device is associated to each sub-block.

A sub-block has to select the appropriated parent clock at runtime, 
depending on the audio stream sampling rate to be played or captured.
Two parent clocks must be provided to support sampling rates multiples
of 8 kHz or 11.025kHz.

 Interface clock  +--------------------------------+
+---------------> | SAI IP                         |
 Reset            |     +-----------------+        |
+---------------> |     |common registers |        |
                  |     +-----------------+        |
                  |                                |
                  |    +----------------------+    |
                  |    | Sub-block A          |    |
 Kernel clock A   |    |                      |    | Bus A
+--------------------> | +----------------+   +---------------->
                  |    | |A registers     |   |    |
                  |    | +----------------+   |    |
                  |    +----------------------+    |
                  |                                |
                  |    +----------------------+    |
                  |    | Sub-block B          |    |
 Kernel clock B   |    |                      |    | Bus B
+--------------------> | +----------------+   +----------------->
                  |    | |B registers     |   |    |
                  |    | +----------------+   |    |
                  |    +----------------------+    |
                  |                                |
                  +--------------------------------+

v3: correct DT bindings
	- remove aliases
	- use audio graph card

olivier moysan (2):
  ASoC: stm32: add bindings for SAI
  ASoC: stm32: add SAI driver

 .../devicetree/bindings/sound/st,stm32-sai.txt     |  89 +++
 sound/soc/Kconfig                                  |   1 +
 sound/soc/Makefile                                 |   1 +
 sound/soc/stm/Kconfig                              |   8 +
 sound/soc/stm/Makefile                             |   6 +
 sound/soc/stm/stm32_sai.c                          | 115 +++
 sound/soc/stm/stm32_sai.h                          | 200 +++++
 sound/soc/stm/stm32_sai_sub.c                      | 884 +++++++++++++++++++++
 8 files changed, 1304 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/st,stm32-sai.txt
 create mode 100644 sound/soc/stm/Kconfig
 create mode 100644 sound/soc/stm/Makefile
 create mode 100644 sound/soc/stm/stm32_sai.c
 create mode 100644 sound/soc/stm/stm32_sai.h
 create mode 100644 sound/soc/stm/stm32_sai_sub.c

-- 
1.9.1
