From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 9 May 2014 17:22:40 +0100
Subject: [PATCH 0/8] arm64 kexec kernel patches
In-Reply-To: <cover.1399594544.git.geoff@infradead.org>
References: <cover.1399594544.git.geoff@infradead.org>
Message-ID: <20140509162240.GC16418@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 09, 2014 at 01:48:17AM +0100, Geoff Levand wrote:
> Hi Maintainers,
> 
> This patchset adds support for kexec re-boots on arm64.  I have tested with the 
> VE fast model using various kernel config options with both spin and psci enable 
> methods.  I'll continue to test in the coming weeks.
> 
> I tried to re-use the existing hot plug cpu_ops support for the secondary CPU 
> shutdown as much as possible, but needed to do some things specific to kexec 
> that I couldn't do with what was already there.  A significant change is in 
> [PATCH 4/8] (arm64: Add smp_spin_table_set_die) where I add the ability to setup 
> a custom cpu_die handler.
> 
> To get the the spin-table secondary CPUs into the proper state described in 
> Documentation/arm64/booting.txt I use a three step spin loop.  First in the 
> kernel's virtual address space, then to the identity mapped address, then jump 
> to the final spin code in the 2nd stage kernel's /memreserve/ area.  To support 
> this three step spin I needed [PATCH 5/8] (arm64: Split soft_restart into two 
> stages).  Please see the patch comments for more info.  If we added the 2nd 
> stage kernel's /memreserve/ area to the identity map we could eliminate the 
> middle step and go from the VA space to the /memreserve/ area directly.

As I've covered in my reply to patch 7 [1] I don't think this is a good
approach. I think a vastly better approach is to make kexec depend on
cpu hotplug support in SMP, and enable a simple hotplug-capable boot
protocol (e.g. extend spin-table with a cpu-return-addr).

That way the in-kernel portions of kexec can use the existing
infrastructure without tonnes of point hacks, and we enable a generic
hotplug capable mechanism for those systems which cannot implement PSCI.

> 
> Please consider all patches for inclusion.  Any comments or suggestions on how 
> to improve would be very welcome.
> 
> To load a kexec kernel and execute a kexec re-boot on arm64 my patches to
> kexec-tools, which have not yet been merged upstream, are needed:
> 
>   https://git.linaro.org/people/geoff.levand/kexec-tools.git

Is the master branch up-to-date?  The commit dates on all branches I can
see imply they haven't been updated in a while, and the code looks like
it needs some cleanup (there are some unused functions, hard-coded
values, etc).

Cheers,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-May/254819.html
