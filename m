From: srinivas.kandagatla@linaro.org (srinivas.kandagatla at linaro.org)
Date: Thu, 14 Dec 2017 17:33:47 +0000
Subject: [RESEND PATCH v2 00/15] ASoC: qcom: Add support to QDSP6 based audio
Message-ID: <20171214173402.19074-1-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patchset aims to provide a very basic version of QCOM DSP based
audio support which is available in downstream andriod kernels.
This patchset only support Digital audio based for HDMI-RX and will
add support to other features as we move on.

QDSP has both static and dynamic modules. static modules like AFE
(Audio FrontEnd), ADM (Audio Device Manager), ASM(Audio Stream Manager)
and CORE to provide this audio services.
All these services use APR (Asynchronous Packet Router) protocol
via smd/glink transport to communicate with Application processor.
More details on each module is availble in there respective patch.

This patchset is tested on DB820c, with HDMI audio playback
on top of mainline, also tested slimbus analog audio using wcd9355
with an additional small patch.

Here is block diagram to give a quick overview of the components


  +---------+          +---------+         +---------+   
  |  q6asm  |          |q6routing|         | q6afe   | 
  |  fedai  | <------> |  mixers | <-----> | bedai   |  
  +---------+          +---------+         +---------+   
      ^                     ^                   ^
      |                     |                   |
      |  +------------------+----------------+  |       
      |  |                  |                |  |       
      v  v                  v                v  v       
  +---------+          +---------+         +---------+ 
  |   q6ASM |          |  q6ADM  |         |   q6AFE |  
  +---------+          +---------+         +---------+  
      ^                     ^                   ^          ^
      |                     |                   | CPU Side |
------+---------------------+-------------------+--------
      |                     |                   |
      |                     |APR(smd/glink)     | 
      |                     |                   |
      |  +------------------+----------------+  |
      |  |                  |                |  |
+-----+--+-----------------------------------+--+-------
      |  |                  |                |  | QDSP Side |
      v  v                  v                v  v           v
 +---------+          +---------+         +---------+
 |   ASM   | <------> |   ADM   | <-----> |   AFE   |
 +---------+          +---------+         +---------+
                                               ^
                                               | 
                           +-------------------+
                           |
---------------------------+--------------------------
                           |            Audio I/O |
                           v                      v
    +--------------------------------------------------+
    |                Audio devices                     |
    | CODEC | HDMI-TX | PCM  | SLIMBUS | I2S |MI2S |...|
    |                                                  |
    +--------------------------------------------------+

Changes since RFC:
- Converted APR driver to proper bus driver 
- Added API version info to apr devices
- Added q6core driver.
- Fixed various issues spotted by Banajit and Kasam.
- Added kernel doc to exported symbols.
- renamed qdsp6v2 to qdsp6 as api version info can be
	 used from apr device.
- removed unnecessary dt bindings for apr devices.

Srinivas Kandagatla (15):
  dt-bindings: soc: qcom: Add bindings for APR bus
  soc: qcom: add support to APR bus driver
  ASoC: qcom: qdsp6: Add common qdsp6 helper functions
  ASoC: qcom: qdsp6: Add support to Q6AFE
  ASoC: qcom: qdsp6: Add support to Q6ADM
  ASoC: qcom: qdsp6: Add support to Q6ASM
  ASoC: qcom: q6asm: Add support to memory map and unmap
  ASoC: qcom: q6asm: add support to audio stream apis
  ASoC: qcom: qdsp6: Add support to Q6CORE
  ASoC: qcom: qdsp6: Add support to q6routing driver
  ASoC: qcom: qdsp6: Add support to q6afe dai driver
  ASoC: qcom: qdsp6: Add support to q6asm dai driver
  dt-bindings: sound: qcom: Add devicetree bindings for apq8096
  ASoC: qcom: apq8096: Add db820c machine driver
  arm64: dts: msm8996: db820c: Add sound card support

 .../devicetree/bindings/soc/qcom/qcom,apr.txt      |   28 +
 .../devicetree/bindings/sound/qcom,apq8096.txt     |   22 +
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi       |    5 +
 arch/arm64/boot/dts/qcom/msm8996.dtsi              |   33 +
 drivers/soc/qcom/Kconfig                           |    8 +
 drivers/soc/qcom/Makefile                          |    1 +
 drivers/soc/qcom/apr.c                             |  395 +++++++
 include/linux/mod_devicetable.h                    |   13 +
 include/linux/soc/qcom/apr.h                       |  174 +++
 sound/soc/qcom/Kconfig                             |   51 +
 sound/soc/qcom/Makefile                            |    5 +
 sound/soc/qcom/apq8096.c                           |  124 +++
 sound/soc/qcom/qdsp6/Makefile                      |    7 +
 sound/soc/qcom/qdsp6/common.h                      |  225 ++++
 sound/soc/qcom/qdsp6/q6adm.c                       |  602 +++++++++++
 sound/soc/qcom/qdsp6/q6adm.h                       |   24 +
 sound/soc/qcom/qdsp6/q6afe-dai.c                   |  241 +++++
 sound/soc/qcom/qdsp6/q6afe.c                       |  503 +++++++++
 sound/soc/qcom/qdsp6/q6afe.h                       |   30 +
 sound/soc/qcom/qdsp6/q6asm-dai.c                   |  534 ++++++++++
 sound/soc/qcom/qdsp6/q6asm.c                       | 1119 ++++++++++++++++++++
 sound/soc/qcom/qdsp6/q6asm.h                       |   61 ++
 sound/soc/qcom/qdsp6/q6core.c                      |  227 ++++
 sound/soc/qcom/qdsp6/q6routing.c                   |  386 +++++++
 sound/soc/qcom/qdsp6/q6routing.h                   |    9 +
 25 files changed, 4827 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,apq8096.txt
 create mode 100644 drivers/soc/qcom/apr.c
 create mode 100644 include/linux/soc/qcom/apr.h
 create mode 100644 sound/soc/qcom/apq8096.c
 create mode 100644 sound/soc/qcom/qdsp6/Makefile
 create mode 100644 sound/soc/qcom/qdsp6/common.h
 create mode 100644 sound/soc/qcom/qdsp6/q6adm.c
 create mode 100644 sound/soc/qcom/qdsp6/q6adm.h
 create mode 100644 sound/soc/qcom/qdsp6/q6afe-dai.c
 create mode 100644 sound/soc/qcom/qdsp6/q6afe.c
 create mode 100644 sound/soc/qcom/qdsp6/q6afe.h
 create mode 100644 sound/soc/qcom/qdsp6/q6asm-dai.c
 create mode 100644 sound/soc/qcom/qdsp6/q6asm.c
 create mode 100644 sound/soc/qcom/qdsp6/q6asm.h
 create mode 100644 sound/soc/qcom/qdsp6/q6core.c
 create mode 100644 sound/soc/qcom/qdsp6/q6routing.c
 create mode 100644 sound/soc/qcom/qdsp6/q6routing.h

-- 
2.15.0
