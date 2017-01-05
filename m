From: robert.richter@cavium.com (Robert Richter)
Date: Thu, 5 Jan 2017 13:22:00 +0100
Subject: [PATCH 2/2] arm64: mm: enable CONFIG_HOLES_IN_ZONE for NUMA
In-Reply-To: <20170105120819.GH679@arm.com>
References: <1481706707-6211-1-git-send-email-ard.biesheuvel@linaro.org>
 <1481706707-6211-3-git-send-email-ard.biesheuvel@linaro.org>
 <20170104132831.GD18193@arm.com>
 <CAKv+Gu8MdpVDCSjfum7AMtbgR6cTP5H+67svhDSu6bkaijvvyg@mail.gmail.com>
 <20170104140223.GF18193@arm.com>
 <20170105112407.GU4930@rric.localdomain>
 <20170105120819.GH679@arm.com>
Message-ID: <20170105122200.GV4930@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05.01.17 12:08:20, Will Deacon wrote:
> On Thu, Jan 05, 2017 at 12:24:07PM +0100, Robert Richter wrote:
> > On 04.01.17 14:02:23, Will Deacon wrote:
> > > Using early_pfn_valid feels like a bodge to me, since having pfn_valid
> > > return false for something that early_pfn_valid says is valid (and is
> > > therefore initialised in the memmap) makes the NOMAP semantics even more
> > > confusing.
> > 
> > The concern I have had with HOLES_IN_ZONE is that it enables
> > pfn_valid_within() for arm64. This means that each pfn of a section is
> > checked which is done only once for the section otherwise. With up to
> > 2^18 pages per section we traverse the memblock list by that factor
> > more often. There could be a performance regression.
> 
> There could be, but we're trying to fix a bug here. I wouldn't have
> thought that walking over pfns like that is done very often.

The bug happens on a small number of machines depending on the memory
layout. The fix affects all systems. And right know the impact is
unclear.

> > I haven't numbers yet, since the fix causes another kernel crash. And,
> > this is the next problem I have. The crash doesn't happen otherwise. So,
> > either it uncovers another bug or the fix is incomplete. Though the
> > changes look like it should work. This needs more investigation.
> 
> I really can't see how the fix causes a crash, and I couldn't reproduce
> it on any of my boards, nor could any of the Linaro folk afaik. Are you
> definitely running mainline with just these two patches from Ard?

Yes, just both patches applied. Various other solutions were working.

-Robert
