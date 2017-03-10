From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 10 Mar 2017 11:46:42 +0000
Subject: [RFC PATCH 00/12] Ion cleanup in preparation for moving out of
 staging
In-Reply-To: <20170310103112.GA15945@e106950-lin.cambridge.arm.com>
References: <1488491084-17252-1-git-send-email-labbott@redhat.com>
 <20170303132949.GC31582@dhcp22.suse.cz>
 <cf383b9b-3cbc-0092-a071-f120874c053c@redhat.com>
 <20170306074258.GA27953@dhcp22.suse.cz>
 <20170306104041.zghsicrnadoap7lp@phenom.ffwll.local>
 <20170306105805.jsq44kfxhsvazkm6@sirena.org.uk>
 <20170306160437.sf7bksorlnw7u372@phenom.ffwll.local>
 <CA+M3ks77Am3Fx-ZNmgeM5tCqdM7SzV7rby4Es-p2F2aOhUco9g@mail.gmail.com>
 <26bc57ae-d88f-4ea0-d666-2c1a02bf866f@redhat.com>
 <20170310103112.GA15945@e106950-lin.cambridge.arm.com>
Message-ID: <2e295c28-04d6-a071-cf16-164d02d679c5@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/03/17 10:31, Brian Starkey wrote:
> Hi,
> 
> On Thu, Mar 09, 2017 at 09:38:49AM -0800, Laura Abbott wrote:
>> On 03/09/2017 02:00 AM, Benjamin Gaignard wrote:
> 
> [snip]
> 
>>>
>>> For me those patches are going in the right direction.
>>>
>>> I still have few questions:
>>> - since alignment management has been remove from ion-core, should it
>>> be also removed from ioctl structure ?
>>
>> Yes, I think I'm going to go with the suggestion to fixup the ABI
>> so we don't need the compat layer and as part of that I'm also
>> dropping the align argument.
>>
> 
> Is the only motivation for removing the alignment parameter that
> no-one got around to using it for something useful yet?
> The original comment was true - different devices do have different
> alignment requirements.
> 
> Better alignment can help SMMUs use larger blocks when mapping,
> reducing TLB pressure and the chance of a page table walk causing
> display underruns.

For that use-case, though, alignment alone doesn't necessarily help -
you need the whole allocation granularity to match your block size (i.e.
given a 1MB block size, asking for 17KB and getting back 17KB starting
at a 1MB boundary doesn't help much - that whole 1MB needs to be
allocated and everyone needs to know it to ensure that the whole lot can
be mapped safely). Now, whether it's down to the callers or the heap
implementations to decide and enforce that granularity is another
question, but provided allocations are at least naturally aligned to
whatever the granularity is (which is a reasonable assumption to bake
in) then it's all good.

Robin.

> 
> -Brian
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
