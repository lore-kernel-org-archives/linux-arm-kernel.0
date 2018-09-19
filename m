From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Wed, 19 Sep 2018 11:59:41 +0100
Subject: [PATCH] arm64: cpu_errata: Remove ARM64_MISMATCHED_CACHE_LINE_SIZE
In-Reply-To: <20180919105615.GG25094@arm.com>
References: <1537353681-19677-1-git-send-email-will.deacon@arm.com>
 <233e9a8d-b3ef-9b9c-208b-f0fd9ea4e3fe@arm.com>
 <20180919105615.GG25094@arm.com>
Message-ID: <5b097208-bb52-a7ba-fd0f-a1e1e46502a3@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/19/2018 11:56 AM, Will Deacon wrote:
> On Wed, Sep 19, 2018 at 11:53:43AM +0100, Suzuki K Poulose wrote:
>> On 09/19/2018 11:41 AM, Will Deacon wrote:
>>> There's no need to treat mismatched cache-line sizes reported by CTR_EL0
>>> differently to any other mismatched fields that we treat as "STRICT" in
>>> the cpufeature code. In both cases we need to trap and emulate EL0
>>> accesses to the register, so drop ARM64_MISMATCHED_CACHE_LINE_SIZE and
>>> rely on ARM64_MISMATCHED_CACHE_TYPE instead.
>>
>> The only reason was to avoid trapping the kernel accesses of CTR_EL0
>> for cache line sizes if there were no differences. If we are ok with
>> that, I am fine with the patch.
> 
> It's not a "trap" as such though, is it? We just load the safe val and

Oh, yes, it is not a "trap" as such.

> return that. I think that makes more sense, because if somebody uses
> read_ctr to try and read something like IDC or DIC, they probably want
> a sanitised copy on a mismatch.

Yes, true. And there is a indeed a helper for fetching the raw values on
the current PE.

FWIW,

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
