From: wxt@rock-chips.com (Caesar Wang)
Date: Fri, 15 Jan 2016 21:49:47 +0800
Subject: [PATCH v3 0/9] Add the family patches to support for kylin board
Message-ID: <1452865796-23527-1-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This series patches are based on kernel 4.4.0 release version
(Linux version 4.4.0+ (wxt at ubuntu) (...) #167 SMP Fri Jan 15 19:18:28 CST 2016)

This series pacthes are verified on the following github:
https://github.com/Caesar-github/rockchip/commits/kylin-next

This series has 9 patches: (9--->1)
2b1afd6 ARM: dts: rockchip: add pl330-broken-no-flushp quirk for rk3036 SoCs
cc706ee ARM: dts: rockchip: add reboot-mode node for rk3036 SoCs
cdad8f3 ARM: dts: rockchip: add the sdmmc for kylin board
9ece822 ARM: dts: rockchip: add the sdio power sequence for kylin board
28eba08 ARM: dts: rockchip: enable the high speed on sdio for kylin board
858e2cc ARM: dts: rockchip: enable the uart0 for kylin board
59aecc9 ASoC: rockchip: i2s: add support for grabbing output clock to codec
d2b5890 ARM: dts: rockchip: add i2s_clk_out to list of clocks used on rk3036 i2s
98c9c09 ARM: dts: rockchip: add hdmi/vop device node for rk3036
..

This series patches can apply into Heiko v4.6-armsoc/dts32 branch.
https://git.kernel.org/cgit/linux/kernel/git/mmind/linux-rockchip.git/log/?h=v4.6-armsoc/dts32
---

This series patches have the following decriptions:

PATCH[1/9]: ====> add hdmi/vop display node for rk3036
ARM: dts: rockchip: add hdmi/vop device node for rk3036

I fetch some vop and drm/rockchip patches from the Mark Yao branch.
https://github.com/markyzq/kernel-drm-rockchip/commits/drm-rockchip-next-2015-12-28

Add the following patches, verified on my github.
(https://github.com/Caesar-github/rockchip/commits/kylin-next)

....
cf2631b FORMLIST: clk: rockchip: rk3036: enable the CLK_IGNORE_UNUSED flag for hclk_vio_bus
a80ae4e FORMLIST: dt-bindings: add document for Innosilicon HDMI on Rockchip platform
b460291 FORMLIST: drm: rockchip/hdmi: add Innosilicon HDMI support
fe52935 FORMLIST: dt-bindings: add document for rk3036-vop
b556daa FORMLIST: drm/rockchip: vop: add rk3036 vop support
447e2b8 drm/rockchip: vop: spilt scale regsters
4ec4740 drm/rockchip: vop: spilt register related into rockchip_reg_vop.c
da528d7 drm/rockchip: vop: move interrupt registers into vop_data
a207639 drm/rockchip: vop: merge vop cfg_done into vop_data
1656da5 drm/rockchip: dw_hdmi: use encoder enable function
2b5f45b drm/rockchip: direct config connecter gate and out_mode
dcf2718 drm/rockchip: support atomic asynchronous commit
722dd38 drm/rockchip: Optimization vop mode set
f1b407a drm/rockchip: Convert to support atomic API
6ec2936 drm/rockchip: vop: replace dpms with enable/disable
5cfe7d1 drm/rockchip: Use new vblank api drm_crtc_vblank_*
ff1b1a3 UPSTREAM: drm: use dev_name as default unique name in drm_dev_alloc()
2155d11 drm: make drm_dev_set_unique() not use a format string
649f441 drm/rockchip: Constify function pointer structs
5096c80 UPSTREAM: drm: Pass 'name' to drm_encoder_init()
26c4d13 UPSTREAM: drm: Pass 'name' to drm_universal_plane_init()
0b795a0 UPSTREAM: drm: Pass 'name' to drm_crtc_init_with_planes()
...
----

PATCH[2/9-3/9]:====> Add the i2c clock output for rk3036

59aecc9 ASoC: rockchip: i2s: add support for grabbing output clock to codec
d2b5890 ARM: dts: rockchip: add i2s_clk_out to list of clocks used on rk3036 i2s

This patches is working for codec rt5616 on kylin board. (RK3036 SoCs)

That's needed the following rt5616 driver from Mark Brown Branch.
(cherry picked from git.kernel.org broonie/sound.git for-next)

cf94b7a UPSTREAM: ASoC: rt5616: rename some alsa control names
86f561d UPSTREAM: ASoC: rt5616: add devicetree document for rt5616
0e0f5f8 UPSTREAM: ASoC: rt5616: add an of_match table
263a330 UPSTREAM: ASoC: rt5616: Return error if device ID mismatch
0094139 UPSTREAM: ASoC: rt5616: add rt5616 codec driver

Notes:
I'm run it with the ubuntu 15.04 to set the configure.
./amixer "HP Playback Switch" 1
./amixer "HP Playback Volume" 20
./amixer "HPO MIX DAC1 Switch" 1
./amixer "OUT MIXR DAC R1 Switch" 1
./amixer "OUT MIXL DAC L1 Switch" 1
./amixer "Stereo DAC MIXR DAC R1 Switch" 1
./amixer "Stereo DAC MIXL DAC L1 Switch" 1

root at linaro-alip:/media/aplay# ./aplay pcm.wav
Playing sample: 2 ch, 48000 hz, 16 bit
..
That can be normal playing the music.
----

PATCH[4/9-6/9]: ====> Support wifi/bt module for kylin board
858e2cc ARM: dts: rockchip: enable the uart0 for kylin board
28eba08 ARM: dts: rockchip: enable the high speed on sdio for kylin board
9ece822 ARM: dts: rockchip: add the sdio power sequence for kylin board

The wifi/bt driver hasn't land in mainline, the driver is in here:
https://github.com/Caesar-github/rockchip/commit/76d91ce5ac2bff226f77b000e8a736bcd72b034f

/* create wpa_supplicant in /etc/wifi */
ctrl_interface=/var/run/wpa_supplicant
update_config=1

wpa_supplicant -Dnl80211 -c /etc/wifi/wpa_supplicant.conf -i wlan0 -B
wpa_cli add_network
wpa_cli set_network 1 ssid \"wxt\"
wpa_cli set_network 1 psk \"123456789\"
wpa_cli select_network 1
wpa_cli save_config

ifconfig wlan0 192.168.1.105
route add default gw 192.168.1.1

root at linaro-alip:/# ping 192.168.1.1
PING 192.168.1.1 (192.168.1.1) 56(84) bytes of data.
64 bytes from 192.168.1.1: icmp_seq=1 ttl=64 time=6.83 ms
64 bytes from 192.168.1.1: icmp_seq=2 ttl=64 time=184 ms
64 bytes from 192.168.1.1: icmp_seq=3 ttl=64 time=9.21 ms
64 bytes from 192.168.1.1: icmp_seq=4 ttl=64 time=6.84 ms
64 bytes from 192.168.1.1: icmp_seq=5 ttl=64 time=11.2 ms
64 bytes from 192.168.1.1: icmp_seq=6 ttl=64 time=9.24 ms
64 bytes from 192.168.1.1: icmp_seq=7 ttl=64 time=12.9 ms
64 bytes from 192.168.1.1: icmp_seq=8 ttl=64 time=7.02 ms
64 bytes from 192.168.1.1: icmp_seq=9 ttl=64 time=24.3 ms
64 bytes from 192.168.1.1: icmp_seq=10 ttl=64 time=13.6 ms
64 bytes from 192.168.1.1: icmp_seq=11 ttl=64 time=3.87 m
...

The wifi throughput:

iperf -s -i 1
...
[  4] 116.0-117.0 sec  2.88 MBytes  24.1 Mbits/sec
[  4] 117.0-118.0 sec  2.99 MBytes  25.0 Mbits/sec
[  4] 118.0-119.0 sec  3.01 MBytes  25.2 Mbits/sec
[  4] 119.0-120.0 sec  2.89 MBytes  24.2 Mbits/sec
[  4]  0.0-120.4 sec   332 MBytes  23.1 Mbits/sec
----

PATCH[7/9]: ====> sdmmc patch for kylin board
ARM: dts: rockchip: add the sdmmc for kylin board

You should mark it "okay" if you want to use the sdmmc.
This patch default is disabing the sdmmc since the sdmmc and
uart2(debug port) is reusing pin.
----

PATCH[8/9]: ====> reboot mode support
ARM: dts: rockchip: add reboot-mode node for rk3036 SoCs

This patch is depend on Andy's patches on
http://www.spinics.net/lists/kernel/msg2160362.html

----

PATCH[9/9]:====> DMA Patchs
ARM: dts: rockchip: add pl330-broken-no-flushp quirk for rk3036 SoCs

In order to be better read/write for emmc.
This patch is based on the following:(Fix broken DMAFLUSHP on Rockchips platform)

3055695 FROMLIST: DMA: dmaengine: expose max burst capability to clientmZ
(am from https://patchwork.kernel.org/patch/7399361/)
ed56bee FROMLIST: DMA: pl330: add quirk for broken no flushp
(am from https://patchwork.kernel.org/patch/7399371/)
0c43bc3 FROMLIST: Documentation: arm-pl330: add description of arm, pl330-broken-no-flushp
(am from https://patchwork.kernel.org/patch/7399371/)
623a699 FROMLIST: DMA: pl330: support burst mode for dev-to-mem and mem-to-dev transmit
(am from https://patchwork.kernel.org/patch/7399381/)
----


Changes in v3:
- As the perious discuss on https://patchwork.kernel.org/patch/5427131/,
  I think Mark likes do it in codec driver, I have to say I agree this
  patch in here since that's the i2s block output. I don't know if the
  Mark has changed his mind.
- Add the suspend/resume handle the clock.
- As Javier/Heiko discuss on https://patchwork.kernel.org/patch/7974311/,
  try to change dts with reset-gpios handle.
- fix the commit content in sdmmc patch.
- fix the commit content in pl330* quirk patch.

Caesar Wang (8):
  ARM: dts: rockchip: add hdmi/vop device node for rk3036
  ARM: dts: rockchip: add i2s_clk_out to list of clocks used on rk3036
    i2s
  ARM: dts: rockchip: enable the uart0 for kylin board
  ARM: dts: rockchip: enable the high speed on sdio for kylin board
  ARM: dts: rockchip: add the sdio power sequence for kylin board
  ARM: dts: rockchip: add the sdmmc for kylin board
  ARM: dts: rockchip: add reboot-mode node for rk3036 SoCs
  ARM: dts: rockchip: add pl330-broken-no-flushp quirk for rk3036 SoCs

Sonny Rao (1):
  ASoC: rockchip: i2s: add support for grabbing output clock to codec

 arch/arm/boot/dts/rk3036-kylin.dts | 62 ++++++++++++++++++++++++
 arch/arm/boot/dts/rk3036.dtsi      | 99 ++++++++++++++++++++++++++++++++++++--
 sound/soc/rockchip/rockchip_i2s.c  | 24 +++++++++
 3 files changed, 182 insertions(+), 3 deletions(-)

-- 
1.9.1
