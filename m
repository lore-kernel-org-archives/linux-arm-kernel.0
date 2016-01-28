From: will.deacon@arm.com (Will Deacon)
Date: Thu, 28 Jan 2016 16:07:48 +0000
Subject: [PATCH] arm64: Add support for Half precision floating point
In-Reply-To: <20160126165538.GC22776@devel.intra.reserved-bit.com>
References: <1453823566-26742-1-git-send-email-suzuki.poulose@arm.com>
 <20160126160257.GB28238@arm.com> <56A79D17.2000009@arm.com>
 <20160126165538.GC22776@devel.intra.reserved-bit.com>
Message-ID: <20160128160747.GN775@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 26, 2016 at 10:25:38PM +0530, Siddhesh Poyarekar wrote:
> Adding Adhemerval to cc since he had volunteered to follow up on this,
> mainly because he had a couple of additional ideas on the kernel
> front.
> 
> On Tue, Jan 26, 2016 at 04:21:43PM +0000, Suzuki K. Poulose wrote:
> > On 26/01/16 16:02, Will Deacon wrote:
> > >Hi Suzuki,
> > >
> > >On Tue, Jan 26, 2016 at 03:52:46PM +0000, Suzuki K Poulose wrote:
> > >>ARMv8.2 extensions [1] include an optional feature, which supports
> > >>half precision(16bit) floating point/asimd data processing
> > >>instructions. This patch adds support for detecting and exposing
> > >>the same to the userspace via HWCAPs
> > 
> > 
> > >>+#define HWCAP_FPHP		(1 << 9)
> > >>+#define HWCAP_ASIMDHP		(1 << 10)
> > >
> > >Where did we get to with the mrs trapping you proposed here?
> > >
> > >   http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/374609.html
> > 
> > We are yet to get some feedback from glibc/gcc folks. Siddhesh was looking
> > to make use of it [2]. But haven't heard anything back. Ramana mentioned
> > (in private) that they had some plans to take a look at it.
> 
> I believe one of Adhemerval's ideas was similar to what I had
> mentioned back then, which was to provide all of the CPU information
> in a single file instead of having to traverse a directory structure.

My understanding was that libc needed this information extremely early
on (i.e. before it could even issue system calls), and therefore such
an approach would be in addition to the proposal here. Am I mistaken?

> The other idea was to add a vDSO function that returns this data so as
> to avoid (or at least reduce) the context switch latency.

I'm not at all keen on adding a data ABI to the vDSO. I think people tried
similar things in the past (something on PPC?) and have horror stories
from that.

> The other aspect that I am waiting for feedback from ARM for is about
> the property of the MIDR value.  If it can be ascertained that a core
> with a specific MIDR value will always only be in a homogeneous
> configuration, we could bypass the directory traversal and just stick
> to the value returned from midr_el1.  This is likely vendor-specific
> and I'm waiting to know if the ARM toolchain hackers would be
> comfortable with baking in such assumptions into glibc.  Extra marks
> for making such a requirement explicit in future specifications.

The architecture makes no guarantees about what will and won't be used
in different configurations, so we shouldn't try to derive this from the
MIDR. Even if you figure out a heuristic for today's platforms, it won't
necessarily hold true in the future.

> I had hacked at some code with directory traversal on top of your
> patch and it works fine as far as doing a PoC, but until we get
> consensus on how we want to handle things like BIG.little, there can't
> be much progress.

By "directory traversal" are you only referring to the /sys portions
of this? I'm *much* more interested in the utility of the MRS emulation
part, since that's what could effectively replace HWCAPs in the future.

As for big/little, the kernel view has been pretty consistent on that:
we will expose a "sanitised" view of the registers (as described in the
Documentation along with the patch) where we can, and for the per-CPU
registers such as MIDR, you will read the current CPU register (which
is why those registers are also exposed in sysfs).

Will
