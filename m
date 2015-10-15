From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Thu, 15 Oct 2015 14:23:51 +0100
Subject: [PATCH v3 13/24] arm64: Populate cpuinfo after notify_cpu_starting
In-Reply-To: <20151015105438.GL4239@e104818-lin.cambridge.arm.com>
References: <1444756952-31145-1-git-send-email-suzuki.poulose@arm.com>
 <1444756952-31145-14-git-send-email-suzuki.poulose@arm.com>
 <20151015105438.GL4239@e104818-lin.cambridge.arm.com>
Message-ID: <561FA8E7.5020504@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/10/15 11:54, Catalin Marinas wrote:
> On Tue, Oct 13, 2015 at 06:22:21PM +0100, Suzuki K. Poulose wrote:
>> This patch delays populating the cpuinfo for a new (hotplugged)
>> CPU until the notifiers have executed. This will enable us to verify
>> if the new (hotplugged) CPU has all the capabilities which the system
>> already has. If it doesn't, we could prevent it from turning online and
>> also modifying the system wide feature register status.
>
> Just a question here: do we expect the notifiers to enable certain
> features that we check later? AFAICT, the checking is done on the
> feature registers which don't change after notifiers,

No. The notifiers are registered only after we compute the cpu
capabilities (at which point all the boot time activated CPUs are
turned on and has updated their cpuinfo). The features won't change
after this point throughout the lifetime of the system. So we don't want to
run the capability check for the 'CPUs' during the normal boot up. It
is only for the hotplug case. We compute the capability based on the
booted CPUs from smp_cpus_done() and then apply the alternatives based
on what we have in common. So the system can function properly with
mismatched features from the CPUs. But if a new CPU is brought online
with at least one missing established capability, we should fail the bring up.

  so we could as
> well block the booting before any notifier is run.
>

Thanks
Suzuki
