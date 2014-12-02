From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 2 Dec 2014 15:59:27 +0000
Subject: [PATCHv6 6/8] arm64: use fixmap for text patching when text is RO
In-Reply-To: <20141126161802.GB1819@leverpostej>
References: <1416606645-25633-1-git-send-email-lauraa@codeaurora.org>
 <1416606645-25633-7-git-send-email-lauraa@codeaurora.org>
 <20141125170445.GB21525@leverpostej>
 <5474D056.2050101@codeaurora.org>
 <20141126161802.GB1819@leverpostej>
Message-ID: <20141202155927.GD29792@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 26, 2014 at 04:18:02PM +0000, Mark Rutland wrote:
> On Tue, Nov 25, 2014 at 06:54:14PM +0000, Laura Abbott wrote:
> > On 11/25/2014 9:04 AM, Mark Rutland wrote:
> > > Hi Laura,
> > >
> > > It looks like "early" means before we've set up the strict page
> > > permissions, though as far as I can tell the fixmap will already be
> > > available before we do any patching. Could we not always use the fixmap
> > > for patching? Then we only need the patch_{map,unmap} additions, and not
> > > the changes to distinguish the early cases.
> > >
> > >  From testing on Juno with defconfig, all of the early patches were
> > > avoidable NOP -> NOP changes as part of static key initialisation, which
> > > I think we can skip similarly to x86 (I'll send a patch shortly). All other
> > > patches were not early and went via the fixmap.
> > >
> > > Even with the avoidable NOP -> NOP patching I did not see a noticeable
> > > boot time difference from forcing the use of the fixmap.
> > >
> > 
> > I was basing it off of the arm version which needed the early option.
> > If arm64 doesn't need it I'll drop it.
> 
> Given that it only determines whether or not to use the fixmap, and we
> can always use the fixmap, I think we can drop it.

BTW, do we ever expect a write to the temporary POKE0 fixmap to fail? If
not (I don't think it would fail), we can just override the
__probe_kernel_write() to use set_fixmap() (maybe only when this feature
is enabled).

-- 
Catalin
