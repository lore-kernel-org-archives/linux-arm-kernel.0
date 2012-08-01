From: jon-hunter@ti.com (Jon Hunter)
Date: Wed, 1 Aug 2012 14:41:34 -0500
Subject: [PATCH V2 08/10] ARM: OMAP4: Prevent EMU power domain
 transitioning to OFF when in-use
In-Reply-To: <alpine.DEB.2.00.1208010932270.21488@utopia.booyaka.com>
References: <1339104132-26885-1-git-send-email-jon-hunter@ti.com>
 <1339104132-26885-9-git-send-email-jon-hunter@ti.com>
 <alpine.DEB.2.00.1207111441300.25585@utopia.booyaka.com>
 <500028B3.1040309@ti.com>
 <alpine.DEB.2.00.1207131418500.25585@utopia.booyaka.com>
 <50045D17.9050704@ti.com>
 <alpine.DEB.2.00.1207161228470.28834@utopia.booyaka.com>
 <50171841.40309@ti.com> <501760BF.8070801@ti.com> <5018210A.1040902@ti.com>
 <50187644.40308@ti.com>
 <alpine.DEB.2.00.1208010932270.21488@utopia.booyaka.com>
Message-ID: <5019866E.3000100@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On 08/01/2012 10:36 AM, Paul Walmsley wrote:
> Hi Jon et al,
> 
> Here's what I'm planning to queue here.  The only changes from what Jon
> posted are the patch changelog and some checkpatch fixes.  If anyone
> has any final comments, please let me know.
> 
> 
> - Paul
> 
> From: Paul Walmsley <paul@pwsan.com>
> Date: Wed, 1 Aug 2012 09:11:20 -0600
> Subject: [PATCH] ARM: OMAP2+: clockdomain/hwmod: add workaround for EMU
>  clockdomain idle problems
> 
> The idle status of the IP blocks and clocks inside the EMU clockdomain
> isn't taken into account by the PRCM hardware when deciding whether
> the clockdomain is idle.  Add a workaround flag in the clockdomain
> code, CLKDM_MISSING_IDLE_REPORTING, to deal with this problem, and add
> the code necessary to support it.
> 
> If CLKDM_MISSING_IDLE_REPORTING is set on a clockdomain, the
> clockdomain will be forced active whenever an IP block inside that
> clockdomain is in use, even if the clockdomain supports
> hardware-supervised idle.  When the kernel indicates that the last
> active IP block inside the clockdomain is no longer used, the
> clockdomain will be forced idle, or, if that mode is not supported in
> the hardware, it will be placed into hardware-supervised idle.
> 
> This patch is an equal collaboration with Jon Hunter
> <jon-hunter@ti.com>.  Ming Lei <ming.lei@canonical.com>, Will Deacon
> <will.deacon@arm.com>, Madhav Vij <mvij@ti.com>, Kevin Hilman
> <khilman@ti.com>, Beno?t Cousson <b-cousson@ti.com>, and Santosh
> Shilimkar <santosh.shilimkar@ti.com> all made essential contributions
> to the understanding of EMU clockdomain power management on OMAP.
> 
> Signed-off-by: Paul Walmsley <paul@pwsan.com>

Thanks for sending out. You can add my ...

Tested-by: Jon Hunter <jon-hunter@ti.com>

I have tested this on omap3430 (beagle), omap4430 (blaze) and omap4460
(panda) with perf and my PMU series [1]. I have verified that the EMU
power domain is transitioning correctly on these platforms. For OMAP3430
I checked that CORE retention is still being achieved with this change.

Cheers
Jon

[1] git at gitorious.org:linux-omap-dev/linux-omap-dev.git -b dev-pmu
