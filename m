From: panand@redhat.com (Pratyush Anand)
Date: Mon, 12 Jan 2015 10:34:58 +0530
Subject: [RFC 8/8] ARM64: Add uprobe support
In-Reply-To: <20150109175936.GB13161@redhat.com>
References: <cover.1420038188.git.panand@redhat.com>
 <0694af6935f9c6873ef8d25ad51630a40a74a116.1420038188.git.panand@redhat.com>
 <20150109175936.GB13161@redhat.com>
Message-ID: <54B355FA.60702@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Friday 09 January 2015 11:29 PM, Oleg Nesterov wrote:
> On 12/31, Pratyush Anand wrote:
>>
>> +int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe, struct mm_struct *mm,
>> +		unsigned long addr)
>> +{
>> +	probe_opcode_t insn;
>> +
>> +	insn = *(probe_opcode_t *)(&auprobe->insn[0]);
>> +
>> +	switch (arm_probe_decode_insn(insn, &auprobe->ainsn)) {
>> +	case INSN_REJECTED:
>> +		return -EINVAL;
>> +
>> +	case INSN_GOOD_NO_SLOT:
>> +		auprobe->simulate = true;
>> +		if (auprobe->ainsn.prepare)
>> +			auprobe->ainsn.prepare(insn, &auprobe->ainsn);
>> +		break;
>> +
>> +	case INSN_GOOD:
>> +	default:
>> +		break;
>> +	}
>> +
>> +	return 0;
>> +}
>
> forgot to mention... shouldn't it also check IS_ALIGNED(addr, AARCH64_INSN_SIZE) ?
>
> I do not know if unaligned insn address is valid on arm64 or not, but please

AARCH64 instructions are always of fixed lenght ie 4 bytes. I do not see 
possibility of addr being unaligned. Please let me know, if I am missing 
something.

> note that at least it should not cross the page boundary, set_swbp() needs to
> write AARCH64_INSN_SIZE == UPROBE_SWBP_INSN bytes and it assumes that this
> should fit the single page.

So, again I do not see the possibility of crossing of page boundary for 
any instruction address.

~Pratyush
