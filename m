From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 2 Feb 2012 15:10:47 +0000
Subject: OMAP3 L2/outer cache enabled in kernel (after being disabled by
 uBoot)?
In-Reply-To: <20120202144942.GD1275@n2100.arm.linux.org.uk>
References: <WC20120120085711.330803@terrafix.co.uk>
 <20120127173029.GA3281@arm.com> <4F277A6E.9070107@ti.com>
 <CAHkRjk7z2QYbU09BRfAWmChw5xj9taCarWfnttWveyqtadiEOg@mail.gmail.com>
 <CAMQu2gxr5ZkH4AE_7QNptxx7onQMGaj+qhUF+DSw9MnkCqCRog@mail.gmail.com>
 <CAHkRjk7Fh=OUk8K=bJa8xzPqMvT6P6gjT+kqAA0DeVfrF0sUNg@mail.gmail.com>
 <CAMQu2gwDJ=aezNAUD3YmGHQ6fBxkxgUonYkQYPH8WBeNvZCKMQ@mail.gmail.com>
 <CAHkRjk6KQXR1kt8VTPC3GOaHUusKikxXHR=Mge8akaVL2ipvaw@mail.gmail.com>
 <alpine.LFD.2.02.1201311253460.2759@xanadu.home>
 <CAHkRjk690R951NUDC_erNsBtbmtrM-nPjY2gR=Tf-sW4qXX7ww@mail.gmail.com>
 <20120202144942.GD1275@n2100.arm.linux.org.uk>
Message-ID: <CAHkRjk4526ubsEJn94gk__07wXx5YjSejcRzLSf5_VALEtvrqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2 February 2012 14:49, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Feb 02, 2012 at 02:32:03PM +0000, Catalin Marinas wrote:
>> We could do the same and move the bit enabling to separate repository :).
>
> We must certainly could do but that doesn't get around the errata
> issues when you have things before the kernel (or before these blobs)
> enabling things like the caches and MMU.

That was my original point - allow such code to be built into a blob
that the boot loader can execute. But I got your point that not all
boot loaders are able to execute two binary images.

> The only answer which assures complete system stability is for the
> earliest reasonable point in the booting sequence to handle the errata,
> before any of the potential errata scenarios occur. ?For things like
> working around L2 cache problems, that means before the L2 cache is
> enabled for the first time.
>
> If the boot loader enables the L2 cache, then _it_ has to take care of
> the errata before it enables the L2 cache, and not some blob that it
> loads.
>
> If the boot loader enables the cache, and there are workarounds for buggy
> cache behaviour, then the boot loader has to implement those errata
> itself.

But as it was pointed out already, many of those are very rare
conditions that you can't actually trigger during the boot sequence.
There are other errata that require SMP for example and the boot
loader (or decompressor) doesn't care.

> So, I propose that we rip out all those work-arounds that are just
> 'set this bit in some register' at boot time from the kernel itself
> right now, and reconsider how these are handled.

Just don't remove them until we agree where we should *move* them.
They are still good documentation so far. I would say just disable the
workarounds in the kernel .config until we decide.

> But, having errata for things like DMB being faulty in the kernel after
> things like the boot loader will _already_ have had to issue DMB
> instructions, or for failing I-cache invalidate after we've already done
> some I-cache invalidates (eg, boot loader or the decompressor) is quite
> absurd.

As I said, most errata are really hard to trigger (but ARM cannot
guarantee that it is impossible, so they need to be published).

-- 
Catalin
