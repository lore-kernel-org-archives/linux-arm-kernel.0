From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 5 Jan 2016 18:58:18 +0000
Subject: [PATCHv2 00/18] arm64: mm: rework page table creation
In-Reply-To: <568C0D40.4040204@redhat.com>
References: <1451930211-22460-1-git-send-email-mark.rutland@arm.com>
 <568B17AA.1050002@redhat.com> <20160105115414.GC24664@leverpostej>
 <568C0D40.4040204@redhat.com>
Message-ID: <20160105185818.GA31781@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >>This series points out that my attempt to allow set_memory_* to
> >>work on regular kernel memory[1] is broken right now because it breaks down
> >>the larger block sizes.
> >
> >What's the rationale for set_memory_* on kernel mappings? I see
> >"security", but I couldn't figure out a concrete use-case. Is there any
> >example of a subsystem that wants to use this?
> 
> From the description, it sounded like this was possibly new work but
> the eBPF interpreter currently supports setting a page read only via
> set_memory_ro (see 60a3b2253c413cf601783b070507d7dd6620c954
> "net: bpf: make eBPF interpreter images read-only") so it's not
> unheard of.

Oh. For some reason I thought that used the vmalloc area, but evidently
I was mistaken.

That is unfortunate, it would be good to protect the JITed code.

> >For statically-allocated data, an alternative approach would be for such
> >memory to be mapped with minimal permissions from the outset (e.g. being
> >placed in .rodata), and when elevated permissions are required a
> >(temporary) memremap'd alias could be used, like what patch_map does to
> >modify ROX kernel/module text.
> >
> >For dynamically-allocated data, we could create (minimal permission)
> >mappings in the vmalloc region and pass those around. The linear map
> >alias would still be writeable, but as the offset between the two isn't
> >linear (and the owner of that allocation doesn't have to know/care about
> >the linear map address), it would be much harder to find the linear map
> >address to attack. An alias with elevated permissions could be used as
> >required, or if it's a one-time RW->RO switch, the mapping could me
> >modified in-place as the granularity wouldn't change.
> 
> This would work for new features but probably not for existing features
> such as the eBPF interpreter.

Sure.

For eBPF it might be possible to rework the code to support using
separate aliases, but that's probably not going to be easy and that
probably works against some performance requirement. :/

Thanks,
Mark.
