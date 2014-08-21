From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 20 Aug 2014 17:25:49 -0700
Subject: [PATCH v4 3/8] qcom: spm: Add Subsystem Power Manager driver
 (SAW2)
In-Reply-To: <20140820032432.GA40136@pluto>
References: <1408486537-6358-1-git-send-email-lina.iyer@linaro.org>
 <1408486537-6358-4-git-send-email-lina.iyer@linaro.org>
 <53F40191.5080106@codeaurora.org> <20140820032432.GA40136@pluto>
Message-ID: <53F53C8D.9060009@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/19/14 20:24, Lina Iyer wrote:
> On Tue, Aug 19, 2014 at 07:01:53PM -0700, Stephen Boyd wrote:
>> On 08/19/14 15:15, Lina Iyer wrote:
>>> SPM is a hardware block that controls the peripheral logic surrounding
>>> the application cores (cpu/l$). When the core executes WFI instruction,
>>> the SPM takes over the putting the core in low power state as
>>> configured. The wake up for the SPM is an interrupt at the GIC, which
>>> then completes the rest of low power mode sequence and brings the core
>>> out of low power mode.
>>>
>>> The SPM has a set of control registers that configure the SPMs
>>> individually based on the type of the core and the runtime conditions.
>>> SPM is a finite state machine block to which a sequence is provided and
>>> it interprets the bytes  and executes them in sequence. Each low power
>>> mode that the core can enter into is provided to the SPM as a sequence.
>>>
>>> Configure the SPM to set the core (cpu or L2) into its low power mode,
>>> the index of the first command in the sequence is set in the SPM_CTL
>>> register. When the core executes ARM wfi instruction, it triggers the
>>> SPM state machine to start executing from that index. The SPM state
>>> machine waits until the interrupt occurs and starts executing the rest
>>> of the sequence until it hits the end of the sequence. The end of the
>>> sequence jumps the core out of its low power mode.
>>>
>>> Signed-off-by: Praveen Chidambaram <pchidamb@codeaurora.org>
>>> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>>
>> Why isn't this code combined with the cpuidle driver in qcom-cpuidle.c,
>> spm-devices.c, and qcom-pm.c? All these files are interacting with the
>> same hardware, I'm confused why we have to have 4 different files and
>> all these different patches to support this. Basically patches 3, 4, 6
>> and 7 should be one file under drivers/cpuidle/ named qcom-cpuidle or
>> saw-cpuidle.
>
> They all interact with the one hardware, you are right about that. But
> each
> of these have a responsibility and provide certain functionality that
> builds up into the idle framework.
> Let me explain - The hardware driver spm.c doesnt care what the code
> calling the driver, intends to do. All it knows is to write to right
> register. And it can write to only one SPM block. There are multiple SPM
> blocks which need to be managed and thats provided by spm-devices. The
> cpuidle framework or the hotplug framework needs to do the same thing.
> The common functionality between idle and hotplug is abstraced out in
> msm-pm.c.  platsmp.c and cpuidle-qcom.c both would need the same
> functionality.

I can see the end result in the downstream vendor tree and it isn't
pretty. The code winds through a handful of different files. The spm.c
file is basically just a bunch of functions to read and write to an SPM.
By itself it's pretty much worthless and doesn't stand on its own.
spm-devices is where we would actually probe a driver for the device
that is read/written in spm.c. At the least, these two files should be
combined into one driver.

Right now just to support cpuidle it seems that it could all be in one
file. When we get to hotplug, why don't we use cpuidle_play_dead() on
ARM so that this cpuidle driver can configure the SPM for the deepest
idle state and power off the CPU? The only problem I see is that we
would need another hook for the cpu_kill() op so that we can wait for
the state machine to finish bringing down the CPU. That would remove the
need for msm-pm.c?

