From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 24 Nov 2015 16:06:00 -0800
Subject: [PATCH RESEND v2 0/4] SMP support for Broadcom NSP
In-Reply-To: <1446839371-22601-1-git-send-email-kapilh@broadcom.com>
References: <1446839371-22601-1-git-send-email-kapilh@broadcom.com>
Message-ID: <5654FB68.60007@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/11/15 11:49, Kapil Hali wrote:
> This is the second iteration in the series.
> 
> Changes in v2:
> Removed the pen_holding method of SMP bringup for NSP SoC and
> replaced it with simple wakeup of secondary core using ARM IPI.
> 
> 
> This series adds SMP support for Broadcom's Northstar Plus SoC.
> 
> There are similar SMP enablement methods for many ARMv7 bsed SoCs.
> BCM NSP SoC, has a typical such mechanism - after power-on, the
> secondary core is held in a standby state, primary core provides a
> startup address for the secondary core and wakes it up. Booting of
> the secondary core is serialized using pen_release global variable.
> 
> The startup address is programmed at a special register location
> which is defined in the device tree using a "secondary-boot-reg"
> property in a node whose "enable-method" property matches.
> 
> The first patch adds cpu-enable-method in the device tree bindings
> documentation. It also updates ARM CPU device tree documentation
> with Broadcom Northstar Plus CPU details.
> 
> The second patch adds SMP support to the BCM NSP device tree file.
> 
> The third patch, enables SMP on BCM NSP. It also consolidates
> common SMP handling between BCM NSP and BCM Kona.
> 
> The final patch, enables SMP on BCM 4708 and this patch is pulled
> in from Jon Mason's patch from the mailing list.
> 
> This patch series is constructed based on Linux v4.3-rc2.
> 
> The source code is available at GITHUB:
> https://github.com/Broadcom/cygnus-linux/tree/nsp-smp-v1

Kapil, were there additional changes requested for this patch series to
be applied? The secondary-boot-reg property should probably be made part
of the CPU node, even though you are strictly following the existing
Kona SMP binding here (which was partially wrong on that subject).

Could you resubmit these patches if there is anything that needs
changing? Thanks!

> 
> Jon Mason (1):
>   ARM: BCM: Add SMP support for Broadcom 4708
> 
> Kapil Hali (3):
>   dt-bindings: add SMP enable-method for Broadcom NSP
>   ARM: dts: add SMP support for Broadcom NSP
>   ARM: BCM: Add SMP support for Broadcom NSP
> 
>  .../bindings/arm/bcm/brcm,nsp-cpu-method.txt       | 36 +++++++++
>  Documentation/devicetree/bindings/arm/cpus.txt     |  1 +
>  arch/arm/boot/dts/bcm-nsp.dtsi                     | 33 ++++++---
>  arch/arm/boot/dts/bcm4708.dtsi                     |  2 +
>  arch/arm/mach-bcm/Kconfig                          |  3 +
>  arch/arm/mach-bcm/Makefile                         | 11 ++-
>  arch/arm/mach-bcm/bcm_nsp.h                        | 19 +++++
>  arch/arm/mach-bcm/{kona_smp.c => platsmp.c}        | 85 +++++++++++++++++++---
>  8 files changed, 167 insertions(+), 23 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,nsp-cpu-method.txt
>  create mode 100644 arch/arm/mach-bcm/bcm_nsp.h
>  rename arch/arm/mach-bcm/{kona_smp.c => platsmp.c} (75%)
> 


-- 
Florian
