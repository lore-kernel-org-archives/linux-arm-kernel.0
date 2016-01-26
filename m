From: sid@reserved-bit.com (Siddhesh Poyarekar)
Date: Tue, 26 Jan 2016 22:25:38 +0530
Subject: [PATCH] arm64: Add support for Half precision floating point
In-Reply-To: <56A79D17.2000009@arm.com>
References: <1453823566-26742-1-git-send-email-suzuki.poulose@arm.com>
 <20160126160257.GB28238@arm.com> <56A79D17.2000009@arm.com>
Message-ID: <20160126165538.GC22776@devel.intra.reserved-bit.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding Adhemerval to cc since he had volunteered to follow up on this,
mainly because he had a couple of additional ideas on the kernel
front.

On Tue, Jan 26, 2016 at 04:21:43PM +0000, Suzuki K. Poulose wrote:
> On 26/01/16 16:02, Will Deacon wrote:
> >Hi Suzuki,
> >
> >On Tue, Jan 26, 2016 at 03:52:46PM +0000, Suzuki K Poulose wrote:
> >>ARMv8.2 extensions [1] include an optional feature, which supports
> >>half precision(16bit) floating point/asimd data processing
> >>instructions. This patch adds support for detecting and exposing
> >>the same to the userspace via HWCAPs
> 
> 
> >>+#define HWCAP_FPHP		(1 << 9)
> >>+#define HWCAP_ASIMDHP		(1 << 10)
> >
> >Where did we get to with the mrs trapping you proposed here?
> >
> >   http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/374609.html
> 
> We are yet to get some feedback from glibc/gcc folks. Siddhesh was looking
> to make use of it [2]. But haven't heard anything back. Ramana mentioned
> (in private) that they had some plans to take a look at it.

I believe one of Adhemerval's ideas was similar to what I had
mentioned back then, which was to provide all of the CPU information
in a single file instead of having to traverse a directory structure.
The other idea was to add a vDSO function that returns this data so as
to avoid (or at least reduce) the context switch latency.

This still does not solve the problem of CPUs coming online later, but
that problem shouldn't be a showstopper.  The effect of a CPU coming
online later is limited to a process that is already running and it
won't affect only microarchitecture selection, it will affect
performance of other code within glibc.

The other aspect that I am waiting for feedback from ARM for is about
the property of the MIDR value.  If it can be ascertained that a core
with a specific MIDR value will always only be in a homogeneous
configuration, we could bypass the directory traversal and just stick
to the value returned from midr_el1.  This is likely vendor-specific
and I'm waiting to know if the ARM toolchain hackers would be
comfortable with baking in such assumptions into glibc.  Extra marks
for making such a requirement explicit in future specifications.

> >At some point, we need to consider whether or not we want to continue
> >adding new HWCAPs or whether your suggestion above is actually useful
> >to userspace.
> 
> Definitely.
> 
> 
> >Did the libc guys get anywhere with a prototype? What do we need to do
> >to make progress with it?
> 
> I am not sure.
> 
> Siddesh, Ramana,
> 
> Could you please let us know your plans ?
> 
> [2] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/381422.html

I had hacked at some code with directory traversal on top of your
patch and it works fine as far as doing a PoC, but until we get
consensus on how we want to handle things like BIG.little, there can't
be much progress.

Siddhesh
