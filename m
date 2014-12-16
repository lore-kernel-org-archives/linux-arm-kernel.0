From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 16 Dec 2014 09:20:15 +0100
Subject: [PATCH] clk: samsung: Fix Exynos 5420 pinctrl setup and clock
 disable failure due to domain being gated
In-Reply-To: <7h8ui8h7n9.fsf@deeprootsystems.com>
References: <1417788934-23447-1-git-send-email-k.kozlowski@samsung.com>
 <1418129982.19339.6.camel@AMDC1943> <5486F69B.6020005@samsung.com>
 <7hlhmfo1b0.fsf@deeprootsystems.com> <7h8ui8h7n9.fsf@deeprootsystems.com>
Message-ID: <1418718015.28527.4.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On pon, 2014-12-15 at 14:26 -0800, Kevin Hilman wrote:
> Kevin Hilman <khilman@kernel.org> writes:
> 
> > Sylwester Nawrocki <s.nawrocki@samsung.com> writes:
> >
> >> On 09/12/14 13:59, Krzysztof Kozlowski wrote:
> >>> On pi?, 2014-12-05 at 15:15 +0100, Krzysztof Kozlowski wrote:
> >>>> > Audio subsystem clocks are located in separate block. On Exynos 5420 if
> >>>> > clock for this block (from main clock domain) 'mau_epll' is gated then
> >>>> > any read or write to audss registers will block.
> >>>> > 
> >>>> > This kind of boot hang was observed on Arndale Octa and Peach Pi/Pit
> >>>> > after introducing runtime PM to pl330 DMA driver. After that commit the
> >>>> > 'mau_epll' was gated, because the "amba" clock was disabled and there
> >>>> > were no more users of mau_epll.
> >>>> > 
> >>>> > The system hang on one of steps:
> >>>> > 1. Disabling unused clocks from audss block.
> >>>> > 2. During audss GPIO setup (just before probing i2s0 because
> >>>> >    samsung_pinmux_setup() tried to access memory from audss block which was
> >>>> >    gated.
> >>>> > 
> >>>> > Add a workaround for this by enabling the 'mau_epll' clock in probe.
> >>>> > 
> >>>> > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> >>>> > ---
> >>>> >  drivers/clk/samsung/clk-exynos-audss.c | 29 ++++++++++++++++++++++++++++-
> >>>> >  1 file changed, 28 insertions(+), 1 deletion(-)
> >>>
> >>> Sorry for pinging so quick but merge window is open and it looks like
> >>> booting Exynos542x boards will be broken (because pl330 will no longer
> >>> hold adma clock enabled so whole audss domain will be gated).
> >>> 
> >>> This is a non-intrusive workaround for that issue, as wanted by
> >>> Sylwester:
> >>> https://lkml.org/lkml/2014/12/5/223
> >>> 
> >>> Any comments on this?
> >>
> >> The patch looks OK to me, it would be good though if someone else
> >> has confirmed it fixes the bug. I don't have any clock patches queued
> >> at the moment. Perhaps you could apply it directly, Mike ?
> >
> > I confirm it fixes the boot hang in linux-next (next-20141210) on my
> > exynos5800-peach-pi and exynos5420-arndale-octa.  Tested both
> > exynos_defconfig and multi_v7_defconfig.
> >
> > Tested-by: Kevin Hilman <khilman@linaro.org>
> 
> What's the status of this patch?  linux-next is still broken for several
> Exynos5 platforms without this fix.

I believe not only next is broken but also current mainline because
runtime PM for pl330 was merged yesterday...

The patch received two tested-bys (Kevin's and Javier's) and Sylwester's
ack.

Mike, could you pick the patch and send it to Linus after rc1?

Best regards,
Krzysztof
