From: will.deacon@arm.com (Will Deacon)
Date: Tue, 1 Aug 2017 18:00:15 +0100
Subject: [PATCHv2 1/2] arm64:vdso: Rewrite gettimeofday into C.
In-Reply-To: <20170801093011.GC18024@rric.localdomain>
References: <1496190860-5116-1-git-send-email-apinski@cavium.com>
 <20170531124430.GG9723@arm.com>
 <20170801093011.GC18024@rric.localdomain>
Message-ID: <20170801170015.GD12027@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 01, 2017 at 11:30:11AM +0200, Robert Richter wrote:
> Will,
> 
> On 31.05.17 13:44:30, Will Deacon wrote:
> > Thanks for posting this, but please try to cc the maintainers in future -- I
> > almost missed it!
> > 
> > On Tue, May 30, 2017 at 05:34:19PM -0700, Andrew Pinski wrote:
> > > This allows the compiler to optimize the divide by 1000.
> > > And remove the other divide.
> > > 
> > > On ThunderX, gettimeofday improves by 32%.  On ThunderX 2,
> > > gettimeofday improves by 18%.
> > > 
> > > Note I noticed a bug in the old implementation of __kernel_clock_getres;
> > > it was checking only the lower 32bits of the pointer; this would work
> > > for most cases but could fail in a few.
> > > 
> > > Changes from v1:
> > > * Fixed bug in __kernel_clock_getres for checking the pointer argument.
> > > * Fix comments to refer to functions in arm64.
> > 
> > I tested this patch on a few platforms I have access to and didn't see the
> > perf regressions I saw when I looked at this in the past with an older
> > toolchain (it was mostly about the same, with a couple of improvements).
> > 
> > So, in principle, I'm not opposed to moving this into C. However, we're
> > currently close to a "vDSO-explosion" on arm64 with people wanting a compat
> > variant and also an ILP32 variant. When Kevin posted his compat variant
> > (also in C):
> > 
> >   http://lkml.kernel.org/r/20161206160353.14581-1-kevin.brodsky at arm.com
> 
> from a technical pov there are no issues in a convertion to C. Since
> this fixes bad syscall performance and an alternative solution as
> pointed out here is not in sight very soon, would you be willing to
> get this series upstream. Should we update to latest kernel and resend
> the patches for v4.14?

No, I'd much rather get this right straight off the bat whilst there's an
incentive to do it properly. Otherwise we just end up maintaining something
which nobody will realistically rework, despite their best intentions.
"bad syscall performance" seems like a bit of an over-reaction if you look
at the cost of the vDSO relative to an actual trap.

Will
