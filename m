From: volodymyr_babchuk@epam.com (Volodymyr Babchuk)
Date: Fri, 29 Sep 2017 13:34:13 +0300
Subject: [PATCH v1 06/14] tee: optee: add page list manipulation functions
In-Reply-To: <20170929002300.zxu4n47m5jdymdyt@yury-thinkpad>
References: <1506621851-6929-1-git-send-email-volodymyr_babchuk@epam.com>
 <1506621851-6929-7-git-send-email-volodymyr_babchuk@epam.com>
 <20170929002300.zxu4n47m5jdymdyt@yury-thinkpad>
Message-ID: <e7896e03-a12a-69b9-4b98-7737576f718b@epam.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 29.09.17 03:23, Yury Norov wrote:
> On Thu, Sep 28, 2017 at 09:04:03PM +0300, Volodymyr Babchuk wrote:
>> From: Volodymyr Babchuk <vlad.babchuk@gmail.com>
>>
>> These functions will be used to pass information about shared
>> buffers to OP-TEE.
>>
>> Signed-off-by: Volodymyr Babchuk <vlad.babchuk@gmail.com>
>> ---
>>   drivers/tee/optee/call.c          | 48 +++++++++++++++++++++++++++++++++++++++
>>   drivers/tee/optee/optee_private.h |  4 ++++
>>   2 files changed, 52 insertions(+)
>>
>> diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
>> index f7b7b40..f8e044d 100644
>> --- a/drivers/tee/optee/call.c
>> +++ b/drivers/tee/optee/call.c
>> @@ -11,6 +11,7 @@
>>    * GNU General Public License for more details.
>>    *
>>    */
>> +#include <asm/pgtable.h>
>>   #include <linux/arm-smccc.h>
>>   #include <linux/device.h>
>>   #include <linux/err.h>
>> @@ -442,3 +443,50 @@ void optee_disable_shm_cache(struct optee *optee)
>>   	}
>>   	optee_cq_wait_final(&optee->call_queue, &w);
>>   }
>> +
>> +/**
>> + * optee_fill_pages_list() - write list of user pages to given shared
>> + * buffer.
>> + *
>> + * @dst: page-aligned buffer where list of pages will be stored
> 
> I'm not much familiar with the subsystem you work on, but I don't
> understand why the type of dst is u64*. If it's just a buffer, it
> should be void *. Also, if we assuming running it on arm were pointers
> are 32-bit, the result of page_to_phys() will be u32, and you will
> waste half of your u64 array for storing zeroes; this line:
> 		*dst = page_to_phys(pages[i]);
Yep. There is defined ABI between OP-TEE OS and OP-TEE clients. That ABI 
demands that page addresses should be stored in 64-bit fields even on 
32-bit architectures.


>> + * @pages: array of pages that represents shared buffer
>> + * @num_pages: number of entries in @pages
>> + *
>> + * @dst should be big enough to hold list of user page addresses and
>> + *	links to the next pages of buffer
>> + */
>> +void optee_fill_pages_list(u64 *dst, struct page **pages, size_t num_pages)
>> +{
>> +	size_t i;
>> +
>> +	/* TODO: add support for RichOS page sizes that != 4096 */
>> +	BUILD_BUG_ON(PAGE_SIZE != OPTEE_MSG_NONCONTIG_PAGE_SIZE);
> 
> RichOS stands for Linux? Why I am still not a rich OS developer? :)
I'm asking the same question :) Yes, in terms of TEE, Linux is RichOS
and OP-TEE is TrustedOS.

> This is the first occurrence of the term in kernel sources, please
> explain it.
I'd rather change "RichOS" to "Linux".

> Also, I think that it would be more logical to add the dependency on
> page size to Kconfig, not here, and move the comment there, so user
> will be simply unable to build the whole module.
I event didn't thought of this. Thank you for suggestion. Will do in 
this way.

>> +	for (i = 0; i < num_pages; i++, dst++) {
>> +		/* Check if we are going to roll over the page boundary */
>> +		if (IS_ALIGNED((uintptr_t)(dst + 1),
>> +			       OPTEE_MSG_NONCONTIG_PAGE_SIZE)) {
>> +			*dst = virt_to_phys(dst + 1);
>> +			dst++;
>> +		}
> 
> Is my understanding correct that @dst is not a simple array of buffer
> page addresses?  Instead, it has a complex structure: First 511 records
> store buffer page entries, and last one points to the next page of dst.
> Is it somehow documented? Also, did you consider to create a header structure
> for the buffer page, like memory allocators do? You can place there number
> of entries, pointer to the next page, maybe some flags. I think it will be
> more transparent, especially if we consider communication protocol between
> independent software products.
This is documented in the previous patch "tee: optee: Update protocol 
definitions" (5/14).
I like your idea about header structure. Just to clarify: it should be 
structure that covers whole page. Like that described in the previous patch:

+ * struct page_data {
+ *   uint64_t 
pages_array[OPTEE_MSG_NONCONTIG_PAGE_SIZE/sizeof(uint64_t) - 1];
+ *   uint64_t next_page_data;
+ * };

Right?
