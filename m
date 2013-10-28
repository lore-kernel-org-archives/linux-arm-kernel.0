From: oleg@redhat.com (Oleg Nesterov)
Date: Mon, 28 Oct 2013 20:49:14 +0100
Subject: [PATCH v2 05/13] uprobes: add arch write opcode hook
In-Reply-To: <5268137F.3030809@linaro.org>
References: <1381871068-27660-1-git-send-email-dave.long@linaro.org>
 <1381871068-27660-6-git-send-email-dave.long@linaro.org>
 <20131019165051.GC7837@redhat.com> <5268137F.3030809@linaro.org>
Message-ID: <20131028194914.GA15103@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/23, David Long wrote:
>
> On 10/19/13 12:50, Oleg Nesterov wrote:
>> On 10/15, David Long wrote:
>>>
>>> Allow arches to write the opcode with a custom function.  ARM needs to
>>> customize the swbp instruction depending on the condition code of the
>>> instruction it replaces.
>>
>> Well, we already have "__weak set_swbp(auprobe, ...)", can't arm use it?
>>
>> If not,
>>
>>> +void __weak arch_uprobe_write_opcode(struct arch_uprobe *auprobe, void *vaddr,
>>> +				     uprobe_opcode_t opcode)
>>> +{
>>> +	memcpy(vaddr, &opcode, UPROBE_SWBP_INSN_SIZE);
>>> +}
>>> ...
>>> -	copy_to_page(new_page, vaddr, &opcode, UPROBE_SWBP_INSN_SIZE);
>>> +	vaddr_new = kmap_atomic(new_page);
>>> +	arch_uprobe_write_opcode(auprobe, vaddr_new + (vaddr & ~PAGE_MASK),
>>> +				 opcode);
>>> +	kunmap_atomic(vaddr_new);
>>
>> Again, if you need to add the new __weak helper, I think it should simply
>> do copy_to_page().
>>
>> Oleg.
>>
>
> Unfortunately, providing an alternative set_swbp() would mean
> duplicating a moderate chunk of code from kernel/uprobes.c.

Yes, yes, sorry for confusion. What I actually tried to suggest is
something like the trivial patch below.

Then arm can do:

	uprobe_opcode_t arch_uprobe_swbp_insn(struct arch_uprobe *auprobe)
	{
		return __opcode_to_mem_arm(auprobe->bpinsn);
	}

No?

> I notice there don't seem to be any alternative set_swbp functions
> in the (rc6) kernel tree

Yes... I think we should simply make it "static". And set_orig_insn()
too.

Oleg.

--- x/kernel/events/uprobes.c
+++ x/kernel/events/uprobes.c
@@ -304,6 +304,11 @@ put_old:
 	return ret;
 }
 
+uprobe_opcode_t __weak arch_uprobe_swbp_insn(struct arch_uprobe *auprobe)
+{
+	return UPROBE_SWBP_INSN;
+}
+
 /**
  * set_swbp - store breakpoint at a given address.
  * @auprobe: arch specific probepoint information.
@@ -315,7 +320,7 @@ put_old:
  */
 int __weak set_swbp(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr)
 {
-	return write_opcode(mm, vaddr, UPROBE_SWBP_INSN);
+	return write_opcode(mm, vaddr, arch_uprobe_swbp_insn(auprobe));
 }
 
 /**
