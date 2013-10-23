From: dave.long@linaro.org (David Long)
Date: Wed, 23 Oct 2013 14:20:47 -0400
Subject: [PATCH v2 05/13] uprobes: add arch write opcode hook
In-Reply-To: <20131019165051.GC7837@redhat.com>
References: <1381871068-27660-1-git-send-email-dave.long@linaro.org>
 <1381871068-27660-6-git-send-email-dave.long@linaro.org>
 <20131019165051.GC7837@redhat.com>
Message-ID: <5268137F.3030809@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/19/13 12:50, Oleg Nesterov wrote:
> On 10/15, David Long wrote:
>>
>> Allow arches to write the opcode with a custom function.  ARM needs to
>> customize the swbp instruction depending on the condition code of the
>> instruction it replaces.
>
> Well, we already have "__weak set_swbp(auprobe, ...)", can't arm use it?
>
> If not,
>
>> +void __weak arch_uprobe_write_opcode(struct arch_uprobe *auprobe, void *vaddr,
>> +				     uprobe_opcode_t opcode)
>> +{
>> +	memcpy(vaddr, &opcode, UPROBE_SWBP_INSN_SIZE);
>> +}
>> ...
>> -	copy_to_page(new_page, vaddr, &opcode, UPROBE_SWBP_INSN_SIZE);
>> +	vaddr_new = kmap_atomic(new_page);
>> +	arch_uprobe_write_opcode(auprobe, vaddr_new + (vaddr & ~PAGE_MASK),
>> +				 opcode);
>> +	kunmap_atomic(vaddr_new);
>
> Again, if you need to add the new __weak helper, I think it should simply
> do copy_to_page().
>
> Oleg.
>

Unfortunately, providing an alternative set_swbp() would mean 
duplicating a moderate chunk of code from kernel/uprobes.c.  Adding 
arch_uprobe_write_opcode() feels a little more like the right thing to 
do to me.  I notice there don't seem to be any alternative set_swbp 
functions in the (rc6) kernel tree.  I will adjust the 
arch_uprobe_write_opcode imlementation as suggested.

-dl
