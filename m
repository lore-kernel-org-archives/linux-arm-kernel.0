From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 30 Sep 2014 13:51:41 -0400 (EDT)
Subject: [PATCH v7 5/7] qcom: cpuidle: Add cpuidle driver for QCOM cpus
In-Reply-To: <7hmw9hypj9.fsf@deeprootsystems.com>
References: <1411779495-39724-1-git-send-email-lina.iyer@linaro.org>
 <1411779495-39724-6-git-send-email-lina.iyer@linaro.org>
 <20140929153154.GF2165@e102568-lin.cambridge.arm.com>
 <7hmw9hypj9.fsf@deeprootsystems.com>
Message-ID: <alpine.LFD.2.11.1409301349260.5311@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 30 Sep 2014, Kevin Hilman wrote:

> Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> writes:
> 
> > Hi Lina,
> >
> > On Sat, Sep 27, 2014 at 01:58:13AM +0100, Lina Iyer wrote:
> >> Add cpuidle driver interface to allow cpus to go into C-States. Use the
> >> cpuidle DT interface common across ARM architectures to provide the
> >> C-State information to the cpuidle framework.
> >> 
> >> Supported modes at this time are clock gating (wfi) and cpu power down
> >> (Standalone PC or spc).
> >> 
> >> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> >> ---
> >>  .../bindings/arm/msm/qcom,idle-state.txt           | 72 +++++++++++++++++
> >>  drivers/cpuidle/Kconfig.arm                        |  7 ++
> >>  drivers/cpuidle/Makefile                           |  1 +
> >>  drivers/cpuidle/cpuidle-qcom.c                     | 89 ++++++++++++++++++++++
> >>  4 files changed, 169 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,idle-state.txt
> >>  create mode 100644 drivers/cpuidle/cpuidle-qcom.c
> >> 
> >> diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,idle-state.txt b/Documentation/devicetree/bindings/arm/msm/qcom,idle-state.txt
> >> new file mode 100644
> >> index 0000000..47095b9
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/arm/msm/qcom,idle-state.txt
> >> @@ -0,0 +1,72 @@
> >> +QCOM Idle States for cpuidle driver
> >> +
> >> +ARM provides idle-state node to define the cpuidle states, as defined in [1].
> >> +cpuidle-qcom is the cpuidle driver for Qualcomm SoCs and uses these idle
> >> +states. Idle states have different enter/exit latency and residency values.
> >> +The idle states supported by the QCOM SoC are defined as -
> >> +
> >> +    * WFI
> >> +    * Retention
> >> +    * Standalone Power Collapse (Standalone PC or SPC)
> >> +    * Power Collapse (PC)
> >> +
> >> +WFI: WFI does a little more in addition to architectural clock gating.  ARM
> >
> > This may be misleading. Call it PlatformWFI or something like that, not WFI if
> > that's not what it is.
> 
> This gets at a little pet peeve of mine: 
> 
> IMO, naming any state with "WFI" is a bit confusing, because typically
> *every* idle state is entered by one (or more) CPU executing WFI, no?

Agreed.

The only state called "WFI" should be the one that only executes the WFI 
instruction without any other hardware setup around it.


Nicolas
