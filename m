From: leo.yan@linaro.org (Leo Yan)
Date: Fri, 24 Nov 2017 14:56:23 +0800
Subject: [PATCH] arm64: dts: Hi3660: Fix state id for 'CPU_NAP' state
In-Reply-To: <17639ecc-8ff8-e118-f6e1-51e2cfe4342b@arm.com>
References: <1511415614-9859-1-git-send-email-leo.yan@linaro.org>
 <17639ecc-8ff8-e118-f6e1-51e2cfe4342b@arm.com>
Message-ID: <20171124065623.GD13184@leoy-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sudeep,

On Thu, Nov 23, 2017 at 02:03:51PM +0000, Sudeep Holla wrote:
> Hi Daniel,
> 
> Thanks a lot for pointing me to this and having some useful discussion
> in private. That helped to dig a bit further on this.
> 
> On 23/11/17 05:40, Leo Yan wrote:
> > Thanks a lot for Vincent Guittot careful work to find bug for 'CPU_NAP'
> > idle state. From ftrace log we can observe CA73 CPUs can be easily waken
> > up from 'CPU_NAP' state but the 'waken up' CPUs doesn't handle anything
> > and sleep again; so there have tons of trace events for CA73 CPUs
> > entering and exiting idle state.
> > 
> > On Hi3660 CA73 has retention state 'CPU_NAP' for CPU idle, this state we
> > set its psci parameter as '0x0000001' and from this parameter it can
> > calculate state id is 1. Unfortunately ARM trusted firmware (ARM-TF)
> > takes 1 as a invalid value for state id, so the CPU cannot enter idle
> > state and directly bail out to kernel.
> > 
> > This commit changes psci parameter to '0x00000000' for state id = 0;
> > this id is accepted by ARM trusted firmware and finally CPU can stay
> > properly in 'CPU_NAP' state.
> > 
> 
> I would like to conditionally NACK this patch. If we can't update the
> ARM TF at all then, I will agree with this change reluctantly.

Thanks for reviewing. Just like Daniel said, we need to figure out the
right method for this. So suggestions are very welcome!

> This looks like an artifact of copy paste in ARM TF port for this
> platform. If you look as PSCI specification, CPU suspend parameter has
> some recommendations and it's good to follow then unless you have strong
> reasons not to.
> 
> As Daniel pointed to me, this patch is required to satisfy TF
> particularly [1]. Now that looks like copy pasted from Juno or FVP port
> and if you look deeper, it's clearly under !ARM_RECOM_STATE_ID_ENC [2]
> which was not copied IIUC :).

Thanks for sharing pointers. It's shame that the copying is not
correct for Hikey960 :)

Come back to recommended state id, I reviewed Juno board defintion and
I found it's not align with PSCI spec defintion, in ARM-TF Juno code
defines state as below [1]:

#define ARM_LOCAL_STATE_RUN     0
#define ARM_LOCAL_STATE_RET     1
#define ARM_LOCAL_STATE_OFF     2

In PSCI spec chapter "6.5 Recommended StateID Encoding" recommends power
state id as below:

0: Run
1: Standby
2: Retention
3: Powerdown

So could you confirm on Hikey960 we should follow PSCI definition for
state id definition?

> Juno's implementation is legacy as these recommendations were added
> later in the specification while Juno is 3 year old platform now.
> 
> Though strictly speaking it's not violation of the PSCI specification,
> but I would rather get this fixed not before it's too late and copied to
> the next generation of platforms. Since the firmware can be easily
> upgraded that shouldn't be that difficult.

If completely compliant with PSCI recommended state id, we need change
both for ARM-TF and kernel for this. In ARM-TF, I have sent PR [2].

For the kernel patch, we should change state id as below. Please let me
know if you have suggestion for this.

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index 12544c3..812437a 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -179,7 +179,7 @@
 
                        CPU_NAP: cpu-nap {
                                compatible = "arm,idle-state";
-                               arm,psci-suspend-param = <0x0000001>;
+                               arm,psci-suspend-param = <0x0000002>;
                                entry-latency-us = <7>;
                                exit-latency-us = <2>;
                                min-residency-us = <15>;
@@ -188,7 +188,7 @@
                        CPU_SLEEP: cpu-sleep {
                                compatible = "arm,idle-state";
                                local-timer-stop;
-                               arm,psci-suspend-param = <0x0010000>;
+                               arm,psci-suspend-param = <0x0010003>;
                                entry-latency-us = <40>;
                                exit-latency-us = <70>;
                                min-residency-us = <3000>;
@@ -197,7 +197,7 @@
                        CLUSTER_SLEEP_0: cluster-sleep-0 {
                                compatible = "arm,idle-state";
                                local-timer-stop;
-                               arm,psci-suspend-param = <0x1010000>;
+                               arm,psci-suspend-param = <0x1010033>;
                                entry-latency-us = <500>;
                                exit-latency-us = <5000>;
                                min-residency-us = <20000>;
@@ -206,7 +206,7 @@
                        CLUSTER_SLEEP_1: cluster-sleep-1 {
                                compatible = "arm,idle-state";
                                local-timer-stop;
-                               arm,psci-suspend-param = <0x1010000>;
+                               arm,psci-suspend-param = <0x1010033>;
                                entry-latency-us = <1000>;
                                exit-latency-us = <5000>;
                                min-residency-us = <20000>;


[1] https://github.com/ARM-software/arm-trusted-firmware/blob/master/include/plat/arm/common/arm_def.h#L43
[2] https://github.com/ARM-software/arm-trusted-firmware/pull/1171/commits/13d30c1c33609eb6cffadd50954e4301d2cab909

Thanks,
Leo Yan
