From: nfortino@nvidia.com (Nickolas Fortino)
Date: Wed, 17 Jul 2013 13:09:52 -0700
Subject: preempted dup_mm misses TLB invalidate
In-Reply-To: <51E6F60D.6060804@wwwdotorg.org>
References: <51E43D2B.9090709@nvidia.com>
 <20130717192746.GE16496@MacBook-Pro.local> <51E6F60D.6060804@wwwdotorg.org>
Message-ID: <51E6FA10.5070504@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/17/2013 12:52 PM, Stephen Warren wrote:
> On 07/17/2013 01:27 PM, Catalin Marinas wrote:
>> On Mon, Jul 15, 2013 at 07:19:23PM +0100, Nickolas Fortino wrote:
>>> The page tables have a page marked as user read only, but the TLB has
>>> the page marked as user read/write.
>>
>> This happens during fork() for the current process. I think mprotect()
>> as well. The caller is supposed not to have threads that write its
>> memory while another thread does a fork().

To be clear, the complaint is not that the page tables are ephemerally 
out of sync with the TLBs. I agree that is part of the expected 
operation of fork(), and if a TLB invalidate occurs prior to any memory 
access the code is valid.

The problem is eventually a user process performs a store which hits on 
a writeable TLB entry with the PTE marked as read only. Is it supposed 
to be possible for a user threading bug to end up in this state? I would 
have expected the kernel to be responsible for assuring no stores occur 
to a page it has marked as read only.

As for whether the application is threaded, it almost certainly is - 
it's cfbench equivalent to 
https://play.google.com/store/apps/details?id=eu.chainfire.cfbench&hl=en
