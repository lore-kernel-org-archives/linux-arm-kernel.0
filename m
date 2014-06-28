From: dalias@libc.org (Rich Felker)
Date: Fri, 27 Jun 2014 20:38:56 -0400
Subject: [musl] Re: Thread pointer changes
In-Reply-To: <20140627232056.GZ32514@n2100.arm.linux.org.uk>
References: <20140610072835.GA8466@brightrain.aerifal.cx>
 <20140611145533.GT179@brightrain.aerifal.cx>
 <53ADC5B1.6080905@amacapital.net>
 <20140627232056.GZ32514@n2100.arm.linux.org.uk>
Message-ID: <20140628003856.GC19165@brightrain.aerifal.cx>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 28, 2014 at 12:20:57AM +0100, Russell King - ARM Linux wrote:
> I've shown that this isn't as big a problem as first thought, because
> there's ways that a libc can trivially detect the CPU that it is running
> on, and from that know what instructions are available to it.

I'd really rather be able to detect "Is kuser helper page available?"
than "Are the instructions to get by without it available?" The big
reason is that, when you want a binary that works "anywhere" on an ISA
like ARM where the vendor keeps deprecating instructions and replacing
them with new ones, it's safer to rely on the kernel to tell you which
instructions work than having hard-coded ones that might start failing
somewhere down the line. The other reason is that the pre-v6 kuser
compare-and-swap is actually faster on non-SMP machines since it
doesn't have to do any locking or barrier.

I do actually have a solution for this: using process_vm_readv, the
existence of the kuser helper page can be probed to determine if it's
safe to access, and the kuser version number can be read. But this is
somewhat hackish and might have other downsides.

> I've indicated that the kuser helpers are always provided when there
> is no hardware TLS support, which corresponds with a minimum ARM
> architecture of version 6K, and v6k has the atomic instructions.

Thanks. I wasn't aware that !(hwcap & HWCAP_TLS) was a sufficient
condition to ensure that the kuser helper page is available. In theory
SYS_get_thread_area or trap-emulated TLS access could have been
required in this case but I'm glad to hear that they're not.

> I've said that we're not going to move kuser helpers to a randomised
> address, and given strong reasons why not.

Understood.

> I've indicated where the CPU architecture can be retrieved from, and
> used to determine the availability of other instructions.

This is another area where I feel there is some deficiency: deducing
from a cpu string the availability or non-availability of features
sounds fragile. I think it can be done efficiently via AT_PLATFORM,
and like you said SYS_uname is probably safe/reliable too, but I'd
much rather have something in the form of explicit capabilities rather
than having to infer them from a cpu model string.

> I've indicated that the ELF HWCAPs can be used to further refine the
> available instruction information.

With the exception of knowing whether to use DMB for barriers.

Rich
