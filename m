From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 20 May 2013 18:13:52 +0100
Subject: [PATCH 14/14] ARM: elf: add new hwcap for identifying atomic
 ldrd/strd instructions
In-Reply-To: <20130520160407.GS31359@mudshark.cambridge.arm.com>
References: <1368810473-26070-1-git-send-email-will.deacon@arm.com>
 <1368810473-26070-15-git-send-email-will.deacon@arm.com>
 <20130520141809.GA27473@arm.com>
 <20130520142459.GN31359@mudshark.cambridge.arm.com>
 <20130520151158.GA3520@MacBook-Pro.local>
 <20130520160407.GS31359@mudshark.cambridge.arm.com>
Message-ID: <20130520171349.GM3639@MacBook-Pro.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 20, 2013 at 05:04:07PM +0100, Will Deacon wrote:
> On Mon, May 20, 2013 at 04:11:58PM +0100, Catalin Marinas wrote:
> > On Mon, May 20, 2013 at 03:24:59PM +0100, Will Deacon wrote:
> > > On Mon, May 20, 2013 at 03:18:09PM +0100, Catalin Marinas wrote:
> > > > As I mentioned in the past, I don't agree with exposing the "LPAE"
> > > > feature to user-space, it's not a feature that user space should care
> > > > about. An atomic double hwcap is better and you can even make this per
> > > > CPU via __v7_proc.
> > > 
> > > I don't buy the argument that this could be per-CPU: doubleword atomicity
> > > requires support in the whole system -- not just in the CPU. The only way we
> > > can rely on it, is by guarantees made in the architecture, which are made
> > > as part of LPAE.
> > 
> > Well, you know that for A7/A15 you have this feature as they support
> > LPAE. You can have it as a generic LPAE test (only that the ARM ARM
> > isn't entirely clear here, so for people asking in the future we could
> > say it's a feature of the A7/A15/etc.)
> 
> No, as far as Linux is concerned, it's a feature of any system claiming to
> have support for LPAE. Given that we allocate page tables using our usual
> allocators, all memory that we map as normal must be capable of doubleword
> atomics. We make use of this in our atomic64_{read,set} implementations.

I guess we don't have non-LPAE processors that do atomic doubles (if we
would, they can use __v7_proc explicitly, though with a different name).

> > > If this just boils down to a naming issue, thn I'm happy to change it, but
> > > we *are* reporting whether LPAE is supported and I can't think of a better
> > > name than that.
> > 
> > Given that the ARM ARM isn't clear (though this is the case on the
> > actual implementations), user space may not necessarily assume that
> > LPAE==atomic doubles. That's why I think reporting the actual atomic
> > feature is better.
> 
> The ARM ARM isn't too bad: it's just avoiding mandating 64-bit-wide paths
> around the entire SoC (and I've checked this with the architects). The only
> way we can probe this feature is using the MMFR0 and checking if LPAE is
> supported, and that's exactly what userspace will need to rely on.

Well, LPAE implies atomic doubles but I wouldn't say that's the "only"
way, it can always be a feature of the CPU. Now, would the user
developers fully understand the implications of LPAE?

> We can
> change the name, but the probe code will remain the same so I'm not sure it
> makes anything clearer. We had "atomicd" originally, but that sounds like a
> techno band.

We can make it longer, 'atomicdbl', if that's the issue ;).

-- 
Catalin
