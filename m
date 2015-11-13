From: qiuxishi@huawei.com (Xishi Qiu)
Date: Fri, 13 Nov 2015 16:32:13 +0800
Subject: [PATCHv2 2/2] arm64: Allow changing of attributes outside of
 modules
In-Reply-To: <56459EED.4030109@huawei.com>
References: <1447207057-11323-1-git-send-email-labbott@fedoraproject.org>
 <1447207057-11323-3-git-send-email-labbott@fedoraproject.org>
 <56459EED.4030109@huawei.com>
Message-ID: <5645A00D.6020005@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


>> +static int update_pmd_range(struct mm_struct *mm, pud_t *pud,
>> +				unsigned long addr, unsigned long end,
>> +				pgprot_t clear, pgprot_t set)
>> +{
>> +	pmd_t *pmd;
>> +	unsigned long next;
>> +	int err = 0;
>> +
>> +	if (pud_sect(*pud)) {
>> +		if (!IS_ENABLED(CONFIG_DEBUG_CHANGE_PAGEATTR)) {
>> +			err = -EINVAL;
>> +			goto out;
>> +		}
>> +		pmd = pmd_alloc_one(&init_mm, addr);
>> +		if (!pmd) {
>> +			err = -ENOMEM;
>> +			goto out;
>> +		}
>> +		split_pud(pud, pmd);
>> +		pud_populate(&init_mm, pud, pmd);
>> +	}
>> +
>>  
>> -	pte = clear_pte_bit(pte, cdata->clear_mask);
>> -	pte = set_pte_bit(pte, cdata->set_mask);
>> +	pmd = pmd_offset(pud, addr);
>> +	if (pmd_none(*pmd)) {
>> +		err = -EFAULT;
>> +		goto out;
>> +	}
>> +
>> +	do {
>> +		next = pmd_addr_end(addr, end);
>> +		if (((addr | end) & ~SECTION_MASK) == 0) {
> 
> Hi Laura,
> 
> Why not like this?
> 		if (pmd_sect(*pmd) && ((addr | nest) & ~SECTION_MASK) == 0) {

Sorry, typo error, nest -> next
