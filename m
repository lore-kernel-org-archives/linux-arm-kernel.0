From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Thu, 15 Oct 2015 09:34:25 +0800
Subject: [PATCH v6 0/10] Fix broken DMAFLUSHP on Rockchips platform
Message-ID: <1444872865-2169-1-git-send-email-shawn.lin@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The purpose of the DMAFLUSHP instruction:
- Tell the peripheral to clear its status and control registers.
- Send a message to the peripheral to resend its level status.

There are 3 timings described in PL330 Technical Reference Manual:
- Timing 1: Burst request, can work well without DMAFLUSHP.
- Timing 2: Single and burst request, DMAC will ignore the single
	    transfer request. This timing happens if there are single
	    and burst request.
- Timing 3: Single transfers for a burst request, DMAC should signals
	    datype to request the peripheral to flush the contents of
	    any control registers. This timing happens if there is
	    not enough MFIFO to places the burst data.

A peripheral may signal a DMA request during the execution of
DMAFLUSHP instruction, that cause DMA request being ignored by DMAC.

But DMAC and all peripherals on RK3X SoCs DO NOT support DMAFLUSHP.
It can't send a message to the peripheral to resend DMA request,
and the peripheral can't acknowledge a flush request from DMAC.
So all DMA requests should NOT be ignored by DMAC, and DMAC will not
notify the peripheral to flush.

To fix this problem, we need:
- Do NOT execute DMAFLUSHP instruction.
- Timing 2 and timing 3 should not happen.

Because on RK3X SoCs, there are 6 or below  channels and 32 MFIFO depth
for DMAC_BUS, and 8 channels and 64 MFIFO depth for DMAC_PERI, it is
impossible to hit the timing 3 if burst length is equal or less than 4.

Since the request type signal by the peripheral can only be set by
software. We can set Rockchip Soc's GRF_PERIDMAC_CON0[2:1] to select single
or burst request, if it is set b01,  all of the peripharals will signal a brust
request. So the timing 2 will not happen, too.

So DMAC on RK3X can support single or burst transfer, but can't support
mixed transfer.

Because burst transfer is more efficient than single transfer, this is
confirmed by our ASIC team, who strongly suggest to use burst transfer.
And this is confirmed by Addy's test on RK3288-Pink2 board, the speed of
spi flash burst transfer will increase about two times than single transfer.
Also, I have tested dw_mmc with pl330 on RK3188 platform to double confirm
the result. That means burst transfer is reansonable.

So we need a quirk not to execute DMAFLUSHP instruction and to use burst
transfer.

Note:
- The Rockchip Soc default value of GRF_PERIDMAC_CON0[2:1] is b01. To
  support brust transfer, these bits should not be changed in bootloader.


Changes in v6:
- remove expose quirk and add dma max_burst caps for clients
- remove expose quirks and add max_burst for dmaengine
- remove get quirks and add get slave caps
- remove quirks and get dma caps in order to limit burst

Changes in v5:
- add Mark's tag for spi changes
- remove unnecessary whitespace change
- use switch statement for i2s quirk
- use switch statement for dma_quirk's manipulation

Changes in v4:
- remove spi & i2s dts changes and query quirk from dmaengine API
  suggeseted by Mark.
- fix typo
- Add dmaengine_get_quirk hook and implement it for pl330

Changes in v3:
- add Sunny's tag
- add more rockchip drivers' changes in this patchset
- add Reviewed-by: Sonny Rao <sonnyrao@chromium.org>

Changes in v2:
- amend the author
- reorder the patches suggested by Doug
- add Reviewed-by: Doug Anderson <dianders@chromium.org> for
  rk3288.dtsi patch and arm-pl330.txt patch
- fix Olof's mail address

Changes in v1:
- add From original author.
- remove Sunny's tag
- rename broken-no-flushp to "arm,pl330-broken-no-flushp" suggested
  by Krzysztof.

Addy Ke (3):
  DMA: pl330: add quirk for broken no flushp
  ARM: dts: Add arm,pl330-broken-no-flushp quirk for rk3288 platform
  spi: rockchip: modify DMA max burst to 1

Boojin Kim (1):
  DMA: pl330: support burst mode for dev-to-mem and mem-to-dev transmit

Shawn Lin (5):
  Documentation: arm-pl330: add description of
    arm,pl330-broken-no-flushp
  ARM: dts: Add arm,pl330-broken-no-flushp quirk for rk3xxx platform
  DMA: dmaengine: expose max burst capability to clients
  DMA: pl330: add max burst for dmaengine
  snd: dmaengine-pcm: add snd_dmaengine_pcm_get_caps interface

Yiwei Cai (1):
  ASoC: rockchip_i2s: modify DMA max burst to 1

 .../devicetree/bindings/dma/arm-pl330.txt          |   1 +
 arch/arm/boot/dts/rk3288.dtsi                      |   3 +
 arch/arm/boot/dts/rk3xxx.dtsi                      |   3 +
 drivers/dma/dmaengine.c                            |   1 +
 drivers/dma/pl330.c                                | 106 +++++++++++++++------
 drivers/spi/spi-rockchip.c                         |  12 ++-
 include/linux/dmaengine.h                          |   4 +
 sound/soc/rockchip/rockchip_i2s.c                  |  18 +++-
 sound/soc/soc-generic-dmaengine-pcm.c              |  24 +++++
 9 files changed, 138 insertions(+), 34 deletions(-)

-- 
2.3.7
