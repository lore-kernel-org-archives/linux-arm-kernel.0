From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 13 Mar 2015 14:11:08 +0000
Subject: some question about Set bit 22 in the PL310 (cache controller)
 AuxCtlr register
In-Reply-To: <CAOVJa8Gi4JRT=VDXG_nec30PCJoWUiA-9dE56NrGeE48Lww+Hw@mail.gmail.com>
References: <CAOVJa8Euj-VC-r0uQdyxqRtU7v23t3UW=wWTbrTCz_6gSp4x6g@mail.gmail.com>
 <20150310163133.GC13687@e104818-lin.cambridge.arm.com>
 <CAOVJa8EneaXA5bX2_f4JBjKyG2G2subWPd3Vf9d_S-QxG9iO5g@mail.gmail.com>
 <CAOVJa8Gi4JRT=VDXG_nec30PCJoWUiA-9dE56NrGeE48Lww+Hw@mail.gmail.com>
Message-ID: <20150313141106.GA17279@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 12, 2015 at 05:54:59AM +0800, vichy wrote:
> 2015-03-11 22:35 GMT+08:00 vichy <vichy.kuo@gmail.com>:
> > 2015-03-11 0:31 GMT+08:00 Catalin Marinas <catalin.marinas@arm.com>:
> >> Bit 22 in PL310 AuxCtlr must be set for most (all) uses of the coherent
> >> DMA API in Linux.
> 
> Not only the above 2 links I pasted in the mail, I also found other
> threads has the issue as mine.
> (about L2C_AUX_CTRL_SHARED_OVERRIDE)
> And all of them(so far I see) suggest to set this bit on.
> if so, under what circumstance, the Bit22 in PL310 AuxCtlr will be cleared?

IIRC, the PL310 designers thought of this as a harmless optimisation.
Basically on a system where a device (graphics usually) access could go
through the PL310 (but not able to snoop the CPU caches), they thought
that there wouldn't be any problem if the device can see the content of
PL310 but not allocate into the cache. They actually wanted to avoid
read-allocation that you get with a Normal Cacheable access from the
device since such graphics device would easily fill the PL310. That's
basically an emulation of a Cacheable no-read no-write allocate access.

However, this broke many assumptions that Linux was making (mismatched
aliases, later clarified in the ARM ARM). The feature wasn't easy to use
either since to be beneficial, the buffer writer (CPU in this case)
would have to allocate cache lines in PL310. For this, the device driver
allocating the framebuffer would need to either create an inner
non-cacheable, outer cacheable mapping (not supported by the DMA API) or
flush the L1 cache only (not part of the standard DMA API either).

My position over the past 4 years has clearly been that all firmware or
SoC code must set this bit before PL310 is enabled. There is no
performance drop nor other side effects caused by setting it.
Unfortunately, Russell never accepted the patch to handle this at the
cache-l2x0.c level (or print a warning if the firmware hasn't set it).
Four years later, Linux still creates mismatched memory attributes
aliases (which are not a bad thing, the ARM ARM clarifies the behaviour
for ARMv7 and we know they've been fine on prior implementations; the
arm64 port is not going to do anything special to avoid such aliases).

-- 
Catalin
