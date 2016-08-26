From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 26 Aug 2016 15:22:29 +0200
Subject: [PATCH] arm: sys_oabi-compat: Use kmalloc_array() in two functions
In-Reply-To: <20160825224632.GL1041@n2100.armlinux.org.uk>
References: <5deba521-2dd4-cd2e-23d7-226a1a7728c3@users.sourceforge.net>
 <20160825224632.GL1041@n2100.armlinux.org.uk>
Message-ID: <dd343c72-2ec7-2114-bee5-1d16fc6c04ac@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> Multiplications for the size determination of memory allocations
>> indicated that array data structures should be processed.
> 
> I'm afraid the above comment doesn't mean much to me, can you rephrase?

Yes, of course.

How verbose should the explanation for this update suggestion become?


> Maybe:
> 
> "Multiplications for kmalloc size arguments are liable to overflow,
> potentially causing a potential security issue.  Using kmalloc_array()
> allows the overflow to be caught and the allocation failed.  Switch
> these callsites to kmalloc_array()."

Thanks for your wording variant.


>> @@ -285,7 +285,7 @@ asmlinkage long sys_oabi_epoll_wait(int epfd,
>>  		return -EINVAL;
>>  	if (!access_ok(VERIFY_WRITE, events, sizeof(*events) * maxevents))
>>  		return -EFAULT;
>> -	kbuf = kmalloc(sizeof(*kbuf) * maxevents, GFP_KERNEL);
>> +	kbuf = kmalloc_array(maxevents, sizeof(*kbuf), GFP_KERNEL);
> 
> kmalloc_array() here actually buys us no additional safety at either
> of the callsites in your patch

Can this inline function apply a few sanity checks in a consistent way?
http://lxr.free-electrons.com/source/include/linux/slab.h#L564


> - we need to have carefully checked the values to ensure
> they don't overflow prior to the kmalloc for other reasons.

Are there any more constraints to consider?


> That's probably something that should be noted in the commit message too,
> so reviewers have the confidence that you're not blindly changing everything...

I imagine that a few contributors can get mixed feelings from a bunch
of my recent patches. There is a significant patch number in the works
for various Linux software modules.

Regards,
Markus
