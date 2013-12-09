From: zonque@gmail.com (Daniel Mack)
Date: Mon, 09 Dec 2013 20:00:51 +0100
Subject: [PATCH v5 4/5] dma: mmp_pdma: add support for residue reporting
In-Reply-To: <20130913045135.GI17188@intel.com>
References: <1377086938-29145-1-git-send-email-zonque@gmail.com>
 <1377086938-29145-5-git-send-email-zonque@gmail.com>
 <20130825163337.GD2748@intel.com> <522F3ECB.3070307@gmail.com>
 <20130913045135.GI17188@intel.com>
Message-ID: <52A61363.7060500@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

Very sorry for such a long delay. I only get to pick up on this topic
now. Hope you can remember the context of the discussion :)

On 09/13/2013 06:51 AM, Vinod Koul wrote:
> On Tue, Sep 10, 2013 at 05:46:19PM +0200, Daniel Mack wrote:
>> Hi Vinod,
>>
>> Sorry for the late response, I've been on vacations.
>>
>> On 25.08.2013 18:33, Vinod Koul wrote:
>>> On Wed, Aug 21, 2013 at 02:08:57PM +0200, Daniel Mack wrote:
>>>> In order to report the channel's residue, we walk the list of running
>>>> descriptors, look for those which match the cookie, and then try to find
>>>> the descriptor which defines upper and lower boundaries that embrace the
>>>> current transport pointer.
>>>
>>>>
>>>> +		/*
>>>> +		 * 'passed' will be latched once we found the descriptor which
>>>> +		 * lies inside the boundaries of the curr pointer. All
>>>> +		 * descriptors that occur in the list _after_ we found that
>>>> +		 * partially handled descriptor are still to be processed and
>>>> +		 * are hence added to the residual bytes counter.
>>>> +		 */
>>> do you have multiple descriptors for one transaction? Should be No.
>>
>> Sure, that can be the case. One transaction could span across multiple
>> descriptors, especially if its overall length exceeds the maximum length
>> of one descriptor.
> Yes and these addiional descriptor for a transacation should be child
> descriptors. 
> The child descriptors should have ->parent point to parent descriptor and ->next
> to next in the chain of children.

I looked into your idea and implemented it, but I really feel having an
explicit chain pointer for each descriptor is redundant information.

Hence, let me summarize again how the driver currently works:

* Any of the prep_* function will allocate a number of descriptors to
accommodate the payload, and link them all together via the 'node'
list_head, forming a transaction.

* The last descriptor in a transaction has the DCMD_ENDIRQEN flag set.

* When tx_submit() is called, each descriptor in the linked list will be
assigned a cookie, and then entire list of the transaction is appended
to the chain_pending list. At this point, the information of where a
transaction ends is no longer visible in the 'node' list head.

* start_pending_queue() moves the chain_pending entries to chain_running.

When determining the channel's residue, we need to find the transaction
currently in progress, and then count upwards until we reach the end of
the transaction chain.

So, while I could add a ->next pointer to the descriptors, and only use
that to link up descriptors of one transaction in the prep_*()
functions, that extra information doesn't actually buy us anything, as
the same information is already stored in the DCMD_ENDIRQEN flag.


I rebased the residue patch on top of Joe's cleanup work, and I can
resubmit if you want me to. Maybe that serves as a better foundation for
the ongoing discussion :)


Many thanks,
Daniel
