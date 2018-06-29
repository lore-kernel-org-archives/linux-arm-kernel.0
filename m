From: ravi.bangoria@linux.ibm.com (Ravi Bangoria)
Date: Fri, 29 Jun 2018 08:53:28 +0530
Subject: [PATCH v5 06/10] Uprobes: Support SDT markers having reference
 count (semaphore)
In-Reply-To: <20180628195106.GA3952@redhat.com>
References: <20180628052209.13056-1-ravi.bangoria@linux.ibm.com>
 <20180628052209.13056-7-ravi.bangoria@linux.ibm.com>
 <20180628195106.GA3952@redhat.com>
Message-ID: <cd95a4cc-4301-0dca-5fdd-53cc016dcfe1@linux.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Oleg,

On 06/29/2018 01:21 AM, Oleg Nesterov wrote:
> I have to admit that after a quick glance I can't understand this patch
> at all... I'll try to read it again tomorrow, but could you at least explain
> how find_node_in_range/build_probe_list can work if off_type==REF_CTR_OFFSET?
> 
> On 06/28, Ravi Bangoria wrote:
>>
>> -find_node_in_range(struct inode *inode, loff_t min, loff_t max)
>> +find_node_in_range(struct inode *inode, int off_type, loff_t min, loff_t max)
>>  {
>>  	struct rb_node *n = uprobes_tree.rb_node;
>>  
>>  	while (n) {
>>  		struct uprobe *u = rb_entry(n, struct uprobe, rb_node);
>> +		loff_t offset = uprobe_get_offset(u, off_type);
>>  
>>  		if (inode < u->inode) {
>>  			n = n->rb_left;
>>  		} else if (inode > u->inode) {
>>  			n = n->rb_right;
>>  		} else {
>> -			if (max < u->offset)
>> +			if (max < offset)
>>  				n = n->rb_left;
>> -			else if (min > u->offset)
>> +			else if (min > offset)
>>  				n = n->rb_right;
>>  			else
>>  				break;
> 
> To simplify, lets forget about uprobe->inode (which acts as a key too). So uprobes_tree
> is a binary tree sorted by uprobe->offset key and that is why the binary search works.
> 
> But it is not sorted by uprobe->ref_ctr_offset. So for example n->rb_left can have the
> n->ref_ctr_offset key that is greater than the n's ref_ctr_offset. So how we can use the
> binary search if REF_CTR_OFFSET?
> 
> I must have missed something, I assume you tested this patch and it works somehow...
> 

Right, I've misinterpreted that code. Will check it.

Thanks for explaining,
Ravi
