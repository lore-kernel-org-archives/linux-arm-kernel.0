From: horms@verge.net.au (Simon Horman)
Date: Wed, 2 Sep 2015 11:29:36 +0900
Subject: [PATCH v2] ARM: shmobile: silk: add SDHI1 DT support
In-Reply-To: <55D7A3A1.9020009@cogentembedded.com>
References: <10037494.4LD4T2QGPX@wasted.cogentembedded.com>
 <2757472.iuyUyRzJ3z@wasted.cogentembedded.com>
 <20150812012652.GH15957@verge.net.au>
 <55D790A5.1050008@cogentembedded.com>
 <55D7A3A1.9020009@cogentembedded.com>
Message-ID: <20150902022936.GA18115@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 22, 2015 at 01:18:09AM +0300, Sergei Shtylyov wrote:
> On 08/21/2015 11:57 PM, Sergei Shtylyov wrote:
> 
> >>>Define the SILK board dependent part of the SDHI1 (connected to micro-SD slot)
> >>>device nodes along with the necessary voltage regulators.
> >>>
> >>>Based on the original patch by Vladimir Barinov
> >>><vladimir.barinov@cogentembedded.com>.
> >>>
> >>>Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> >>>
> >>>---
> >>>This patch is against 'renesas-devel-20150810-v4.2-rc6' tag of Simon Horman's
> >>>'renesas.git' repo plus the R8A7794/SILK QSPI patches just re-posted. It needs
> >>>the R8A7794 GPIO patches in order to compile.
> >>>
> >>>Changes in version 2:
> >>>- removed not working SDHI0 stuff, renamed the patch;
> >>>- replaced SDHI1's "wp-gpios" property with "disable-wp".
> >>
> >>I am wondering if you could explain the motivation for the "disable-wp"
> >>update
> >
> >    Please see the comment in mmc_sd_get_ro().
> >
> >>and weather it is appropriate for other r8a779* dts files.
> >
> >    In case of micro-SD slots, yes.
> 
>    The MMC binding document says it should only be specified if the
> controller has WP detection logic. We, so far, seem to have been replying on
> the GPIOs despite this logic is present (according to the R-Car gen2 SDHI
> manuals I have). The driver will first call mmc_gpio_get_ro() and when that
> fails due to "wp-gpios" not being specified, it proceeds to reading the
> register but that is forbidden by TMIO_MMC_WRPROTECT_DISABLE flag set for
> the R-Car gen1/2 chips, so 0 is always returned from tmio_mmc_get_ro().
> There seems to be no point in going that far (and doing the runtime PM
> dances) --
> and MMC_CAP2_NO_WRITE_PROTECT (set when "disable-wp" is specified) prohibits
> doing that...

That sounds reasonable to me.
Some more questions from my side:

* What is the status of this patch
* Can you prepare patches for r8a779* dts files for micro-SD slots?
