From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Fri, 18 Dec 2015 22:09:59 +0000
Subject: [PATCH v4] arm64: run-time detection for aarch32 support
In-Reply-To: <20151218174607.GE30229@leverpostej>
References: <1450454429-22976-1-git-send-email-ynorov@caviumnetworks.com>
 <56743C4F.7060201@arm.com> <20151218174607.GE30229@leverpostej>
Message-ID: <56748437.2040905@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/12/15 17:46, Mark Rutland wrote:
> On Fri, Dec 18, 2015 at 05:03:11PM +0000, Suzuki K. Poulose wrote:
>> On 18/12/15 16:00, Yury Norov wrote:
>>> Kernel option COMPAT defines the ability of executing aarch32 binaries.
>> As per ARM ARM, AArch32 only ID register values are unknown if AArch32 is
>> not implemented. So I think we need to skip accessing the AArch32 ID registers
>> everywhere (feature tracking), if the CPU doesn't supports it, to avoid
>> unnecessary SANITY failures and TAINTing the kernel.
>
> That all sounds good to me.
>
> After boot-time we should also fail hotplug of a CPU that doesn't
> support AArch32, if we decided at boot-time that AArch32 was supported
> accross the system. That should probably be added to your early cpu
> feature verification [1].

You are right. I think we could add this as system capability to arm64_feautres
which would make the check automatic. Also, the compat_elf_arch() check won't
have to always to read_system_reg(), something like ARM64_HAS_32BIT_EL0.

Thanks
Suzuki
