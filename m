From: nm@ti.com (Nishanth Menon)
Date: Tue, 1 Apr 2014 11:40:03 -0500
Subject: OMAP baseline test results for v3.14-rc4 (SDP2430 fail to boot
 - mmc fs)
In-Reply-To: <alpine.DEB.2.02.1402241832001.23725@utopia.booyaka.com>
References: <alpine.DEB.2.02.1402241832001.23725@utopia.booyaka.com>
Message-ID: <533AEBE3.40109@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/24/2014 12:35 PM, Paul Walmsley wrote:

> Boot to userspace:
>     FAIL ( 1/12): 2430sdp
> http://www.pwsan.com/omap/testlogs/test_v3.14-rc4/20140224102552/boot/2430sdp/

Figured out why 2430sdp does not boot with MMC filesystem.
DEVCONTROL0,1 needs to be modelled in DT-only boot as well.

OMAP243X SDP # md.l 0x490022e8 1
490022e8: 002fff80    ../.
OMAP243X SDP # md.l 0x49002274 1
49002274: 04000000    ....
OMAP243X SDP # mw.l 0x490022e8 802fff80
^^ bit 31 is step (a) below
OMAP243X SDP # mw.l 0x49002274 05000000
^^ bit 24 is step (b) below
OMAP243X SDP # md.l 0x49002274 1
49002274: 05000000    ....
OMAP243X SDP # md.l 0x490022e8 1
490022e8: 802fff80    ../.
OMAP243X SDP # boot

happily detects the mmc partitions. http://slexy.org/view/s21QaCLMWQ

we modelled pbias in dt so far - this is necessary, but two other
steps are needed as well (based on arch/arm/mach-omap2/hsmmc.c used in
non-dt boot):
a) OMAP243X_CONTROL_DEVCONF1:: OMAP243X_MMC1_ACTIVE_OVERWRITE should
be tweaked based on vdd
b) OMAP2_CONTROL_DEVCONF0::OMAP2_MMCSDIO1ADPCLKISEL should be set for
internal_clk (sdp2430).

-- 
Regards,
Nishanth Menon
