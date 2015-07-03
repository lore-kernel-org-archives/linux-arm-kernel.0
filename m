From: andre.przywara@arm.com (Andre Przywara)
Date: Fri, 3 Jul 2015 16:57:04 +0100
Subject: [PATCH 11/13] KVM: arm64: implement ITS command queue command
 handlers
In-Reply-To: <20150628194148.GM28244@cbox>
References: <1432893209-27313-1-git-send-email-andre.przywara@arm.com>
 <1432893209-27313-12-git-send-email-andre.przywara@arm.com>
 <20150628194148.GM28244@cbox>
Message-ID: <5596B0D0.3080505@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoffer,

....

>> +
>> +static struct its_collection *vits_new_collection(struct kvm *kvm, u32 coll_id)
>> +{
>> +	struct its_collection *collection;
>> +
>> +	collection = kmalloc(sizeof(struct its_collection), GFP_KERNEL);
> 
> If I manage to understand the structure here, you're calling all these
> handler functions with a spinlock held so any operation that may sleep
> could cause your system to deadlock.
> 
> I'll stop looking for these and recommend you go over the whole series
> for these.

Do you reckon it would be sufficient to just avoid the kmallocs inside
the lock? For this case above we could go with some storage space
preallocated outside of the lock (I hope).

> 
> Perhaps the right thing to do is to synchronize access to your data
> structure (why you hold the spinlock right?) with RCU if you can...

Well, the point is that there is not one ITS data structure, but it's a
mesh of lists connected to each other. I'd like to avoid going down with
RCU there, so I'd like to keep it all under one lock.
I wonder if this could be mutex_lock_interruptible, though. From the top
of your head, is there anything that would prevent that? I reckon ITS
access contention is rather rare (though possible), so a sleeping VCPU
wouldn't harm us so much in practice, would it?

Cheers,
Andre.
