From: jeremy.linton@arm.com (Jeremy Linton)
Date: Thu, 2 Aug 2018 22:15:10 -0500
Subject: [RFC 0/2] harden alloc_pages against bogus nid
In-Reply-To: <20180801171414.30e54a106733ccaaa566388d@linux-foundation.org>
References: <20180801200418.1325826-1-jeremy.linton@arm.com>
 <20180801145020.8c76a490c1bf9bef5f87078a@linux-foundation.org>
 <d9f8e9d1-2fb8-6016-5081-7e3213b23ed4@arm.com>
 <20180801171414.30e54a106733ccaaa566388d@linux-foundation.org>
Message-ID: <a38071b1-6068-c5ca-d408-736bdb8e7073@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 08/01/2018 07:14 PM, Andrew Morton wrote:
> On Wed, 1 Aug 2018 17:56:46 -0500 Jeremy Linton <jeremy.linton@arm.com> wrote:
> 
>> Hi,
>>
>> On 08/01/2018 04:50 PM, Andrew Morton wrote:
>>> On Wed,  1 Aug 2018 15:04:16 -0500 Jeremy Linton <jeremy.linton@arm.com> wrote:
>>>
>>>> The thread "avoid alloc memory on offline node"
>>>>
>>>> https://lkml.org/lkml/2018/6/7/251
>>>>
>>>> Asked at one point why the kzalloc_node was crashing rather than
>>>> returning memory from a valid node. The thread ended up fixing
>>>> the immediate causes of the crash but left open the case of bad
>>>> proximity values being in DSDT tables without corrisponding
>>>> SRAT/SLIT entries as is happening on another machine.
>>>>
>>>> Its also easy to fix that, but we should also harden the allocator
>>>> sufficiently that it doesn't crash when passed an invalid node id.
>>>> There are a couple possible ways to do this, and i've attached two
>>>> separate patches which individually fix that problem.
>>>>
>>>> The first detects the offline node before calling
>>>> the new_slab code path when it becomes apparent that the allocation isn't
>>>> going to succeed. The second actually hardens node_zonelist() and
>>>> prepare_alloc_pages() in the face of NODE_DATA(nid) returning a NULL
>>>> zonelist. This latter case happens if the node has never been initialized
>>>> or is possibly out of range. There are other places (NODE_DATA &
>>>> online_node) which should be checking if the node id's are > MAX_NUMNODES.
>>>>
>>>
>>> What is it that leads to a caller requesting memory from an invalid
>>> node?  A race against offlining?  If so then that's a lack of
>>> appropriate locking, isn't it?
>>
>> There were a couple unrelated cases, both having to do with the PXN
>> associated with a PCI port. The first case AFAIK, the domain wasn't
>> really invalid if the entire SRAT was parsed and nodes created even when
>> there weren't associated CPUs. The second case (a different machine) is
>> simply a PXN value that is completely invalid (no associated
>> SLIT/SRAT/etc entries) due to firmware making a mistake when a socket
>> isn't populated.
>>
>> There have been a few other suggested or merged patches for the
>> individual problems above, this set is just an attempt at avoiding a
>> full crash if/when another similar problem happens.
> 
> Please add the above info to the changelog.

Sure.

> 
>>
>>>
>>> I don't see a problem with emitting a warning and then selecting a
>>> different node so we can keep running.  But we do want that warning, so
>>> we can understand the root cause and fix it?
>>
>> Yes, we do want to know when an invalid id is passed, i will add the
>> VM_WARN in the first one.
>>
>> The second one I wasn't sure about as failing prepare_alloc_pages()
>> generates a couple of error messages, but the system then continues
>> operation.
>>
>> I guess my question though is which method (or both/something else?) is
>> the preferred way to harden this up?
> 
> The first patch looked neater.  Can we get a WARN_ON in there as well?
> 

Yes,

Thanks,
