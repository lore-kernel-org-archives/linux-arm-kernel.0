From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Fri, 29 Nov 2013 07:39:27 +0900
Subject: [PATCH v5 2/7] arm64: introduce interfaces to hotpatch kernel
 and module code
In-Reply-To: <527671E9.8040704@gmail.com>
References: <1382109602-27432-1-git-send-email-liuj97@gmail.com>
 <1382109602-27432-3-git-send-email-liuj97@gmail.com>
 <20131030001245.GB25346@mudshark.cambridge.arm.com>
 <527671E9.8040704@gmail.com>
Message-ID: <5297C61F.8000801@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/04/2013 12:55 AM, Jiang Liu wrote:
> On 10/30/2013 08:12 AM, Will Deacon wrote:
>> Hi Jinag Liu,
>>
>>> +static __always_inline u32 aarch64_insn_read(void *addr)
>>> +{
>>> +	return le32_to_cpu(*(u32 *)addr);
>>> +}
>>>
>>> +static __always_inline void aarch64_insn_write(void *addr, u32 insn)
>>> +{
>>> +	*(u32 *)addr = cpu_to_le32(insn);
>>> +}
>>
>> I wouldn't bother with these helpers. You should probably be using
>> probe_kernel_address or similar, then doing the endianness swabbing on the
>> return value in-line.
> How about keeping and refining aarch64_insn_read/write interfaces
> by using probe_kernel_address()? I think they may be used in other
> places when supporting big endian ARM64 kernel.

I prefer it (using probe_kernel_read/write) for my ftrace patch.
I would be able to replace some portion of my own function (ftrace_modify_code)
to aarch64_insn_patch_text_nosync().

See my comment here:
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-October/207001.html
([PATCH 2/6])

Current implementation assumes stop_machine (via arch_ftrace_update_code()
in generic ftrace), and, given the discussion btw you and Will, I wonder
that it might be relaxed because ftrace on arm64 modifies only a single branch
or nop instruction at any time.

-Takahiro AKASHI
