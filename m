From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Fri, 22 Dec 2017 15:22:51 +0100
Subject: [PATCH v2] arm64: dts: Hi3660: Fix up psci state id
In-Reply-To: <1513069954-22827-1-git-send-email-leo.yan@linaro.org>
References: <1513069954-22827-1-git-send-email-leo.yan@linaro.org>
Message-ID: <CAKfTPtANDTS7PJrQcTqT0JFpbqBGbB_kz8i0f2g1akgbtBW7Mg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Leo,

Sorry for jumping late in the discussion but should  we also remove
the NAP state from the property cpu-idle-states of the CPUs because
this state not supported by the platform at least for now and may be
not in a near future ?

Then, I have another question regarding the update of the
psci-suspend-parameter. These changes implies an update of the psci
firmawre which means that we will now have 2 different firmware
version compatible with 2 different dt.

Is there any way to check that the ATF on the board is the one that
compatible with the parameter with something like a version ? I
currently use the previous firmware which works fine with current
kernel and dt binding once the NAP state is removed from the table.
When moving on recent kernel, I will have to take care of updating the
firmware and if i need to go back on a previous kernel, i will have to
make sure that i have the right ATF version. This make a lot of chance
of having the wrong configuration

Regards,
Vincent

On 12 December 2017 at 10:12, Leo Yan <leo.yan@linaro.org> wrote:
> Thanks a lot for Vincent Guittot careful work to find bug for 'CPU_NAP'
> idle state.  From ftrace log we can observe CA73 CPUs can be easily
> waken up from 'CPU_NAP' state but the 'waken up' CPUs doesn't handle
> anything and sleep again; so there have tons of trace events for CA73
> CPUs entering and exiting idle state.
>
> On Hi3660 CA73 has retention state 'CPU_NAP' for CPU idle, this state we
> set its psci parameter as '0x0000001' and from this parameter it can
> calculate state id is 1.  Unfortunately ARM trusted firmware (ARM-TF)
> takes 1 as a invalid value for state id, so the CPU cannot enter idle
> state and directly bail out to kernel.
>
> We want to create good practice for psci parameters platform definition,
> so review the psci specification. The spec "ARM Power State Coordination
> Interface - Platform Design Document (ARM DEN 0022D)" recommends state
> ID in chapter "6.5 Recommended StateID Encoding".  The recommended power
> state IDs can be presented by below listed values; and it divides into
> three fields, every field can use 4 bits to present power states
> corresponding to core level, cluster level and system level:
>   0: Run
>   1: Standby
>   2: Retention
>   3: Powerdown
>
> This commit changes psci parameter to compliance with the suggested
> state ID in the doc.  Except we change 'CPU_NAP' state psci parameter
> to '0x0000002', this commit also changes 'CPU_SLEEP' and 'CLUSTER_SLEEP'
> state parameters to '0x0010003' and '0x1010033' respectively.
>
> Credits to Daniel, Sudeep and Soby for suggestion and consolidation.
>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Soby Mathew <Soby.Mathew@arm.com>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> index ab0b95b..99d5a46 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> @@ -147,7 +147,7 @@
>
>                         CPU_NAP: cpu-nap {
>                                 compatible = "arm,idle-state";
> -                               arm,psci-suspend-param = <0x0000001>;
> +                               arm,psci-suspend-param = <0x0000002>;
>                                 entry-latency-us = <7>;
>                                 exit-latency-us = <2>;
>                                 min-residency-us = <15>;
> @@ -156,7 +156,7 @@
>                         CPU_SLEEP: cpu-sleep {
>                                 compatible = "arm,idle-state";
>                                 local-timer-stop;
> -                               arm,psci-suspend-param = <0x0010000>;
> +                               arm,psci-suspend-param = <0x0010003>;
>                                 entry-latency-us = <40>;
>                                 exit-latency-us = <70>;
>                                 min-residency-us = <3000>;
> @@ -165,7 +165,7 @@
>                         CLUSTER_SLEEP_0: cluster-sleep-0 {
>                                 compatible = "arm,idle-state";
>                                 local-timer-stop;
> -                               arm,psci-suspend-param = <0x1010000>;
> +                               arm,psci-suspend-param = <0x1010033>;
>                                 entry-latency-us = <500>;
>                                 exit-latency-us = <5000>;
>                                 min-residency-us = <20000>;
> @@ -174,7 +174,7 @@
>                         CLUSTER_SLEEP_1: cluster-sleep-1 {
>                                 compatible = "arm,idle-state";
>                                 local-timer-stop;
> -                               arm,psci-suspend-param = <0x1010000>;
> +                               arm,psci-suspend-param = <0x1010033>;
>                                 entry-latency-us = <1000>;
>                                 exit-latency-us = <5000>;
>                                 min-residency-us = <20000>;
> --
> 2.7.4
>
