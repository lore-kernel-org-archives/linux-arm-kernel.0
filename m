From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 3 Aug 2015 11:02:51 +0100
Subject: [Query] ARM64: Softlockup when using PSCI for secondary CPU_ON
In-Reply-To: <BY1PR0301MB1303EC5AAE8F0B4DAA70D15F82770@BY1PR0301MB1303.namprd03.prod.outlook.com>
References: <BY1PR0301MB1303EC5AAE8F0B4DAA70D15F82770@BY1PR0301MB1303.namprd03.prod.outlook.com>
Message-ID: <20150803100248.GA25627@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 03, 2015 at 05:12:00AM +0100, Sharma Bhupesh wrote:
> Hi ARM64 experts,
> 
> I am working on a Freescale ARM64 based SoC, which has 4 Cortex-A53 cores and I am using the
> PSCI conducts to turn on the secondary CPUs via a custom implementation of a secure runtime
> firmware (something similar to the ARM Trusted Firmware).
> 
> Following is my boot-flow:
> 
> - BootROM (runs in EL3, All secondaries are held up in reset) ->
> 
> - UEFI bootloader- PEI Phase (Runs only on Primary, starts up in EL3) ->
> 
> - Secure Firmware (runs in EL3, transitions primary core to EL2) ->
> 
> - UEFI bootloader- Rest of the Phases (Runs only on Primary, in EL2) ->
> 
> - UEFI Linux loader launches linux (Runs only on Primary, transitions core to EL1) ->
>
> - Linux runs and calls PSCI conducts to turn on secondary cores via smc calls to secure run-time firmware ->

Which version of Linux are you using?

Is Linux itself booted at EL1 or EL2?

EL2 is very strongly preferable unless you're already running a
hypervisor at EL2. That way Linux can ensure that things are initialised
correctly at EL2 (e.g. CNTVOFF), regardless of whether you want to use
KVM.

> - Now I can see that the ARM64 linux is able to recognize that the secondaries are boot'ed properly:
> 
> PSCI Logs:
> ----------
> psci: probing for conduit method from DT.
> psci: PSCIv0.2 detected in firmware.
> psci: Using standard PSCI v0.2 function IDs
> ..
> 
> Architected cp15 timer(s) running at 25.00MHz (phys).
> sched_clock: 56 bits at 25MHz, resolution 40ns, wraps every 2748779069440ns
> 
> ..
> 
> CPU1: Booted secondary processor
> Detected VIPT I-cache on CPU1
> CPU2: Booted secondary processor
> Detected VIPT I-cache on CPU2
> CPU3: Booted secondary processor
> Detected VIPT I-cache on CPU3
> Brought up 4 CPUs
> SMP: Total of 4 processors activated.

Ok. This all looks fine.

> - However, when the Linux boot proceeds further, I see softlockups which usually show that one
> of the secondaries was stuck in 'secondary_start_kernel' (detailed logs below).
>
> - When I turn of CONFIG_SMP from the .config, I can see that the softlockups disappear. So, I am
> correlating these softlockups to SMP and PSCI conducts.

Ok, that likely means it's in the idle loop. Given that the CPUs made it
into the kernel this sounds like a generic SMP issue rather than
something specific to PSCI.

> preempt self-detected stall on CPU { 3}  (t=17194 jiffies g=-267 c=-268 q=1)

> INFO: rcu_preempt detected stalls on CPUs/tasks: { 1 2} (detected by 0, t=287104493908 jiffies, g=-267, c=-268, q=2)

It looks like your timekeeping has gone wrong. As mentioned above, I'd
suspect that CNTVOFF_EL2 is not programmed consistently across all CPUs.

Are you able to boot Linux at EL2 instead? Or can you verify that
CNTVOFF_EL2 is initialised?

Thanks,
Mark.
