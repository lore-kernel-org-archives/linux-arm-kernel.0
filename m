From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 1 Aug 2012 09:41:27 +0100
Subject: [PATCH 5/6] ARM: ux500: Enable HIGHMEM on all mop500 platforms
In-Reply-To: <5018E11E.7080907@linaro.org>
References: <1343741493-17671-1-git-send-email-lee.jones@linaro.org>
 <5017EBDC.6010005@linaro.org> <20120731143732.GS6802@n2100.arm.linux.org.uk>
 <201207312050.03113.arnd@arndb.de>
 <20120731220145.GD10335@n2100.arm.linux.org.uk> <5018E11E.7080907@linaro.org>
Message-ID: <20120801084127.GT6802@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 01, 2012 at 08:56:14AM +0100, Lee Jones wrote:
> On 31/07/12 23:01, Russell King - ARM Linux wrote:
>> On Tue, Jul 31, 2012 at 08:50:02PM +0000, Arnd Bergmann wrote:
>>> On Tuesday 31 July 2012, Russell King - ARM Linux wrote:
>>>> I still fail to see how not having highmem enabled would ever cause memory
>>>> corruption errors (unless something dealing with memory in a very very
>>>> wrong way - iow, not using one of the reservation or memory allocation
>>>> methods provided by the kernel.)
>>>
>>> The problem is that all users of ux500 systems pass a command line like
>>>
>>> vmalloc=256M mem=128M at 0 mali.mali_mem=32M at 128M hwmem=168M at 160M mem=48M at 328M mem_issw=1M at 383M mem=640M at 384M
>>>
>>> This is of course totally bogus and should not be done. If I understand
>>> Lee correctly, one of the issues resulting from passing a command
>>> line like this without enabling highmem is memory corruption.
>>
>> But the question is _why_ does that corruption happen.
>>
>>  From the above, we will end up with the kernel getting:
>>
>> 0x00000000 - 0x07ffffff (128M @ 0)
>> 0x14800000 - 0x177fffff (48M  @ 328M)
>> 0x18000000 - 0x3fffffff (640M @ 384M)
>>
>> with:
>>
>> 0x08000000 - 0x081fffff used for mali
>> 0x0a000000 - 0x147fffff used for hwmem
>> 0x17f00000 - 0x17ffffff used for mem_issw
>>
>> Now, with highmem disabled, the kernel should still map exactly the
>> regions: 0x00000000 - 0x07ffffff, 0x14800000 - 0x177fffff, into the
>> direct mapped region, and truncate the 0x18000000 - 0x3fffffff
>> region appropriately, reducing the amount of memory available such
>> that it won't overlap the vmalloc area (which you've specified to be
>> a minimum of 256M.)
>>
>> This should _NOT_ cause any memory corruption.
>>
>> So, come on guys.  Debugging is *mandatory* for this kind of problem.
>> Papering over it is obscene.
>
> Actually I didn't go any further with it, as I changed to another  
> identical piece of hardware and couldn't reproduce the issue.
>
> FYI, here's the boot log from the broken board:
>
> http://paste.ubuntu.com/1102017/

Well, the good thing is this:

   8 Truncating RAM at 18000000-3fffffff to -2c3fffff (vmalloc region overlap).

which means the RAM was properly truncated before it is passed to
memblock, etc.

That oops dump looks very much like an ASoC problem, where
dapm_widget_power_check() recurses into dapm_supply_check_power()
which then recurses back into dapm_widget_power_check(), and it
eventually overflows the kernel stack, corrupting the thread_info
and the pages below.

Given the address of the stack pointer (ebc480a8) I don't think
we can be too sure where it was supposed to be, and where the top
of stack should have been, so we don't know how many pages have
been stomped on and corrupted.

Stopping that recursion is the first thing that needs to be done
so that the cause of it can then be properly debugged without the
kernel itself corrupting memory below the kernel stack.
