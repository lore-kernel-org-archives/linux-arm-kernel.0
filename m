From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 19 Jan 2012 17:17:37 +0000
Subject: [PATCH 03/11] Revert "RTC: sa1100: support sa1100, pxa and mmp
 soc families"
In-Reply-To: <alpine.LFD.2.02.1201191210350.19587@xanadu.home>
References: <20120119153149.GB1068@n2100.arm.linux.org.uk>
 <E1RntzR-0002pR-Br@rmk-PC.arm.linux.org.uk>
 <alpine.LFD.2.02.1201191210350.19587@xanadu.home>
Message-ID: <20120119171737.GB10404@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 19, 2012 at 12:11:45PM -0500, Nicolas Pitre wrote:
> On Thu, 19 Jan 2012, Russell King - ARM Linux wrote:
> 
> > This reverts commit 7cea00657dd4daef66ad95e976d5d67ed94cb97e.
> > 
> > The sa1100 cleanups fatally broke the SA1100 RTC driver - the first
> > hint that something is wrong are these compiler warnings:
> > 
> > drivers/rtc/rtc-sa1100.c:42:1: warning: "RCNR" redefined
> > In file included from arch/arm/mach-sa1100/include/mach/hardware.h:73,
> >                  from drivers/rtc/rtc-sa1100.c:35:
> > arch/arm/mach-sa1100/include/mach/SA-1100.h:877:1: warning: this is the location of the previous definition
> > drivers/rtc/rtc-sa1100.c:43:1: warning: "RTAR" redefined
> > arch/arm/mach-sa1100/include/mach/SA-1100.h:876:1: warning: this is the location of the previous definition
> > drivers/rtc/rtc-sa1100.c:44:1: warning: "RTSR" redefined
> > arch/arm/mach-sa1100/include/mach/SA-1100.h:879:1: warning: this is the location of the previous definition
> > drivers/rtc/rtc-sa1100.c:45:1: warning: "RTTR" redefined
> > arch/arm/mach-sa1100/include/mach/SA-1100.h:878:1: warning: this is the location of the previous definition
> > drivers/rtc/rtc-sa1100.c:47:1: warning: "RTSR_HZE" redefined
> > arch/arm/mach-sa1100/include/mach/SA-1100.h:891:1: warning: this is the location of the previous definition
> > drivers/rtc/rtc-sa1100.c:48:1: warning: "RTSR_ALE" redefined
> > arch/arm/mach-sa1100/include/mach/SA-1100.h:890:1: warning: this is the location of the previous definition
> > drivers/rtc/rtc-sa1100.c:49:1: warning: "RTSR_HZ" redefined
> > arch/arm/mach-sa1100/include/mach/SA-1100.h:889:1: warning: this is the location of the previous definition
> > drivers/rtc/rtc-sa1100.c:50:1: warning: "RTSR_AL" redefined
> > arch/arm/mach-sa1100/include/mach/SA-1100.h:888:1: warning: this is the location of the previous definition
> > 
> > and the second problem, which is far more severe, are the different
> > register layouts, resulting in the wrong registers being read on
> > SA11x0 platforms.  This patch adds:
> > 
> > but the SA11x0 registers are:
> > ---
> >  arch/arm/mach-pxa/devices.c    |   20 ---
> >  arch/arm/mach-sa1100/generic.c |   20 ---
> >  drivers/rtc/Kconfig            |    2 +-
> >  drivers/rtc/rtc-sa1100.c       |  256 ++++++++++++---------------------------
> >  4 files changed, 80 insertions(+), 218 deletions(-)
> [...]
> 
> Truncated log?

No, it appears that something decided to delete several lines from the
log file, particularly those between "This patch adds:" and the
"but the SA11x0 registers are".

I'll add them back, and hope git doesn't lose them again.
