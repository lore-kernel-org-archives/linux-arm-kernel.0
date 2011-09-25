From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sun, 25 Sep 2011 10:51:30 +0100
Subject: I-cache/D-cache inconsistency issue with page cache
In-Reply-To: <20110924094734.GC17169@n2100.arm.linux.org.uk>
References: <20110923115721.GA7013@glandium.org>
	<20110923193941.GQ17169@n2100.arm.linux.org.uk>
	<20110924093544.GA5724@glandium.org>
	<20110924094734.GC17169@n2100.arm.linux.org.uk>
Message-ID: <CAHkRjk42PoRJrRb3vBdQCCno_LoMSdBrHSQ9xkiFcyB16PYkaw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 September 2011 10:47, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sat, Sep 24, 2011 at 11:35:44AM +0200, Mike Hommey wrote:
>> On Fri, Sep 23, 2011 at 08:39:41PM +0100, Russell King - ARM Linux wrote:
>> > On Fri, Sep 23, 2011 at 01:57:21PM +0200, Mike Hommey wrote:
>> > > We've been hitting random crashes at startup with Firefox on tegras
>> > > (under Android), and narrowed it down to a I-cache/D-cache
>> > > inconsistency. A reduced testcase of the issue looks like the following
>> > > (compile as ARM, not Thumb):
>> >
>> > If you write code at run time, you need to use the sys_cacheflush
>> > API to ensure that it's properly synchronized with the I-cache. ?It's
>> > a well known issue, and it applies to any harvard cache structured
>> > CPU which doesn't automatically ensure coherence (which essentially
>> > means all ARMs.)
>>
>> I do agree it's reasonable to have applications doing that to handle
>> cache synchronization themselves. I wrote such in my message. But I
>> think the kernel should make sure that its page cache is fresh when
>> it maps it PROT_EXEC. I think it's unreasonable to expect applications
>> doing mmap(PROT_WRITE), inflate, munmap, something, mmap(PROT_EXEC),
>> and execute something there to have to handle cache synchronisation
>> themselves. Especially when it's very CPU dependent (the testcase does
>> not even fail on all ARMs, only tegras, apparently). I'm not talking
>> actual code generation here, which needs platform-dependent behaviour.
>
> Ok. ?Which kernel are you trying this with, and which CPU (please
> confirm Cortex-A9)?

I had a discussion on Friday with the Firefox guys here in ARM. We
need to do some investigation next week but some random unverified
thoughts (that's on A9) - the scenario seems to be that a library
decompresses some data to a file using mmap(write) (which happens to
be code but it doesn't need to know that) while some other application
part tries, at a later time, to execute code in the same file using
mmap(exec).

By default, a new page cache page is dirty. At a first look,
mmap(write) and further access would not trigger a cache operation in
__sync_icache_dcache() and the page is still marked as dirty. Later
on, when the page is munmap'ed and mmap'ed(exec),
__sync_icache_dcache() (during fault processing) would flush the
D-cache and invalidate the I-cache, while marking the page 'clean'.

I wonder whether during the first mmap(write) and uncompressing, the
'clean' state could be set (maybe some flush_dcache_page) call. This
state would be preserved in the page cache page status and a
subsequent __sync_icache_dcache(), even from a different file, would
just notice that the page is 'clean'.

As I said, just some thoughts, I haven't tested this theory yet.

-- 
Catalin
