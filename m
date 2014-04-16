From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 16 Apr 2014 23:33:43 +0100
Subject: Change of TEXT_OFFSET for multi_v7_defconfig
In-Reply-To: <534EF153.5050603@codeaurora.org>
References: <534D0D91.8020406@linaro.org> <534EAD6C.3040502@codeaurora.org>
 <alpine.LFD.2.11.1404161428280.980@knanqh.ubzr>
 <534EF153.5050603@codeaurora.org>
Message-ID: <20140416223343.GM24070@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 16, 2014 at 05:08:35PM -0400, Christopher Covington wrote:
> What I meant to ask about was variance from one kernel version and build to
> the next, given a single platform. Platform-to-platform variation can probably
> be abstracted where needed by the scripts controlling the external load. In
> any case, CONFIG_VMSPLIT_* that you mentioned above would be an example where
> it would vary in an inconvenient manner, so this approach wouldn't be an
> improvement.

No it wouldn't.  CONFIG_VMSPLIT_* has nothing to do with where the kernel
is loaded in physical memory.  That's all about how the kernel sets up the
page tables, and where the kernel eventually expects to run in the virtual
address space.

As far as the debugger goes, it still loads the kernel at the exact same
address irrespective of what CONFIG_VMSPLIT_* setting is chosen.

The issue here is with arm-soc's single zImage project sucking in existing
platforms where there's a requirement to keep the first N kB of memory
free from use - eg, because a boot loader likes to scribble over it, or
it's in use by a DSP processor, or something similar.

Once one of those platforms is merged and enabled in the single zImage,
the offset into RAM that the kernel must be loaded has to change to
avoid clashing on those platforms.

So, there really isn't one single Kconfig option you can point at to tell
what physical RAM offset the kernel needs to be loaded at... it depends
what platforms are enabled in the kernel you're trying to boot.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
