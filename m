From: will.deacon@arm.com (Will Deacon)
Date: Mon, 20 May 2013 15:24:59 +0100
Subject: [PATCH 14/14] ARM: elf: add new hwcap for identifying atomic
 ldrd/strd instructions
In-Reply-To: <20130520141809.GA27473@arm.com>
References: <1368810473-26070-1-git-send-email-will.deacon@arm.com>
 <1368810473-26070-15-git-send-email-will.deacon@arm.com>
 <20130520141809.GA27473@arm.com>
Message-ID: <20130520142459.GN31359@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 20, 2013 at 03:18:09PM +0100, Catalin Marinas wrote:
> On Fri, May 17, 2013 at 06:07:53PM +0100, Will Deacon wrote:
> > CPUs implementing LPAE have atomic ldrd/strd instructions, meaning that
> > userspace software can avoid having to use the exclusive variants of
> > these instructions if they wish.
> > 
> > This patch advertises the atomicity of these instructions via the
> > hwcaps, so userspace can detect this CPU feature.
> > 
> > Reported-by: Vladimir Danushevsky <vladimir.danushevsky@oracle.com>
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> ...
> > +
> > +	/* LPAE implies atomic ldrd/strd instructions */
> > +	vmsa = (read_cpuid_ext(CPUID_EXT_MMFR0) & 0xf) >> 0;
> > +	if (vmsa >= 5)
> > +		elf_hwcap |= HWCAP_LPAE;
> 
> As I mentioned in the past, I don't agree with exposing the "LPAE"
> feature to user-space, it's not a feature that user space should care
> about. An atomic double hwcap is better and you can even make this per
> CPU via __v7_proc.

I don't buy the argument that this could be per-CPU: doubleword atomicity
requires support in the whole system -- not just in the CPU. The only way we
can rely on it, is by guarantees made in the architecture, which are made
as part of LPAE.

If this just boils down to a naming issue, thn I'm happy to change it, but
we *are* reporting whether LPAE is supported and I can't think of a better
name than that.

Will
