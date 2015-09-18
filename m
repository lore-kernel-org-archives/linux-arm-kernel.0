From: horms@verge.net.au (Simon Horman)
Date: Fri, 18 Sep 2015 09:21:22 +0900
Subject: [PATCH v2] ARM: shmobile: silk: add SDHI1 DT support
In-Reply-To: <55EA2D8D.90004@cogentembedded.com>
References: <10037494.4LD4T2QGPX@wasted.cogentembedded.com>
 <2757472.iuyUyRzJ3z@wasted.cogentembedded.com>
 <20150812012652.GH15957@verge.net.au>
 <55D790A5.1050008@cogentembedded.com>
 <55D7A3A1.9020009@cogentembedded.com>
 <20150902022936.GA18115@verge.net.au>
 <55EA2D8D.90004@cogentembedded.com>
Message-ID: <20150918002122.GC12858@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 05, 2015 at 02:47:25AM +0300, Sergei Shtylyov wrote:
> Hello.
> 
> On 09/02/2015 05:29 AM, Simon Horman wrote:
> 
> >>>>>Define the SILK board dependent part of the SDHI1 (connected to micro-SD slot)
> >>>>>device nodes along with the necessary voltage regulators.
> >>>>>
> >>>>>Based on the original patch by Vladimir Barinov
> >>>>><vladimir.barinov@cogentembedded.com>.
> >>>>>
> >>>>>Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> >>>>>
> >>>>>---
> >>>>>This patch is against 'renesas-devel-20150810-v4.2-rc6' tag of Simon Horman's
> >>>>>'renesas.git' repo plus the R8A7794/SILK QSPI patches just re-posted. It needs
> >>>>>the R8A7794 GPIO patches in order to compile.
> >>>>>
> >>>>>Changes in version 2:
> >>>>>- removed not working SDHI0 stuff, renamed the patch;
> >>>>>- replaced SDHI1's "wp-gpios" property with "disable-wp".
> >>>>
> >>>>I am wondering if you could explain the motivation for the "disable-wp"
> >>>>update
> >>>
> >>>    Please see the comment in mmc_sd_get_ro().
> >>>
> >>>>and weather it is appropriate for other r8a779* dts files.
> >>>
> >>>    In case of micro-SD slots, yes.
> >>
> >>    The MMC binding document says it should only be specified if the
> >>controller has WP detection logic. We, so far, seem to have been replying on
> >>the GPIOs despite this logic is present (according to the R-Car gen2 SDHI
> >>manuals I have). The driver will first call mmc_gpio_get_ro() and when that
> >>fails due to "wp-gpios" not being specified, it proceeds to reading the
> >>register but that is forbidden by TMIO_MMC_WRPROTECT_DISABLE flag set for
> >>the R-Car gen1/2 chips, so 0 is always returned from tmio_mmc_get_ro().
> >>There seems to be no point in going that far (and doing the runtime PM
> >>dances) --
> 
>    Alternatively, the driver could be fixed to check the flag before the RPM
> call unlike what it does now.

If the driver can be updated to do the right thing then that seems
preferable to me. If so would it be the case that the presence of the
"disable-wp" property would not have any run-time effect?
> 
> >>and MMC_CAP2_NO_WRITE_PROTECT (set when "disable-wp" is specified) prohibits
> >>doing that...
> >
> >That sounds reasonable to me.
> 
>    I'm still wondering why TMIO_MMC_WRPROTECT_DISABLE is set for the R-Car
> SoCs. Morimoto-san, any comments? Your change logs are too terse. :-)

I will follow up on this.

> >Some more questions from my side:
> 
> >* What is the status of this patch
> 
>    Tested, working.
> 
> >* Can you prepare patches for r8a779* dts files for micro-SD slots?
> 
>    Ugh, I probably can but won't promise anything.

Likewise, ugh.
