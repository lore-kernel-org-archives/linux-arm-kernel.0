From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 Aug 2014 11:03:01 +0200
Subject: VFP available on a single CPU in a dual-CPU complex
In-Reply-To: <CAGVrzcaX4n2rJko_Kny81jkzQbV6z5TmcA2coGrj6BU-ahiOTA@mail.gmail.com>
References: <CAGVrzcaX4n2rJko_Kny81jkzQbV6z5TmcA2coGrj6BU-ahiOTA@mail.gmail.com>
Message-ID: <201408151103.01349.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 August 2014, Florian Fainelli wrote:
> Hello,
> 
> On Broadcom's BCM63138 SoC, the second Cortex A9 CPU does not have
> VFP, which is a problem as one might imagine because we currently
> assume it is available for all CPUs within the complex.

Wow, that is pretty crazy.

> I started to patch vfp_support_entry to test for CPU1 and branch to a
> different location, but that raises a bunch of question, in particular
> what to do if NEON/VFP came from the kernel, how can we migrate that
> execution to CPU0?
>
> If the answer is don't use VFP, I guess that's fine, and I can have a
> runtime check in vfp_init() that checks for BCM63138 and set
> vfp_vector to vfp_null_entry even though we are running on a multi-v7
> kernel with VFP enabled.

I think adding hooks to the scheduler for this case is problematic, so
the easiest way would of course be to give the user a choice between
VFP or SMP on this hardware. For anything beyond that, you could do
a prototype patch (possibly for integration into OpenWRT) so we can
see how ugly it gets to support this setup.

One potentially workable approach may be to just forbid in-kernel
VFP (there is very little of that already, and we might not be
handling it right in a multiplatform kernel, I haven't checked)
if not all CPUs support it. For user space, you could mandate that
user space sets the right affinity mask for any process using VFP.
A general-purpose distro that relies on VFP wouldn't work on this
machine anyway, so we can reasonably assume that there is custom
user space involved if there is any VFP.

	Arnd
