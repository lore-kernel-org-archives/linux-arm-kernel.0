From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Mon, 23 Nov 2015 23:48:12 +0000
Subject: [PATCH 5/5] arm64: Ensure the secondary CPUs have safe ASIDBits
 size
In-Reply-To: <20151123172920.GB1702@arm.com>
References: <1447866238-22970-1-git-send-email-suzuki.poulose@arm.com>
 <1447866540-23207-1-git-send-email-suzuki.poulose@arm.com>
 <1447866540-23207-5-git-send-email-suzuki.poulose@arm.com>
 <20151123172920.GB1702@arm.com>
Message-ID: <5653A5BC.4020209@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/11/15 17:29, Will Deacon wrote:
> On Wed, Nov 18, 2015 at 05:09:00PM +0000, Suzuki K. Poulose wrote:
>> The ID_AA64MMFR0_EL1:ASIDBits determines the size of the mm context
>> id and is used in the early boot to make decisions. The value is
>> picked up from the Boot CPU and cannot be delayed until other CPUs
>> are up. If a secondary CPU has a smaller size than that of the Boot
>> CPU, things will break horribly and the usual SANITY check is not good
>> enough to prevent the system from crashing. Prevent this by failing CPUs with
>> ASID smaller than that of the boot CPU.

...

>> +	pr_crit("CPU%d: will not boot\n", cpu);
>
> This is less informative than the current message (whcih describes the
> missing capability).

The missing capability is printed by the caller (Patch 4/5) and see below
for the new user.


	ID_AA64MMFR0_ASID_SHIFT);
>> +	if (asid_cur < asid_boot) {
>> +		pr_crit("CPU%d: has incompatible ASIDBits: %u vs Boot CPU:%u\n",
>> +				cpu, asid_cur, asid_boot);
>> +		fail_incapable_cpu();
>> +	}
>
> Hmm. Whilst we want to ensure that secondary CPUs don't have a smaller
> ASID size than the boot CPU, can we actually guarantee that a smaller
> value for ID_AA64MMFR0.ASIDBits corresponds to fewer bits? We're
> probably better off assuming 8-bit ASIDs unless ASIDBits == 2 (which is
> what the ASID allocator does).

Right, I already have a reworked version, which does the same and moves it
back to verify_local_cpu_capabilities(). I will send it tomorrow.

Cheers
Suzuki
