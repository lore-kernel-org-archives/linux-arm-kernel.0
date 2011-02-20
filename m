From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 20 Feb 2011 09:10:20 +0000
Subject: [PATCH] msm: headsmp.S: Fix section mismatch
In-Reply-To: <1298168817.17118.2.camel@m0nster>
References: <1298085249-10518-1-git-send-email-sboyd@codeaurora.org>
	<1298168817.17118.2.camel@m0nster>
Message-ID: <20110220091020.GA14288@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 19, 2011 at 06:26:57PM -0800, Daniel Walker wrote:
> On Fri, 2011-02-18 at 19:14 -0800, Stephen Boyd wrote:
> > WARNING: vmlinux.o(.cpuinit.text+0xc80): Section mismatch in
> > reference from the function boot_secondary() to the variable
> > .init.text:msm_secondary_startup
> > The function __cpuinit boot_secondary() references a variable
> > __init msm_secondary_startup.  If msm_secondary_startup is only
> > used by boot_secondary then annotate msm_secondary_startup with
> > a matching annotation.
> 
> Description is pretty gross.. Can you just explain how the section
> mismatch is happening.

That's the error message, which is explanitory.

mem_secondary_startup is in the __init section, which is always discarded.
boot_secondary is in the __cpuinit section, which may or may not be
discarded, and if CPU hotplug is enabled, may be called after the __init
section has been discarded.
