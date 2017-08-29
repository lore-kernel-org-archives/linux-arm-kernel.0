From: david@redhat.com (David Hildenbrand)
Date: Tue, 29 Aug 2017 14:05:40 +0200
Subject: [PATCH RFC v3 1/9] KVM: s390: optimize detection of started vcpus
In-Reply-To: <20170829132342.1ef25500.cohuck@redhat.com>
References: <20170821203530.9266-1-rkrcmar@redhat.com>
 <20170821203530.9266-2-rkrcmar@redhat.com>
 <67a8b09c-3e7a-943d-8684-f9ad6e70514b@redhat.com>
 <20170829132342.1ef25500.cohuck@redhat.com>
Message-ID: <d63ceb80-bdf7-0a24-a4ac-3265b7528a60@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29.08.2017 13:23, Cornelia Huck wrote:
> On Tue, 22 Aug 2017 13:31:27 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
>> On 21.08.2017 22:35, Radim Kr?m?? wrote:
>>> We can add a variable instead of scanning all online VCPUs to know how
>>> many are started.  We can't trivially tell which VCPU is the last one,
>>> though.  
>>
>> You could keep the started vcpus in a list. Then you might drop unsigned
>> started_vcpus;
>>
>> No started vcpus: Start pointer NULL
>> Single started vcpu: Only one element in the list (easy to check)
>>> 1 started vcpus: More than one element int he list (easy to check)  
> 
> I'm not sure the added complication of keeping a list buys us much
> here: We only have the "look for the last vcpu not stopped" operation
> for the 2->1 transition.
> 

That is wrong, we also have to know the last remaining (started) VCPU.
For that, right now we have to iterate over all VCPUs.

There shouldn't be much complexity. We already perform changes under a
lock, so it is as simple as adding/removing from the list.

Detecting the transitions boils down to looking at two pointers.

-- 

Thanks,

David
