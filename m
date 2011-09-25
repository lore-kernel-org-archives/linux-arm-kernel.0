From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sun, 25 Sep 2011 16:26:42 +0100
Subject: I-cache/D-cache inconsistency issue with page cache
In-Reply-To: <20110925103445.GA22455@n2100.arm.linux.org.uk>
References: <20110923115721.GA7013@glandium.org>
	<20110923193941.GQ17169@n2100.arm.linux.org.uk>
	<20110924093544.GA5724@glandium.org>
	<20110924094734.GC17169@n2100.arm.linux.org.uk>
	<CAHkRjk42PoRJrRb3vBdQCCno_LoMSdBrHSQ9xkiFcyB16PYkaw@mail.gmail.com>
	<20110925103445.GA22455@n2100.arm.linux.org.uk>
Message-ID: <CAHkRjk7u3RQxUSkU+DP0fD4qd2VzYB0eQA_NpVFebNtBcR6ysQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 September 2011 11:34, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sun, Sep 25, 2011 at 10:51:30AM +0100, Catalin Marinas wrote:
>> I had a discussion on Friday with the Firefox guys here in ARM. We
>> need to do some investigation next week but some random unverified
>> thoughts (that's on A9) - the scenario seems to be that a library
>> decompresses some data to a file using mmap(write) (which happens to
>> be code but it doesn't need to know that) while some other application
>> part tries, at a later time, to execute code in the same file using
>> mmap(exec).
>>
>> By default, a new page cache page is dirty. At a first look,
>> mmap(write) and further access would not trigger a cache operation in
>> __sync_icache_dcache() and the page is still marked as dirty. Later
>> on, when the page is munmap'ed and mmap'ed(exec),
>> __sync_icache_dcache() (during fault processing) would flush the
>> D-cache and invalidate the I-cache, while marking the page 'clean'.
>>
>> I wonder whether during the first mmap(write) and uncompressing, the
>> 'clean' state could be set (maybe some flush_dcache_page) call. This
>> state would be preserved in the page cache page status and a
>> subsequent __sync_icache_dcache(), even from a different file, would
>> just notice that the page is 'clean'.
>>
>> As I said, just some thoughts, I haven't tested this theory yet.
>
> Not quite. ?Whenever we establish any page in the system which is
> executable, we always flush the D cache and entire I cache.

We flush the D-cache only if the page was not marked 'clean'. Is there
any chance that the page gets marked as clean before the first part of
the application wrote the data (uncompressing) via a mmap(write)
mapping? If this would happen, a subsequent mmap(exec) of the same
page (as the kernel would most likely find it in the page cache) would
find it 'clean' and avoid the D-cache flushing.

> As I've already pointed out though, the report is against old kernels
> which doesn't have this code, so there's no point us speculating about
> it until the issue has been confirmed against a kernel which we expect
> _not_ to have the issue in the first place (rather than one which we
> _do_ expect it to go wrong.)

Yes, they should definitely try a more recent kernel.

-- 
Catalin
