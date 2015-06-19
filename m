From: ykk@rock-chips.com (Yakir Yang)
Date: Sat, 20 Jun 2015 00:13:37 +0800
Subject: [PATCH v5 0/6] Add dw_hdmi i2s audio support
Message-ID: <1434730417-10629-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As Russell have send an series patches for dw_hdmi audio, and most important
it works well on rockchip platform. Cause some patches have been achieve in
Russell's series, so I abondon some patches in this verison.

Here are the abondon patches that already be achieved:
* drm: bridge/dw_hdmi: adjust n/cts setting order
* drm: bridge/dw_hdmi: set ncts_atomic_write & cts_manual
* drm: bridge/dw_hdmi: combine hdmi_set_clock_regenerator_n() and hdmi_regenerate_cts()
* drm: bridge/dw_hdmi: add enable/disable to dw_hdmi_audio callbacks

And I also abondon some interrupt patches that is not a common bug in dw_hdmi
driver, but is a rockchip platform bug which HDMI registers would reset by CRU
module after system suspend/resume (in this case HPD interrupt mask would reset,
then driver can't respond hot plug event after system resume).

Here are the abondon patches that used to "fix" dw_hdmi interrupt bug:
* drm: bridge/dw_hdmi: add irq control to suspend/resume
* drm: bridge/dw_hdmi: wrap irq control in fucntions
* drm: rockchip/dw_hdmi_rockchip: add resume/suspend support

Here are the leave list that I have make in my series:
- add n/cts combinations for more display modes
- enable audio support when sink device is HDMI monitor and has audio
- rename dw_hdmi-ahb-audio.h to dw_hdmi-audio.h
- add dw_hdmi i2s audio driver
- add rockchip_hdmi_audio sound card driver
- add dt-bindings for documentation for rockchip_hdmi_audio driver


Changes in v5:
- make more words in commit message.
- Take Russell suggest that create "sink_has_audio" and "sink_is_hdmi" in
  struct hdmi, and keep vmode's mdvi changeless.
- Config fc_invidconf to HDMI mode when sink device is HDMI monitor.
- Take Mark Brown suggest that remove jack_status recorded, report
  jack status directly when hdmi plug happend, and remove devm_kfree
  and devm_free_irq.
- Correct the MODULE_LICENSE to "GPL v2"
- Move source from sound/soc/codecs to drivers/gpu/drm/bridge/
- Rename dai driver name to "dw-hdmi-i2s-hifi"
- Take Mark Brown suggest that remove the no useful code in probe func,
  and remove the snd_soc_dai_set_fmt() snd_soc_unregister_card(), remove
  those noisy dev_info()
- Rename codec_dai_name to "dw-hdmi-i2s-hifi"

Changes in v4:
- Take Dainel suggest that introduce drm_detect_monitor_audio() to judge
  whether source should config audio.
- Replace delaywork with irq thread, and add suspend/resume interfaces,
  replace "dw-hdmi-audio" with consecutive strings.
- Add ".pm = &snd_soc_pm_ops,"

Changes in v3:
- Keep audio format config function in dw-hdmi-audio driver
  and remove audio_config & get_connect_status functions,
  move jack control to dw-hdmi-audio completely.
- Delete the operation of jack in rockchip-hdmi-audio driver,
  get ready to switch to simple-audio-card driver.
- modify cpu-of-node to i2s-controller

Changes in v2:
- Update dw_hdmi audio control interfaces, and adjust jack report process
- give "codec-name" & "codec-dai-name" an const name
- remove codec-name and codec-dai-name
- rename rockchip,rockchip-hdmi-audio.txt to rockchip,rockchip-dw-hdmi-audio.txt

Yakir Yang (6):
  drm: bridge/dw_hdmi: add audio support for more display resolutions
  drm: bridge/dw_hdmi: enable audio when sink device is HDMI and has audio
  drm: bridge/dw_hdmi: rename dw_hdmi-ahb-audio.h to dw_hdmi-audio.h
  drm: bridge/dw_hdmi-i2s-audio: add audio driver
  ASoC: rockchip/rockchip-hdmi-audio: add sound driver for hdmi audio
  dt-bindings: Add documentation for rockchip_hdmi_audio driver

 .../sound/rockchip,rockchip-dw-hdmi-audio.txt      |  12 +
 drivers/gpu/drm/bridge/Kconfig                     |   9 +
 drivers/gpu/drm/bridge/Makefile                    |   1 +
 drivers/gpu/drm/bridge/dw_hdmi-ahb-audio.c         |   2 +-
 .../{dw_hdmi-ahb-audio.h => dw_hdmi-audio.h}       |   0
 drivers/gpu/drm/bridge/dw_hdmi-i2s-audio.c         | 398 +++++++++++++++++++++
 drivers/gpu/drm/bridge/dw_hdmi.c                   | 100 +++++-
 drivers/gpu/drm/bridge/dw_hdmi.h                   |   3 +
 sound/soc/rockchip/Kconfig                         |   9 +
 sound/soc/rockchip/Makefile                        |   2 +
 sound/soc/rockchip/rockchip_hdmi_audio.c           | 138 +++++++
 11 files changed, 658 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/rockchip,rockchip-dw-hdmi-audio.txt
 rename drivers/gpu/drm/bridge/{dw_hdmi-ahb-audio.h => dw_hdmi-audio.h} (100%)
 create mode 100644 drivers/gpu/drm/bridge/dw_hdmi-i2s-audio.c
 create mode 100644 sound/soc/rockchip/rockchip_hdmi_audio.c

-- 
2.1.2
