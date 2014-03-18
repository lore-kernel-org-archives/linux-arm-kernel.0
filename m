From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 18 Mar 2014 16:21:05 -0600
Subject: [PATCH v2 11/15] arm64: add EFI stub
In-Reply-To: <CAFECyb_NuHBQD3zPouDde3WTyz8RrUu1OWFOt6VWX_U5n1g8MA@mail.gmail.com>
References: <1394750828-16351-1-git-send-email-leif.lindholm@linaro.org>
 <1394750828-16351-12-git-send-email-leif.lindholm@linaro.org>
 <20140318120919.GG13200@arm.com>
 <1395153629.2967.10.camel@deneb.redhat.com>
 <20140318182826.GC20497@arm.com>
 <1395178831.2967.29.camel@deneb.redhat.com>
 <CAFECyb_NuHBQD3zPouDde3WTyz8RrUu1OWFOt6VWX_U5n1g8MA@mail.gmail.com>
Message-ID: <20140318222105.GA11178@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 18, 2014 at 02:48:30PM -0700, Roy Franz wrote:

> > It isn't clear to me if UEFI does cache flushing at ExitBootServices
> > time, but even so, at least stack use will get cached between then and
> > the kernel entry point. The stub could conceivably get its hands on the
> > EFI memmap and invalidate dcache using address ranges from UEFI memory
> > descriptors so maybe that is the way we should do it.

> I looked at the UEFI spec and there is no mention of cache flushing
> in ExitBootServices(), so it seems it is up to the OS to do any
> cache management.

Something to think about: On mvebu we recently confirmed a situation
where turning off the L1 cache is not sufficient for booting. The L2
cache must also be completely off and disabled prior to jumping in to
the kernel.

The issue is the decompressor turns the L1 cache back on, and if the
L2 is also enabled at this point then it gets filled with
decompression data. Things go wrong from here because after
decompression the L1 dcache is switched off, but the L2 isn't
flush-invalidated.

So now the L2 holds writeback data and uncached reads return garbage,
and/or the L2 misses the uncached writes (eg relocation fixup) and
becomes inconsistent with memory. Either case gives a black screen
crash at boot.

Fundementally if the L2 doesn't monitor uncached read/writes then it
will cause a big problem.

Thus, if the UEFI calls the sub with the caches on, and the stub
doesn't know enough to turn off the L2 then you might not be able to
turn the dcache off at all. :(

On ARM64 at least the L1 cache ops are standardized so maybe ARM64
could keep the mmu+caches enabled during boot and do the L1
d-flush/i-inval required for instruction coherency?

Jason
