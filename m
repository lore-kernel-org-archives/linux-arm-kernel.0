From: peter.maydell@linaro.org (Peter Maydell)
Date: Fri, 5 Dec 2014 17:52:41 +0000
Subject: [RFC v2] arm:extend the reserved mrmory for initrd to be page
 aligned
In-Reply-To: <20141205172701.GW11285@n2100.arm.linux.org.uk>
References: <35FD53F367049845BC99AC72306C23D103D6DB491609@CNBJMBX05.corpusers.net>
 <20140915113325.GD12361@n2100.arm.linux.org.uk>
 <20141204120305.GC17783@e104818-lin.cambridge.arm.com>
 <20141205120506.GH1630@arm.com>
 <20141205170745.GA31222@e104818-lin.cambridge.arm.com>
 <20141205172701.GW11285@n2100.arm.linux.org.uk>
Message-ID: <CAFEAcA912Cgbs-zr+=YfBBQzK625bmbrgQwYCs4DMqPEF58e8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 December 2014 at 17:27, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Dec 05, 2014 at 05:07:45PM +0000, Catalin Marinas wrote:
>> On Fri, Dec 05, 2014 at 12:05:06PM +0000, Will Deacon wrote:
>> > Care to submit this as a proper patch? We should at least fix Peter's issue
>> > before doing things like extending headers, which won't work for older
>> > kernels anyway.
>>
>> Quick fix is the revert of the whole patch, together with removing
>> PAGE_ALIGN(end) in poison_init_mem() on arm32. If Russell is ok with
>> this patch, we can take it via the arm64 tree, otherwise I'll send you a
>> partial revert only for the arm64 part.
>
> Not really.  Let's look at the history.
>
> For years, we've been poisoning memory, page aligning the end pointer.
> This has never been an issue.

Depends what you mean by "never been an issue". I had to change
QEMU (commit 98ed805c, January 2013) for 32-bit ARM back when the
kernel started trashing the tail end of the page after the initrd
with the poisoning, to 4K-align the dtb so it didn't share a page
with the initrd-tail. That nobody else complained suggests that most
bootloaders don't in practice overlap the two, though (ie that
QEMU is an outlier in how it chooses to arrange things in memory).

I should probably have reported the breakage at the time, but
I took the pragmatic (lazy?) approach of just changing our
bootloader code.

thanks
-- PMM
