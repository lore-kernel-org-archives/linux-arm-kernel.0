From: avinashphilip@ti.com (Philip, Avinash)
Date: Thu, 14 Feb 2013 12:04:57 +0000
Subject: [PATCH 1/2] ARM: OMAP2+: Prevent potential crash if GPMC probe
 fails
In-Reply-To: <20130209155547.GA5253@localhost>
References: <1359736726-10193-1-git-send-email-jon-hunter@ti.com>
 <1359736726-10193-2-git-send-email-jon-hunter@ti.com>
 <20130201220804.GZ22517@atomide.com> <51158293.8010101@ti.com>
 <20130209155547.GA5253@localhost>
Message-ID: <518397C60809E147AF5323E0420B992E3EA754E2@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Sat, Feb 09, 2013 at 21:25:49, Ezequiel Garcia wrote:
> On Fri, Feb 08, 2013 at 04:56:19PM -0600, Jon Hunter wrote:
> > 
> > On 02/01/2013 04:08 PM, Tony Lindgren wrote:
> > > * Jon Hunter <jon-hunter@ti.com> [130201 08:42]:
> > >> If the GPMC probe fails, devices that use the GPMC (such as ethernet
> > >> chips, flash memories, etc) can still allocate a GPMC chip-select and
> > >> register the device. On the OMAP2420 H4 board, this was causing the
> > >> kernel to crash after the gpmc probe failed and the board attempted
> > >> to start networking. Prevent this by marking all the chip-selects as
> > >> reserved by default and only make them available for devices to request
> > >> if the GPMC probe succeeds.
> > > 
> > > Thanks applying into omap-for-v3.9/gpmc.
> > 
> > Hi Tony, this one appears to be merged incorrectly. The unreserve ended 
> > up in the gpmc_calc_timings() function. Here is a patch to fix.
> > 
> > Cheers
> > Jon
> > 
> > From ebc0613fb5a70f36fcb119cbe58724f9b442903a Mon Sep 17 00:00:00 2001
> > From: Jon Hunter <jon-hunter@ti.com>
> > Date: Fri, 8 Feb 2013 16:48:25 -0600
> > Subject: [PATCH] ARM: OMAP2+: Fix-up gpmc merge error
> > 
> > Commit "ARM: OMAP2+: Prevent potential crash if GPMC probe fails" added
> > code to ensure that GPMC chip-selects could not be requested until the
> > device probe was successful. The chip-selects should have been
> > unreserved at the end of the probe function, but the code to unreserve
> > them appears to have ended up in the gpmc_calc_timings() function and
> > hence, this is causing problems requesting chip-selects. Fix this merge
> > error by unreserving the chip-selects at the end of the probe, but
> > before we call the gpmc child probe functions (for device-tree) which
> > request a chip-select.
> > 
> > Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> 
> Without this patch, GPMC is currently broken on my igep board setup,
> if initialized through a device tree.
> 
> Tested-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

Without this patch GPMC is not working in am335x-evm.

Tested-by: Philip Avinash <avinashphilip@ti.com>

See Jon's comments.

JON >> Hi Tony, this one appears to be merged incorrectly. The unreserve ended 
JON >> up in the gpmc_calc_timings() function. Here is a patch to fix.

I have tested based on linux-omap/master.

http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap.git;a=shortlog;h=refs/heads/master

Thanks
Avinash

> Without this patch, GPMC is currently broken on my igep board setup,
> if initialized through a device tree.
> 
> Thanks a lot for the fix,
> 
> -- 
> Ezequiel Garc?a, Free Electrons
> Embedded Linux, Kernel and Android Engineering
> http://free-electrons.com
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
