From: volodymyr_babchuk@epam.com (Volodymyr Babchuk)
Date: Fri, 29 Sep 2017 13:17:03 +0300
Subject: [PATCH v1 04/14] tee: shm: add page accessor functions
In-Reply-To: <20170928221446.s4qdrzfaurzus76d@yury-thinkpad>
References: <1506621851-6929-1-git-send-email-volodymyr_babchuk@epam.com>
 <1506621851-6929-5-git-send-email-volodymyr_babchuk@epam.com>
 <20170928221446.s4qdrzfaurzus76d@yury-thinkpad>
Message-ID: <856145cd-2edb-d692-4459-9a1b0c57ce80@epam.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yury,

On 29.09.17 01:14, Yury Norov wrote:
> Hi Volodymyr,
> 
> On Thu, Sep 28, 2017 at 09:04:01PM +0300, Volodymyr Babchuk wrote:
>> From: Volodymyr Babchuk <vlad.babchuk@gmail.com>
>>
>> In order to register a shared buffer in TEE, we need accessor
>> function that return list of pages for that buffer.
>>
>> Signed-off-by: Volodymyr Babchuk <vlad.babchuk@gmail.com>
>> ---
>>   include/linux/tee_drv.h | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
>> index 6ba8b76..d773827 100644
>> --- a/include/linux/tee_drv.h
>> +++ b/include/linux/tee_drv.h
>> @@ -394,6 +394,20 @@ static inline size_t tee_shm_get_size(struct tee_shm *shm)
>>   }
>>   
>>   /**
>> + * tee_shm_get_pages() - Get list of pages that hold shared buffer
>> + * @shm:	Shared memory handle
>> + * @num_pages:	Number of pages will be stored there
>> + * @returns pointer to pages array
>> + */
>> +static inline struct page **tee_shm_get_pages(struct tee_shm *shm,
>> +					      size_t *num_pages)
>> +{
>> +	if (num_pages)
>> +		*num_pages = shm->num_pages;
> 
> My concern is about this check
> 
> The only use of the tee_shm_get_pages() I found is in patch #9:
> +               size_t page_num;
> +
> +               pages = tee_shm_get_pages(shm, &page_num);
> 
> So there's no any valid scenario where you should pass NULL to the
> function. And I don't understand why you do this check.
> 
> Even more, if in future there will be an occasion when function will
> be passed with NULL, the error will become hidden by this code.
Yes, I think you are right. I added that check in case someone want
to get only pointer to pages. But this is semantically invalid.
I'll remove that check. Thank you for review.
