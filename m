From: will.deacon@arm.com (Will Deacon)
Date: Mon, 3 Apr 2017 12:37:51 +0100
Subject: Bad page state splats on arm64, v4.11-rc{3,4}
In-Reply-To: <20170403105629.GB18905@leverpostej>
References: <20170331175845.GE6488@leverpostej>
 <20170403105629.GB18905@leverpostej>
Message-ID: <20170403113751.GD5706@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 03, 2017 at 11:56:29AM +0100, Mark Rutland wrote:
> On Fri, Mar 31, 2017 at 06:58:45PM +0100, Mark Rutland wrote:
> > Hi,
> > 
> > I'm seeing intermittent bad page state splats on arm64 with 4.11-rc3 and
> > v4.11-rc4. I have not tested earlier kernels, or other architectures.
> > 
> > So far, it looks like the flags are always bad in the same
> > way:
> > 
> > 	bad because of flags: 0x80(waiters)
> > 
> > ... though I don't know if that's definitely the case for splat 4, the
> > BUG at mm/page_alloc.c:800.
> > 
> > I see this in QEMU VMs launched by Syzkaller, triggering once every few
> > hours. So far, I have not been able to reproduce the issue in any other
> > way (including using syz-repro).
> 
> It looks like this may be an issue with the arm64 HUGETLB code.
> 
> I wasn't able to trigger the issue over the weekend on a kernel with
> HUGETLBFS disabled. There are known issues with our handling of
> contiguous entries, and this might be an artefact of that.

After chatting with Punit, it looks like this might be because the GUP
code doesn't handle huge ptes (which we create using the contiguous hint),
so follow_page_pte ends up with one of those and goes wrong. In particular,
the migration code will certainly do the wrong thing.

I'll probably revert the contiguous support (again) if testing indicates
that it makes this issue disappear.

Will
