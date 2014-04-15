From: davem@davemloft.net (David Miller)
Date: Tue, 15 Apr 2014 14:30:54 -0400 (EDT)
Subject: [RFC PATCH] uprobes: copy to user-space xol page with proper
 cache flushing
In-Reply-To: <20140415180311.GA11690@redhat.com>
References: <20140415174330.GA10558@redhat.com>
 <20140415.134627.1895466146177627985.davem@davemloft.net>
 <20140415180311.GA11690@redhat.com>
Message-ID: <20140415.143054.770827409393483803.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Oleg Nesterov <oleg@redhat.com>
Date: Tue, 15 Apr 2014 20:03:11 +0200

> On 04/15, David Miller wrote:
>>
>> From: Oleg Nesterov <oleg@redhat.com>
>> Date: Tue, 15 Apr 2014 19:43:30 +0200
>>
>> > Finally, let me repeat, you should verify that this
>> > __copy_to_user_page(page, uaddr, kaddr) will not something bad if uaddr
>> > is not mmapped, or its mapping do not match area->page.
>>
>> Just directly access userspace with the usual exception mechanism we
>> use for copy_to_user(), put_user(), et al. and if it faults you'll get
>> -EFAULT and handle it.
>>
>> This also avoids the D-cache aliasing issues entirely as I explained
>> in my other reply.
> 
> Yes, yes, this is obvious.
> 
> But I have no idea what else we should do to take care of icache.

Russell, if for example userland stores into the instruction stream
to patch an instruction, what needs to be done on ARM?
