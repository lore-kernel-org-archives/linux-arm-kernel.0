From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 31 Jul 2013 18:16:09 +0100
Subject: [PATCH] arm: add .text at __CPUINIT places to prevent section
 grandfathering
In-Reply-To: <1375290418-1848-1-git-send-email-paul.gortmaker@windriver.com>
References: <20130731094352.GV24642@n2100.arm.linux.org.uk>
 <1375290418-1848-1-git-send-email-paul.gortmaker@windriver.com>
Message-ID: <20130731171609.GX24642@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 31, 2013 at 01:06:58PM -0400, Paul Gortmaker wrote:
> In commit 22f0a27367742f65130c0fb25ef00f7297e032c1
> ("init.h: remove __cpuinit sections from the kernel") the macros
> like __CPUINIT were converted from .section commands to no-ops.
> 
> This caused CPU hotplug regressions because the code following
> the __CPUINIT lines was now grandfathered into whatever the
> previous section happened to be.  In most files, __CPUINIT was
> at the top of the file, so there was no previous section.
> 
> However in the files changed here, there was a previous section,
> and so we'd inadvertently garbage collect CPU hotplug related
> code.  This changeset inserts ".text" into the exact same spot
> that the __CPUINIT section markers were found prior to commit
> 8bd26e3a7e49af2697449bbcb7187a39dc85d672 ("arm: delete
> __cpuinit/__CPUINIT usage from all ARM users:) in the three affected
> files, as suggested by Russell.
> 
> Bisected-by: Simon Horman <horms@verge.net.au>
> Reported-by: Magnus Damm <magnus.damm@gmail.com>
> Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

I already have this in my git tree as of this morning, thanks anyway.
