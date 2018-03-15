From: okaya@codeaurora.org (Sinan Kaya)
Date: Thu, 15 Mar 2018 12:27:46 -0400
Subject: [PATCH 7/7] ixgbevf: eliminate duplicate barriers on
 weakly-ordered archs
In-Reply-To: <eee8269d-b711-828c-ab84-5933bf86d024@codeaurora.org>
References: <1520997629-17361-1-git-send-email-okaya@codeaurora.org>
 <1520997629-17361-7-git-send-email-okaya@codeaurora.org>
 <12150aa0-77ba-878e-31f4-d4f8d6a28ccb@codeaurora.org>
 <2a4f4dec64b7462ae64152f6c2df9754@codeaurora.org>
 <CAKgT0UcriMiyV0q6y_x9r3-HJRAWp5_CpsK2jTqh3qvOV=Kkzw@mail.gmail.com>
 <d565406d-1bc7-6fb0-3f36-87a28ac69070@codeaurora.org>
 <CAKgT0UeBHGDmr0uXfuPQJKOomiH9uvXRVYpyDwMOzjkxAZMSYg@mail.gmail.com>
 <53bf7dfe-32ee-1861-e6ea-81f667590a43@codeaurora.org>
 <CAKgT0UcBQRoSPPZ73bdu1oEBGqBA8_c3ZAjti20=+9UwEqpXbw@mail.gmail.com>
 <eee8269d-b711-828c-ab84-5933bf86d024@codeaurora.org>
Message-ID: <0175e460-3424-9838-1064-9f63dab3304f@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/15/2018 12:21 PM, Sinan Kaya wrote:
> On 3/15/2018 10:32 AM, Alexander Duyck wrote:
>> We tend to do something like:
>>   update tx_buffer_info
>>   update tx_desc
>>   wmb()
>>   point first tx_buffer_info next_to_watch value at last tx_desc
>>   update next_to_use
>>   notify device via writel
>>
>> We do it this way because we have to synchronize between the Tx
>> cleanup path and the hardware so we basically lump the two barriers
>> together. instead of invoking both a smp_wmb and a wmb. Now that I
>> look at the pseudocode though I wonder if we shouldn't move the
>> next_to_use update before the wmb, but that might be material for
>> another patch. Anyway, in the Tx cleanup path we should have an
>> smp_rmb() after we read the next_to_watch values so that we avoid
>> reading any of the other fields in the buffer_info if either the field
>> is NULL or the descriptor pointed to has not been written back.
> 
> How do you feel about keeping wmb() very close to writel_relaxed() like this?
> 
>    update tx_buffer_info
>    update tx_desc
>    point first tx_buffer_info next_to_watch value at last tx_desc
>    update next_to_use
>    wmb()
>    notify device via writel_relaxed()
> 
> I'm afraid that if the order of wmb() and writel() is not very
> obvious or hidden in multiple functions, somebody can introduce a very nasty
> bug in the future.
> 
> We also have to think about code maintenance.
> 

Now that I read your email again, I think this is the reason if I understood you
correctly. 

"instead of invoking both a smp_wmb and a wmb"

You'd need something like

    update tx_buffer_info
    update tx_desc
    smp_wmb()
    point first tx_buffer_info next_to_watch value at last tx_desc
    update next_to_use
    wmb()
    notify device via writel_relaxed()

Let me work on your comments.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
