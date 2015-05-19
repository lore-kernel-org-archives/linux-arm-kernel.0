From: julien.grall@citrix.com (Julien Grall)
Date: Tue, 19 May 2015 15:12:11 +0100
Subject: [Xen-devel] [RFC 02/23] xen/xenbus: client: Fix call of
 virt_to_mfn in xenbus_grant_ring
In-Reply-To: <555B3FF6.4050902@citrix.com>
References: <1431622863-28575-1-git-send-email-julien.grall@citrix.com>
 <1431622863-28575-3-git-send-email-julien.grall@citrix.com>
 <555B3FF6.4050902@citrix.com>
Message-ID: <555B44BB.1090200@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

On 19/05/15 14:51, David Vrabel wrote:
>> --- a/drivers/xen/xenbus/xenbus_client.c
>> +++ b/drivers/xen/xenbus/xenbus_client.c
>> @@ -379,16 +379,16 @@ int xenbus_grant_ring(struct xenbus_device *dev, void *vaddr,
>>  	int i, j;
>>  
>>  	for (i = 0; i < nr_pages; i++) {
>> -		unsigned long addr = (unsigned long)vaddr +
>> -			(PAGE_SIZE * i);
>>  		err = gnttab_grant_foreign_access(dev->otherend_id,
>> -						  virt_to_mfn(addr), 0);
>> +						  virt_to_mfn(vaddr), 0);
>>  		if (err < 0) {
>>  			xenbus_dev_fatal(dev, err,
>>  					 "granting access to ring page");
>>  			goto fail;
>>  		}
>>  		grefs[i] = err;
>> +
>> +		vaddr = (char *)vaddr + PAGE_SIZE;
> 
> You don't need the cast here since vaddr is a void *.

Arithmetic on void pointer is a GCC extension [1]. I wasn't sure what is
the Linux policy on it.

Regards,

[1] https://gcc.gnu.org/onlinedocs/gcc/Pointer-Arith.html#Pointer-Arith


-- 
Julien Grall
