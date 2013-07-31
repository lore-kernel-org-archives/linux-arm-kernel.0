From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 31 Jul 2013 10:43:53 +0100
Subject: [PATCH] ARM: Fix memblock_reserve() to include stext
In-Reply-To: <20130731055807.14054.70106.sendpatchset@w520>
References: <20130731055807.14054.70106.sendpatchset@w520>
Message-ID: <20130731094352.GV24642@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 31, 2013 at 02:58:07PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> This fix for the ARM architecture will include stext
> in the memblock_reserve() call to make sure that the
> following symbols are not overwritten (from System.map):
> 
> c0008000 T _text
> c0008000 T stext
> ...
> c0008138 T secondary_startup
> ...
> c0009000 T _stext
> 
> With this patch applied CPU Hotplug starts working
> again. Without this patch code in secondary_startup
> never gets reached as expected.
> 
> This issue started triggering on kernels later than
> v3.10 - perhaps a side effect of the CPU Hotplug init
> section rework - so this is a fix for v3.11-rc.

This is not the right fix.  The commit you previously pointed out (removal
of CPU hotplug) probably means there's a missing annotation somewhere in
the code.

And yes - the __CPUINIT just before ENTRY(secondary_startup) was removed
rather than being replaced with a .text (in both head.S and head-nommu.S).
Same goes for ENTRY(lookup_processor_type) in head-common.S.  All these
need to be replaced with .text to stop them falling into the head section.
