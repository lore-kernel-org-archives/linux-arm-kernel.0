From: marvin24@gmx.de (Marc Dietrich)
Date: Tue, 12 Mar 2013 11:35:43 +0100
Subject: [PATCH V2 3/9] ARM: dt: tegra: add bindings of power management
 configurations for PMC
In-Reply-To: <1363060962-9172-1-git-send-email-josephl@nvidia.com>
References: <1363060962-9172-1-git-send-email-josephl@nvidia.com>
Message-ID: <1715411.W3GXSOcQoS@fb07-iapwap2.physik.uni-giessen.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joseph,

Am Dienstag, 12. M?rz 2013, 12:02:42 schrieb Joseph Lo:
> The PMC mostly controls the entry and exit of the system from different
> sleep modes. Different platform or system may have different configurations.
> The power management configurations of PMC is represented as some
> properties. The system needs to define the properties when the system
> supports deep sleep mode (i.e. suspend).
> 
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> ---
> V2:
> * squash the patches that defined the PM bindings for PMC and the
>   implementation
> * replace the "unsigned long" with "u32" for the variables that are parsed
>   from DT
> ---
>  .../bindings/arm/tegra/nvidia,tegra20-pmc.txt      | 42 ++++++++++-
>  arch/arm/mach-tegra/pmc.c                          | 83
> ++++++++++++++++++++++ arch/arm/mach-tegra/pmc.h                          |
>  8 +++
>  3 files changed, 132 insertions(+), 1 deletion(-)
> 
> diff --git
> a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
> b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt index
> b5846e2..12a436e 100644
> --- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
> +++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
> @@ -1,14 +1,46 @@
>  NVIDIA Tegra Power Management Controller (PMC)
> 
> -Properties:
> +The PMC block interacts with an external Power Management Unit. The PMC
> +mostly controls the entry and exit of the system from different sleep
> +modes. It provides power-gating controllers for SoC and CPU power-islands.
> +
> +Required properties:
>  - name : Should be pmc
>  - compatible : Should contain "nvidia,tegra<chip>-pmc".
>  - reg : Offset and length of the register set for the device
> +
> +Optional properties:
>  - nvidia,invert-interrupt : If present, inverts the PMU interrupt signal.
>    The PMU is an external Power Management Unit, whose interrupt output
>    signal is fed into the PMC. This signal is optionally inverted, and then
>    fed into the ARM GIC. The PMC is not involved in the detection or
>    handling of this interrupt signal, merely its inversion.
> +- nvidia,suspend-mode : The suspend mode that the platform should use.
> +  Valid valuse are 0, 1 and 2:
> +  0 (LP0): CPU + Core voltage off and DRAM in self-refresh
> +  1 (LP1): CPU vlotage off and DRAM in self-refresh
> +  2 (LP2): CPU voltage off
> +- nvidia,core-power-req-active-high : Boolean, core power request
> active-high +- nvidia,sys-clock-req-active-high : Boolean, system clock
> request active-high +- nvidia,combined-power-req : Boolean, combined power
> request for CPU & Core +- nvidia,cpu-pwr-good-en : Boolean, CPU power good
> signal (from PMIC to PMC) +			   is enabled.
> +
> +Required properties when nvidia,suspend-mode is specified:
> +- nvidia,cpu-pwr-good-time : CPU power good time in uS.
> +- nvidia,cpu-pwr-off-time : CPU power off time in uS.
> +- nvidia,core-pwr-good-time : <Oscillator-stable-time Power-stable-time>
> +			      Core power good time in uS.
> +- nvidia,core-pwr-off-time : Core power off time in uS.
> +
> +Required properties when nvidia,suspend-mode=<0>:
> +- nvidia,lp0-vec : <start length> Starting address and length of LP0 vector
> +  The LP0 vector contains the warm boot code that is executed by AVP when
> +  resuming from the LP0 state. The AVP (Audio-Video Processor) is an ARM7
> +  processor and always being the first boot processor when chip is power
> on +  or resume from deep sleep mode. When the system is resumed from the
> deep +  sleep mode, the warm boot code will restore some PLLs, clocks and
> then +  bring up CPU0 for resuming the system.
> 
>  Example:
> 
> @@ -16,4 +48,12 @@ pmc at 7000f400 {
>  	compatible = "nvidia,tegra20-pmc";
>  	reg = <0x7000e400 0x400>;
>  	nvidia,invert-interrupt;
> +	nvidia,suspend-mode = <1>;
> +	nvidia,cpu-pwr-good-time = <2000>;
> +	nvidia,cpu-pwr-off-time = <100>;
> +	nvidia,core-pwr-good-ticks = <3845 3845>;
> +	nvidia,core-pwr-off-ticks = <458>;

s/ticks/time/

Marc
