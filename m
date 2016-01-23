From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 23 Jan 2016 23:59:06 +0000
Subject: Unhandled fault: page domain fault (0x81b) at 0x00e41008
In-Reply-To: <56A3E84A.1000604@free.fr>
References: <56A268E7.7040004@free.fr>
 <20160122174814.GD19062@n2100.arm.linux.org.uk>
 <56A27C00.5060004@free.fr>
 <20160122193408.GE19062@n2100.arm.linux.org.uk>
 <56A2B811.8010306@free.fr>
 <20160122235704.GF19062@n2100.arm.linux.org.uk>
 <56A3609E.3000400@free.fr>
 <20160123113438.GG19062@n2100.arm.linux.org.uk>
 <56A3E84A.1000604@free.fr>
Message-ID: <20160123235905.GE10826@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 23, 2016 at 09:53:30PM +0100, Mason wrote:
> But I would consider mmaping /dev/mem even simpler: it doesn't
> require writing a single line of kernel code, and it works as
> expected. The gist of the code is:
> 
>   fd = open("/path/to/file", O_RDONLY);
>   mem_fd = open("/dev/mem", O_WRONLY | O_SYNC);
>   va = mmap(NULL, len, PROT_WRITE, MAP_SHARED, mem_fd, phys_addr);
>   read(fd, va, len);
> 
> And that's it. If I understand correctly, the mem driver
> will copy the file contents directly to "remote" RAM.
> 
> Is there something wrong with this solution, in your opinion?

I'll quote what you said in previous mails in this thread, so
there's no misunderstanding.  Let's call this exhibit A.  You said:

> I said:
> > Drivers and platform code should use copy_from_user()/copy_to_user()
> > to block-copy data to/from userspace, and get_user()/put_user() to
> > copy individual bytes, shorts and int/longs.  (It doesn't matter
> > who you are, that's the official guidance.)
> 
> The problem is that the kernel module's API is already set
> in stone, and it requires block copies with specific access
> sizes, e.g. block_copy8, block_copy16, block_copy32.

Okay, so in this email, we established that there was a requirement
to use specific access sizes, which turned out to be 8-bit, 16-bit
and 32-bit.  You discounted using copy_from_user()/copy_to_user().
You confirmed this in a following email, which I'll call exhibit B:

> Implement functions for copying a range of addresses
> FROM user-space, TO physical addresses,
> (and also the other way around)
> in access size of 8, 16, 32 bits.

Do you agree that you said these things?  (I'll assume you will agree,
because you're going to look _real_ stupid if you don't, because it's
all in the public archives.)

Okay, now let's consider what you've just said.  For the avoidance of
any doubt, I'll re-quote the exact bit which I'm referring to:

> But I would consider mmaping /dev/mem even simpler: it doesn't
> require writing a single line of kernel code, and it works as
> expected. The gist of the code is:
> 
>   fd = open("/path/to/file", O_RDONLY);
>   mem_fd = open("/dev/mem", O_WRONLY | O_SYNC);
>   va = mmap(NULL, len, PROT_WRITE, MAP_SHARED, mem_fd, phys_addr);
>   read(fd, va, len);

Okay, now, read() uses copy_to_user() to copy the data from kernel
space into userspace - and in this instance, that happens to be the
mapping you've set up against /dev/mem, which corresponds to the
physical addresses.  In other words, it's writing to the same
"phys_addr" as your block_copy*() functions, except it's writing
using copy_to_user().  You have stated (as we can see above) that
your solution using read() "works as expected".  That's great,
however...

In exhibit A and B, you've repeatedly stated why you are unable to
use the copy_*_user() functions for this purpose, making the claims
that specific access sizes are required.  You have just proven that
you are wrong, and that my _very_ _first_ reply in this thread was
correct.  Rather than trying it out (and finding that it _would_
have worked) you've instead argued against it, wasting my time.

I am far from impressed.

I suggest you read Aesop's Fables, specifically The Boy Who Cried
Wolf.  It seems rather appropriate here, and illustrates what can
happen if this behaviour continues.

Please, smarten up your act.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
