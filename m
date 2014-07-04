From: a.ryabinin@samsung.com (Andrey Ryabinin)
Date: Fri, 04 Jul 2014 17:38:31 +0400
Subject: [PATCH] arm: get rid of hardcoded assumptions about kernel stack
 size
In-Reply-To: <4429781.iuSvvPCxYj@wuerfel>
References: <1403099422-850-1-git-send-email-a.ryabinin@samsung.com>
 <201407032224.28386.arnd@arndb.de> <53B6541B.6000702@samsung.com>
 <4429781.iuSvvPCxYj@wuerfel>
Message-ID: <53B6AE57.70307@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/04/14 14:27, Arnd Bergmann wrote:
> On Friday 04 July 2014 11:13:31 Andrey Ryabinin wrote:
>>>
>>> but I wonder if there is a way to avoid the extra include here, as it might also
>>> cause a general slowdown because of asm/memory.h getting pulled into more .c
>>> files. Would it be reasonable to hardcode PAGE_SIZE here?
>>>
>>
>> IMO it's a bug of iop13xx platform, that it includes "higlevel" linux/reboot.h
>> from a very "lowlevel" header mach/iop13xx.h. I think it should be fixed with a patch above.
>> Slowing down of kernel build for a few more seconds is not good enough reason for me to
>> hardcode PAGE_SIZE here.
> 
> I don't think we can pinpoint a specific header that is "wrong" here, the

That's just my opinion. Anyway, if this header needed only for declaring single enum
it worth to replace include with enum declaration.

> fundamental problem is that our header files are a bit messy when it comes
> to recursive inclusion and we'd be better off if we generally were a little
> more careful about including headers from other headers.
> 

That's why we need to remove reboot.h from iop13xx.h.
Are you going to send a proper formatted patch for that?

Speaking of asm/page.h, a lot of other architectures
also have it included in thread_info.h, so I would leave it there.


> It's also very hard to retroactively clean this up on a large scale.
> 
> 	Arnd
> 
