From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 24 Jul 2013 10:02:34 -0700
Subject: [PATCH V4 2/4] ARM: tegra114: Reprogram GIC CPU interface to
 bypass IRQ on CPU PM entry
In-Reply-To: <1374666419.23756.55.camel@jlo-ubuntu-64.nvidia.com>
References: <1374225926-26832-1-git-send-email-josephl@nvidia.com>
 <1374225926-26832-3-git-send-email-josephl@nvidia.com>
 <20130723154438.GA2864@dhcp-172-17-186-34.nvidia.com>
 <1374666419.23756.55.camel@jlo-ubuntu-64.nvidia.com>
Message-ID: <51F008AA.2030101@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/24/2013 04:46 AM, Joseph Lo wrote:
> On Tue, 2013-07-23 at 23:44 +0800, Thierry Reding wrote:
>> * PGP Signed by an unknown key
>>
>> On Fri, Jul 19, 2013 at 05:25:24PM +0800, Joseph Lo wrote:
>>> There is a difference between GICv1 and v2 when CPU in power management
>>> mode (aka CPU power down on Tegra). For GICv1, IRQ/FIQ interrupt lines
>>> going to CPU are same lines which are also used for wake-interrupt.
>>> Therefore, we cannot disable the GIC CPU interface if we need to use same
>>> interrupts for CPU wake purpose. This creates a race condition for CPU
>>> power off entry. Also, in GICv1, disabling GICv1 CPU interface puts GICv1
>>> into bypass mode such that incoming legacy IRQ/FIQ are sent to CPU, which
>>> means disabling GIC CPU interface doesn't really disable IRQ/FIQ to CPU.
>>>
>>> GICv2 provides a wake IRQ/FIQ (for wake-event purpose), which are not
>>> disabled by GIC CPU interface. This is done by adding a bypass override
>>> capability when the interrupts are disabled at the CPU interface. To
>>> support this, there are four bits about IRQ/FIQ BypassDisable in CPU
>>> interface Control Register. When the IRQ/FIQ not being driver by the
>>> CPU interface, each interrupt output signal can be deasserted rather
>>> than being driven by the legacy interrupt input.
>>>
>>> So the wake-event can be used as wakeup signals to SoC (system power
>>> controller).
>>>
>>> To prevent race conditions and ensure proper interrupt routing on
>>> Cortex-A15 CPUs when they are power-gated, add a CPU PM notifier
>>> call-back to reprogram the GIC CPU interface on PM entry. The
>>> GIC CPU interface will be reset back to its normal state by
>>> the common GIC CPU PM exit callback when the CPU wakes up.
>>>
>>> Based on the work by: Scott Williams <scwilliams@nvidia.com>
>>>
>>> Signed-off-by: Joseph Lo <josephl@nvidia.com>
>>
>> Hi Joseph,
>>
>> We've had a rather long-standing issue with PCIe and MSI related to LP2
>> on Tegra20. I wonder if that's somehow related to this. Given that this
>> is marked as Tegra114 patch explicitly I suppose not, but it certainly
>> sounds very similar to the description above.
>>
> For LP2 + PCIe + MSI, I believe it need some other SW support if the HW
> really support MSI and runtime power down CPU domain that include SCU
> and BIU. According to TRM, the PCIe pass data through the unit to
> memory. I have no idea does the HW really support this function. I also
> need more information about this. 

Joseph, this is NVIDIA bug 1268311. Let's continue any discussion on
this topic internally (i.e. debug the problem) in that bug, until we
have something useful to report back upstream?
