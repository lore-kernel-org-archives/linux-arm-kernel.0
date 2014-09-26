From: tharvey@gateworks.com (Tim Harvey)
Date: Thu, 25 Sep 2014 22:59:30 -0700
Subject: [PATCH RFC 0/2] ARM: imx: ventana: enable LDO-bypass mode
Message-ID: <1411711172-16498-1-git-send-email-tharvey@gateworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The IMX6 has some internal LDO regulators provided by the anatop regulator
block that can regulate the arm, soc, gpu/vpu core supplies. Alternatively a
design can supply vdd_arm and vdd_soc externally via a PMIC to provide a lower
power draw (switches are more efficient that ldo's).

The first patch allows a device-tree property to put the anatop core regulators
in bypass mode so that an external PMIC regulator can be used. It is
important that the anatop regulators be put in bypass mode because otherwise
the external inputs need to be 125mV above what the datasheets specify for
the various CPU frequency operating points defined in the imx6q.dtsi and
imx6dl.dtsi.

I would like some feedback as to how best to specify or determine if the
anatop regulators should be placed in bypass mode and I see the following
options:
 1) use a device-tree node on the core regulators to put them in bypass mode
    (what I've done for this patchset).
 2) depend on the bootloader to put the LDO's in bypass mode (by setting them
    to fully on) which the anatop-regulator driver will recognized and
    keep them in bypass mode (per Phillip's commit d38018f). The downside of
    this is that it creates a horrible dependence between the kernel and the
    bootloader.
 3) have the imx6q-cpufreq driver (the sole consumer of the arm, soc, gpu/vpu
    regulators) determine that the arm and soc regulators are 'not' the
    anatop regulators and if so set the anatop core regulators in bypass mode
    as this can only mean an external PMIC is being used. I'm not exactly
    sure 'how' to do this (how can a regulator consumer determine the provider 
    of a regulator?) and I'm also not quite sure if this assumption is always
    true. What if external regulators are used on a design but one or both need
    further regulation?

I have tested this patchset with the Gateworks Ventana GW5400 board and
verified the following:
  a) at the various CPU setpoints supported by the CPU on this board
     (Automative IMX6Q at 1GHz) VDD_ARM and VDD_SOC (both the inputs to the
     IMX6 and the outputs of the bypassed LDO) are at the voltage setpoint
     requested for the CPU frequency.
  b) the PMU_REG_CORE REG0/REG1/REG2 get set to full scale (bypassed) and stay
     that way.

Another possible concern with LDO-bypass mode is that in the case of a 1.2GHz
CPU, the datasheet specifies that the internal LDO's must be used at the 1.2GHz
frequency setpoint as they produce less noise as an external switcher. This
means that the imx6q-cpufreq driver would need to be the one making the
decision to enable bypass mode and would do so per operating setpoint.

Note that the only imx6 boards I know of in mainline that appear to have a PMIC
(based on their devicetree) are:
 - dmo-edmqmx6 (pfuze100)
 - imx6sl-evk (pfuze100)
 - gw54xx (pfuze100)
 - gw53xx/gw52xx/gw51xx/gw552x (ltc3676)
 - phytec-pfla02 (da9063)
 - riotboard (pfuze100)
 - sabreauto (pfuze100)
 - sabresd (pfuze100)

I've cc'd the authors of the original commits of the above device-trees as
they likely have an interest in LDO-bypass mode.

Tim Harvey (2):
  regulator: anatop: allow LDO bypass to be set from device-tree
  ARM: imx: ventana: enable LDO bypass mode for GW54xx

 .../bindings/regulator/anatop-regulator.txt        |  1 +
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi              | 63 ++++++++++++++++------
 drivers/regulator/anatop-regulator.c               |  4 +-
 3 files changed, 51 insertions(+), 17 deletions(-)

-- 
1.8.3.2
