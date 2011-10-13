From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 13 Oct 2011 16:34:49 +0100
Subject: [PATCH v5 00/10] Per SoC descriptor
In-Reply-To: <4E9702F0.4070000@arm.com>
References: <1318255342-17451-1-git-send-email-marc.zyngier@arm.com>
	<20111013103237.GS21648@n2100.arm.linux.org.uk>
	<4E9702F0.4070000@arm.com>
Message-ID: <20111013153449.GG21648@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 13, 2011 at 04:25:36PM +0100, Marc Zyngier wrote:
> On 13/10/11 11:32, Russell King - ARM Linux wrote:
> > On Mon, Oct 10, 2011 at 03:02:12PM +0100, Marc Zyngier wrote:
> 
> [...]
> 
> >>  65 files changed, 569 insertions(+), 149 deletions(-)
> > 
> > This isn't particularly appealing for something that's supposed to
> > be a clean up - it's introducing 400+ new lines of code.  It looks like
> > most of this comes from the platform stuff rather than core stuff.
> > 
> > Can't we do any better with this?  We really need things to be going
> > in the other direction.
> 
> There is definitely room for improvement, by factoring in some common
> code across platforms. But I see that as a second phase, and started by
> just moving things to the SoC descriptor, all the code staying mostly
> the same.

I was meaning without that - what concerns me is the size of increase
just to introduce this.  It seems needlessly large.

I've also never been convinced by attempts to consolidate the hotplug
code - I've said this every time it's been suggested: I believe many
platforms just aren't trying to support hotplug CPU properly.

They've just copied the noddy Realview platform version - which is
noddy because ARMs platforms tend to have a total lack of power
management support on them.  The best we can do is put them in a WFI
loop waiting to be re-awoken.

Real platforms surely must have better PM support than that, and so
copying the Realview implementation does not make sense - it's good
to see that _some_ platforms have made an effort, though they still
just return from platform_cpu_die(), rather than the intended path of
re-awaking via the standard bringup path.  The return path from
platform_cpu_die() is supposed to be the last-ditch attempt if all else
has failed.

Note that doing that _also_ fixes the kexec problem that Will is
struggling with - if we can get that sorted we don't need to pen the
CPUs in a reserved area of memory while we kexec from one kernel to
the next - they can be kept in the boot loader while the kernel is
changed.