This would handle the cpuidle_play_dead() part. Alternatively we call
cpuidle_play_dead() from the cpu_die() hook in the platform layer, but
I'd prefer we call it directly in arch code if we can.

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 7c4fada440f0..fef953ecde22 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -26,6 +26,7 @@
 #include <linux/completion.h>
 #include <linux/cpufreq.h>
 #include <linux/irq_work.h>
+#include <linux/cpuidle.h>
 
 #include <linux/atomic.h>
 #include <asm/smp.h>
@@ -290,8 +291,9 @@ void __ref cpu_die(void)
         * The return path should not be used for platforms which can
         * power off the CPU.
         */
-       if (smp_ops.cpu_die)
-               smp_ops.cpu_die(cpu);
+       if (cpuidle_play_dead())
+               if (smp_ops.cpu_die)
+                       smp_ops.cpu_die(cpu);
 
        pr_warn("CPU%u: smp_ops.cpu_die() returned, trying to resuscitate\n",
                cpu);


>
> The SPM is not simple register write. It needs quite a bit of
> configuration and to make it functional and then you may do register
> writes.  SPM also provides voltage control functionality, which again
> has a lot of support code that need to ensure the hardware is in the
> correct state before you do that one register write to set the voltage.
> Again, this and other functionality add up to a whole lot of code to be
> clumped up in qcom-cpuidle.c and duplicated for hotplug again.  It is
> beneficial to have them this way. Bear with me, as I build up this
> framework to support the idle and hotplug idle framework.
>

Yes I'm not quite sure how we would handle adding the regulator code. In
some cases each CPU's SAW is controlling a regulator and in other cases
there's only the L2 SAW controlling a regulator. We would need these
regulators to exist even if we don't support cpuidle, so we'd need to
register it somehow. I was wondering if we shouldn't be using the
register in the SAW to change the voltage, instead we should go directly
to the PMIC and write the regulator driver on top of the PMIC interface.
The spm code could then look at those regulators to figure out what
voltage the supply is configured to so that it can be programmed into
the SPM and used during any power restoring activities. I'm not sure if
we can even write the PMIC registers though, or if those registers are
locked down thus requiring us to use the SPM interface to change
voltages. It would be nice to split this out somehow though. Another
idea would be to make some shim driver that creates two child devices
for the regulator and cpuidle drivers and have the shim driver make a
regmap that both drivers use.

>>
>>>
>>> diff --git a/drivers/soc/qcom/spm.c b/drivers/soc/qcom/spm.c
>>> new file mode 100644
>>> index 0000000..19b79d0
>>> --- /dev/null
>>> +++ b/drivers/soc/qcom/spm.c
>>> @@ -0,0 +1,195 @@
>> [..]
>>> +
>>> +static void flush_shadow(struct msm_spm_driver_data *drv,
>>> +        unsigned int reg_index)
>>> +{
>>> +    __raw_writel(drv->reg_shadow[reg_index],
>>> +            drv->reg_base_addr + drv->reg_offsets[reg_index]);
>>> +}
>>
>> What's the use of the "shadow" functionality? Why can't we just read and
>> write the registers directly without having to go through a register
>> cache?
> Helps speed up reads and write, when you have multiple writes. Also, is
> an excellent mechanism to know the state SPM was configured to, in the
> event of a mishap.

Huh? How can writing something into memory and then writing it to the
device be faster than writing it directly to the device? If we need to
know how the SPM was configured I assume we would know by printks or by
inspecting the code. I still don't see a reason for this.

>>
>>> +
>>> +static void load_shadow(struct msm_spm_driver_data *drv,
>>> +        unsigned int reg_index)
>>> +{
>>> +    drv->reg_shadow[reg_index] = __raw_readl(drv->reg_base_addr +
>>> +                        drv->reg_offsets[reg_index]);
>>
>> Please use readl_relaxed/writel_relaxed. The raw accessors don't
>> byte-swap and fail horribly for big-endian kernels.
> OK. But does it matter that the SoC the code is expected to run is
> little-endian?

big-endian kernels work on these platforms. Nobody is extensively
testing it but putting down more roadblocks to using it isn't helpful.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
