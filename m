From: daniel@zonque.org (Daniel Mack)
Date: Wed, 16 Apr 2014 10:38:10 +0200
Subject: [PATCH RESEND] dma: mmp_pdma: add support for residue reporting
In-Reply-To: <20140416082326.GM32284@intel.com>
References: <1392636546-15541-1-git-send-email-zonque@gmail.com>
 <20140319151352.GJ1976@intel.com> <534576C3.2020409@zonque.org>
 <20140416064534.GL32284@intel.com> <534E3F3D.5080003@zonque.org>
 <20140416082326.GM32284@intel.com>
Message-ID: <534E4172.8030401@zonque.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/16/2014 10:23 AM, Vinod Koul wrote:
> On Wed, Apr 16, 2014 at 10:28:45AM +0200, Daniel Mack wrote:
>> Hi Vinod,
>>
>> On 04/16/2014 08:45 AM, Vinod Koul wrote:
>>> On Wed, Apr 09, 2014 at 06:35:15PM +0200, Daniel Mack wrote:
>>
>>>> 5. The cookie comparison in the end simply exists to address the fact
>>>>    that we might have operated on an unreleated descriptor, and we have
>>>>    to start over.
>>>>
>>>> So in short, the logic will return the bytes that are not yet processed
>>>> for a specific transaction, which is the expected thing to do, right?
>>> Looks fine then BUT I have another questions.
>>>
>>> Assuming that you have two txn submitted and driver split them to 3 descriptors
>>> each, then in that case the driver would walk over all 6 descriptors and sum up
>>> the value, which would lead to incorrect residue. It will work for single
>>> pending txn only, right?
>>
>> No, because each of the two txn would have a different cookie set, and
>> the residue function is called for one specific cookie so we know which
>> one we're looking for. That's the reason why we start over if at the end
>> of an iterated transaction chain, if we recognize that the cookie
>> doesn't match, we start over.
>>
>>> While at it and looking at the code again, I think right solution maybe to
>>> update the parent child in the descriptors. So on query you simply walk the
>>> list for all child descriptors and continue. But the parent and child are
>>> defined under CONFIG_ASYNC_TX_ENABLE_CHANNEL_SWITCH.
>>
>> That's another solution, but it's redundant information after all.
>> Ultimately, it makes the driver more complicated and introduces one more
>> area of potentially inconsistent pointers.
>>
>>> So adding Dan (his updated email id), would it be okay if we make these as
>>> generic in descriptor and use them to manage larger length transactions in
>>> drivers?
>>
>> It might add to the readability of the drivers, but for the current
>> case, I don't think it's really necessary.
> That is because you are maintaining the current descriptors in chain_running. If
> we use above method then you dont need to use this, right?

Jup, but that would result in a rewrite of larger parts of the code. The
concept of hot-linking the two list so there's only one resulting list
of currently active descriptors is built-in deeply into the driver's
concept.


Thanks,
Daniel
