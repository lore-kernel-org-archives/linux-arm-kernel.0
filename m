From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 30 Nov 2010 22:24:57 +0000
Subject: [PATCH 1/8] ARM: SCU: Add common routines for secondary CPU bootup
In-Reply-To: <20101130171658.GA24034@oksana.dev.rtsoft.ru>
References: <20101130171626.GA6165@oksana.dev.rtsoft.ru>
	<20101130171658.GA24034@oksana.dev.rtsoft.ru>
Message-ID: <20101130222457.GB9424@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 30, 2010 at 08:16:58PM +0300, Anton Vorontsov wrote:
> For CNS3xxx we want to reuse the original ARM approach of booting
> secondary CPUs. This patch factors out VExpress' code into a common
> file, so that now platform code can call these routines.
> 
> Note that this patch doesn't convert VExpress platform to the
> generic routines. Plus, there are also a lot of other platforms
> that might benefit from this change, but we'll convert them via
> separate patches.

I still think that we can do better with this - especially once the
crappy situation with the hotplug CPU code gets resolved.

The SCU does not require the pen_release code.  What currently requires
that is the hotplug CPU code to allow offlined CPUs to be re-woken.  If
these CPUs can be properly shutdown, and brought back online via their
reset vector, they can be brought back online via the same method used
for their initial boot.

What that means is, as we send each individual CPU an IPI, we don't
need the pen_release mess nor the holding pen, and all this code can go.

If all that code is tied into a generic "SCU" support option, then we
have to ensure that _all_ SCU using platforms can use this method before
we switch to it, rather than doing it on a per-platform basis as we can
now.
