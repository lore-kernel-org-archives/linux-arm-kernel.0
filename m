From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Wed, 18 Apr 2012 21:07:27 +0100
Subject: [NEW]: Introducing shrink_all_memory from user space
In-Reply-To: <1334483226.20721.YahooMailNeo@web162003.mail.bf1.yahoo.com>
References: <1334483226.20721.YahooMailNeo@web162003.mail.bf1.yahoo.com>
Message-ID: <20120418210727.0d113647@pyramind.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> 5) After running this on my system, the performance was improved quickly.
> 
> 6) I performed the same experiment on our Samsung Smart phones as well. And I have seen a drastic improve in performance after running this for 3/4 times.
> ??? In case of phones it is more helpful as there is no swap space.
> 
> 7) Your feedback and suggestion is important. Based on the feedback, I can plan to submit the patches officially after performing basic cleanups.

So really I think this tells you two things

1. There are cases where the kernel paging subsystem is perhaps making
poor choices and should have forced out more read only pages.

2. For certain DMA allocation cases it might be a good idea to move the
interface out of the HIBERNATION config option and call it automatically
with the relevant memory allocator when requests for large linear
allocations would otherwise fail.

> This can be even using inside the multimedia drivers that requires large contiguous memory to check if that many memory pages can be reclaimed or not.

Yes - I agree. However the way that the memory is obtained and the use of
shrink_all_memory() should not be exposed as it breaks the abstraction.

If you can use it *within* the contiguous memory allocator so that the
driver does not know about shrink_all_memory, then this would be
interesting and potentially useful.

Alan
