From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Fri, 18 May 2018 13:55:55 +0100
Subject: [PATCH v9 00/15] ASoC: qcom: Add support to QDSP based Audio
Message-ID: <20180518125610.26200-1-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thankyou everyone for providing feedback and testing v8 patchset.

Changes since v8 (https://lkml.org/lkml/2018/5/9/491)
- Fixed usecase across afe, adm, asm where user can trigger
 manual unbind if dsp does not respond/responds very lately.
Spotted by Mark B.
- rebased patchset on top of(removed patches arleady applied)
https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/?h=for-next

This patchset aims to provide a basic version of QCOM DSP based
audio support which is available in downstream andriod kernels.
This patchset support audio playback on HDMI-RX, MI2S, SLIMBus and
will add support to other features as we move on.

QDSP has both static and dynamic modules. static modules like AFE
(Audio FrontEnd), ADM (Audio Device Manager), ASM(Audio Stream Manager)
and CORE to provide this audio services.
All these services use APR (Asynchronous Packet Router) protocol
via smd/glink transport to communicate with Application processor.
More details on each module is available in there respective patch.

This patchset is tested on DB820c, with HDMI audio playback, MI2S on
DB410c on top of mainline, Also tested SLIMBus analog audio using
wcd9355 with an additional patches. Patches are also tested on
SDM845 by Rohit.

Here is my test branch incase someone want to try these patches
https://git.linaro.org/people/srinivas.kandagatla/linux.git/log/?h=v4.17-qdsp6

Here is block diagram to give a quick overview of the components


  +---------+          +---------+         +---------+   
  |  q6asm  |          |q6routing|         | q6afe   | 
  |   dais  | <------> |  mixers | <-----> |  dais   |  
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


Thanks,
srini

Srinivas Kandagatla (15):
  ASoC: qdsp6: q6afe: Add q6afe driver
  ASoC: qdsp6: qdafe: Add SLIMBus port Support
  ASoC: qdsp6: q6afe: Add support to MI2S ports
  ASoC: qdsp6: q6afe: Add support to MI2S sysclks
  ASoC: qdsp6: q6adm: Add q6adm driver
  ASoC: qdsp6: q6asm: Add q6asm driver
  ASoC: qdsp6: q6asm: Add support to memory map and unmap
  ASoC: qdsp6: q6asm: Add support to audio stream apis
  ASoC: qdsp6: q6routing: Add q6routing driver
  ASoC: qdsp6: q6routing: Add support to all SLIMBus Mixers
  ASoC: qdsp6: q6routing: Add support to MI2S Mixers
  ASoC: qdsp6: q6afe: Add q6afe dai driver
  ASoC: qdsp6: q6asm: Add q6asm dai driver
  ASoC: qdsp6: dt-bindings: Add apq8096 machine bindings
  ASoC: qcom: apq8096: Add db820c machine driver

 .../devicetree/bindings/sound/qcom,apq8096.txt     |  109 ++
 sound/soc/qcom/Kconfig                             |   33 +
 sound/soc/qcom/Makefile                            |    2 +
 sound/soc/qcom/apq8096.c                           |  255 ++++
 sound/soc/qcom/qdsp6/Makefile                      |    6 +
 sound/soc/qcom/qdsp6/q6adm.c                       |  646 +++++++++
 sound/soc/qcom/qdsp6/q6adm.h                       |   27 +
 sound/soc/qcom/qdsp6/q6afe-dai.c                   |  748 +++++++++++
 sound/soc/qcom/qdsp6/q6afe.c                       | 1068 +++++++++++++++
 sound/soc/qcom/qdsp6/q6afe.h                       |  193 +++
 sound/soc/qcom/qdsp6/q6asm-dai.c                   |  624 +++++++++
 sound/soc/qcom/qdsp6/q6asm.c                       | 1399 ++++++++++++++++++++
 sound/soc/qcom/qdsp6/q6asm.h                       |   69 +
 sound/soc/qcom/qdsp6/q6routing.c                   |  990 ++++++++++++++
 sound/soc/qcom/qdsp6/q6routing.h                   |    9 +
 15 files changed, 6178 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,apq8096.txt
 create mode 100644 sound/soc/qcom/apq8096.c
 create mode 100644 sound/soc/qcom/qdsp6/q6adm.c
 create mode 100644 sound/soc/qcom/qdsp6/q6adm.h
 create mode 100644 sound/soc/qcom/qdsp6/q6afe-dai.c
 create mode 100644 sound/soc/qcom/qdsp6/q6afe.c
 create mode 100644 sound/soc/qcom/qdsp6/q6afe.h
 create mode 100644 sound/soc/qcom/qdsp6/q6asm-dai.c
 create mode 100644 sound/soc/qcom/qdsp6/q6asm.c
 create mode 100644 sound/soc/qcom/qdsp6/q6asm.h
 create mode 100644 sound/soc/qcom/qdsp6/q6routing.c
 create mode 100644 sound/soc/qcom/qdsp6/q6routing.h

-- 
2.16.2
