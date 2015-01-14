From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 14 Jan 2015 14:44:44 +0100
Subject: [PATCH v3 0/7] Enable HDMI support on Exynos platforms
Message-ID: <1421243091-10778-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This is yet another approach to submit patches, which enables HDMI
support for two Exynos based platforms: UniversalC210 and Odroid X2/U3.

Beside DTS changes, this patchset adds parent domain support for Exynos
PM domains. This was the most controversial patch in the previous
attempts, but I hope I fixes all reported issues and made it really
generic. For more details see individual patches.

The patchset is based on my previous patch:
'ARM: DTS: Exynos: convert to generic power domain bindings'
(http://www.spinics.net/lists/linux-samsung-soc/msg40584.html)
and requires 2 patches that have been merged to v3.19-rc4:
'clk: samsung: exynos4: set parent of sclk_hdmiphy to hdmi'
(commit df019a5c0f7083001cb694f44821ca506425bda2) and
'PM / Domains: Export of_genpd_get_from_provider function'
(commit 7496fcbe8a643097efc061160e1c3b65ee2fa350).

Regards
Marek Szyprowski


Changelog:

v3:
- added a note on defining subdomains to generic PM domain binding
  documentation (requested by Ulf Hansson)

v2: (http://www.spinics.net/lists/linux-samsung-soc/msg40980.html)
- rewrote subdomains patch according to suggestions from Geert
  Uytterhoeven and Amit Daniel Kachhap.

v1 resend: (http://www.spinics.net/lists/linux-samsung-soc/msg39428.html)
- added handling of generic 'power-domains' binding in subdomains

v1: (http://www.spinics.net/lists/linux-samsung-soc/msg38914.html)
- resolved power domain on/off issue with 'clk: samsung: exynos4: set
  parent of mixer gate clock to hdmi' patch

v0: (http://www.spinics.net/lists/linux-samsung-soc/msg33498.html)
- first attempt, used 'always on' power domains hack


Patch summary:

Andrzej Hajda (1):
  ARM: dts: exynos5250: add display power domain

Marek Szyprowski (5):
  PM / Domains: Add a note about power domain subdomains
  ARM: Exynos: add support for sub-power domains
  ARM: dts: exynos4: add hdmi related nodes
  ARM: dts: exynos4: add dependency between TV and LCD0 power domains
  ARM: dts: exynos4412-odroid: enable hdmi support

Tomasz Stanislawski (1):
  ARM: dts: exynos4210-universal_c210: enable hdmi support

 .../bindings/arm/exynos/power_domain.txt           |  2 +
 .../devicetree/bindings/power/power_domain.txt     | 29 +++++++++++
 arch/arm/boot/dts/exynos4.dtsi                     | 41 ++++++++++++++++
 arch/arm/boot/dts/exynos4210-universal_c210.dts    | 57 ++++++++++++++++++++++
 arch/arm/boot/dts/exynos4210.dtsi                  |  8 +++
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi    | 44 +++++++++++++++++
 arch/arm/boot/dts/exynos4x12.dtsi                  | 11 +++++
 arch/arm/boot/dts/exynos5250.dtsi                  | 10 ++++
 arch/arm/mach-exynos/pm_domains.c                  | 28 +++++++++++
 9 files changed, 230 insertions(+)

-- 
1.9.2
