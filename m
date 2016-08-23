From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Tue, 23 Aug 2016 11:07:25 +0100
Subject: [PATCH 6/8] arm64: Introduce raw_{d,i}cache_line_size
In-Reply-To: <20160822100007.GB14680@arm.com>
References: <1471525832-21209-1-git-send-email-suzuki.poulose@arm.com>
 <1471525832-21209-7-git-send-email-suzuki.poulose@arm.com>
 <20160822100007.GB14680@arm.com>
Message-ID: <cc6a8f1d-1d17-c001-f6a1-05b620933c5e@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/08/16 11:00, Will Deacon wrote:
> On Thu, Aug 18, 2016 at 02:10:30PM +0100, Suzuki K Poulose wrote:
>> On systems with mismatched i/d cache min line sizes, we need to use
>> the smallest size possible across all CPUs. This will be done by fetching
>> the system wide safe value from CPU feature infrastructure.
>> However the some special users(e.g kexec, hibernate) would need the line
>> size on the CPU (rather than the system wide), when the system wide
>> feature may not be accessible. Provide another helper which will fetch
>> cache line size on the current CPU.
>
> Why are these users "special"? Using a smaller line size shouldn't affect

With the alternate patched code, we refer to the kernel data structure for
CTR value. At least for kexec, it may overwrite the existing kernel image/data where
our data was stored and could possibly end up in receiving corrupted code.

For all special cases where it is ensured that the code is run on a
single CPU and will not be migrated to another CPU they can rely on
the raw value of CTR, hence the change.

> correctness, and I don't see kexec and hibernate as being performance
> critical in their cache maintenance.

Its not for performance, but for the safety.

Suzuki
