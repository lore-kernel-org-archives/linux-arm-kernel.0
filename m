From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 3 Jun 2013 09:51:04 +0800
Subject: [PATCH v2 2/2] ARM: mxs: Pass the system revision
In-Reply-To: <2476534.aRbruDjF6n@kerker>
References: <1370040127-15072-1-git-send-email-festevam@gmail.com>
 <3068502.pO6ZTjjROM@kerker>
 <CAOMZO5DqQXDbHEdD+SMtQLkAVrx0AffDL46=JoiqFnc_-6wTFQ@mail.gmail.com>
 <2476534.aRbruDjF6n@kerker>
Message-ID: <20130603015102.GE13970@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 02, 2013 at 12:11:16AM +0200, Michael Heimpold wrote:
> Hi Fabio,
> 
> Am Samstag, 1. Juni 2013, 11:58:18 schrieb Fabio Estevam:
> > Can you please provide some real examples?
> 
> Please have a look at e.g. mach-orion5x/dns323-setup.c or grep for
> system_rev in arch/arm.
> An out-of-vanilla-tree example is a board I've worked on:
> https://github.com/iequalize/linux-mxs/blob/v2.6.35.14-openwrt-fsl-tq-ieq/arch/arm/mach-mx28/board-homebox.c
> In arm/mach-omap2/board-omap3touchbook.c I'm not able to tell whether
> the use system_rev to encode a PCB revision or a CPU revision.
> 
> > If you look at FSL kernel code the system revision is hardcoded in the
> > board file.
> > For mx5/mx6 boards we do pass ATAGS from bootloader to kernel in the
> > same format it was used here.
> 
> I see it. But I still wonder whether this is the right direction to pass the
> SoC revision to user-space. And I feel uncomfortable when we're
> mixing it with a board revision. I would prefer dedicated lines in /proc/cpuinfo.
> Is there a policy about adding line which would prohibit this?
> 
> > As I mentioned in the commit log, the only reason we are doing this
> > here is to allow a mainline kernel to run som mxs applications like
> > Gstreamer plugins and kobs-ng.
> 
> I only know the kobs-ng util but I got the point: these tools (only) look at the
> revision line and cannot be used with a mainline kernel at the moment
> as a vanilla kernel don't pass the information required by these tools.
> 
> However, the revision field is arm platform specific and should be used with
> the same purpose over all mach types. Interpreting it for different SoCs
> in a different manner is IMO not a good idea.

+1

Now I feel strongly that we should use soc infrastructure
(drivers/base/soc.c) to export soc ID and revision to user space.  Maybe
it's time to change those incompatible user applications.

Shawn
