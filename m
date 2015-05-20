From: will.deacon@arm.com (Will Deacon)
Date: Wed, 20 May 2015 17:50:25 +0100
Subject: [EDT][PATCH 1/1] hw_breakpoint.c :cpu hotplug handling
In-Reply-To: <1973496787.315501431924391025.JavaMail.weblogic@ep2mlwas08c>
References: <1973496787.315501431924391025.JavaMail.weblogic@ep2mlwas08c>
Message-ID: <20150520165025.GF11498@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 18, 2015 at 05:46:31AM +0100, Vaneet Narang wrote:
> EP-2DAD0AFA905A4ACB804C4F82A001242F
> 
> On Wed, May 13, 2015 at 06:24:06AM +0100, Maninder Singh wrote:
> >> EP-2DAD0AFA905A4ACB804C4F82A001242F
> >> 
> >> Subject: [PATCH 1/1] hw_breakpoint.c :cpu hotplug handling
> >> 
> >> This patch adds support for CPU hotplug, It re-installl all installed watchpoints and breakpoints
> >> back on H/W in case of cpu-hot plug.
> 
> >Not sure why this is needed -- the scheduler should reinstall the
> >breakpoints when the debugged task gets scheduled in via
> >arch_install_hw_breakpoint.
> >
> >Will
> 
> I agree with you this reinstalling has to be either take care by scheduler
> or Debug tool. 

Which debug tool? If it's a ptrace user, then the scheduler should still
manage this, as ptrace will call into perf to create the breakpoints.

> In current implementation we clear H/W registers but we don't clear slots
> (wp_on_reg / bp_on_reg) for both watchpoint or breakpoint.

Ok, so are you saying that when the CPU is hotplugged off, the active
breakpoints aren't being uninstalled by perf? I thought this would have
happened as a result of the scheduler migrating the current task away
from the dying CPU.

Will
