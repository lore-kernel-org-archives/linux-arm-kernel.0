From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 29 Mar 2016 10:04:15 +0100
Subject: [PATCH] usb: host: xhci-plat: Make enum xhci_plat_type start at
 a non zero value
In-Reply-To: <87fuvd8s80.fsf@ti.com>
References: <1458917188-28452-1-git-send-email-peter.griffin@linaro.org>
 <87mvpm8pfl.fsf@ti.com> <87mvpmlc5e.fsf@free-electrons.com>
 <87io0a8nbd.fsf@ti.com>
 <20160326091050.GA7793@griffinp-ThinkPad-X1-Carbon-2nd>
 <87fuvd8s80.fsf@ti.com>
Message-ID: <20160329090415.GA8659@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 26 Mar 2016, Felipe Balbi wrote:
> Peter Griffin <peter.griffin@linaro.org> writes:
> > On Fri, 25 Mar 2016, Felipe Balbi wrote:
> >> Gregory CLEMENT <gregory.clement@free-electrons.com> writes:
> >> >> Peter Griffin <peter.griffin@linaro.org> writes:
> >> >>> Otherwise generic-xhci and xhci-platform which have no data get wrongly
> >> >>> detected as XHCI_PLAT_TYPE_MARVELL_ARMADA by xhci_plat_type_is().
> >> >>>
> >> >>> This fixes a regression in v4.5 for STiH407 family SoC's which use the
> >> >>> synopsis dwc3 IP, whereby the disable_clk error path gets taken due to
> >> >>> wrongly being detected as XHCI_PLAT_TYPE_MARVELL_ARMADA and the hcd never
> >> >>> gets added.
> >> >>>
> >> >>> I suspect this will also fix other dwc3 DT platforms such as Exynos,
> >> >>> although I've only tested on STih410 SoC.
> >> >>>
> >> >>> Fixes: 4efb2f694114 ("usb: host: xhci-plat: add struct xhci_plat_priv")
> >> >>> Cc: stable at vger.kernel.org
> >> >>> Cc: gregory.clement at free-electrons.com
> >> >>> Cc: yoshihiro.shimoda.uh at renesas.com
> >> >>> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> >> >>> ---
> >> >>>  drivers/usb/host/xhci-plat.h | 2 +-
> >> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >> >>>
> >> >>> diff --git a/drivers/usb/host/xhci-plat.h b/drivers/usb/host/xhci-plat.h
> >> >>> index 5a2e2e3..529c3c4 100644
> >> >>> --- a/drivers/usb/host/xhci-plat.h
> >> >>> +++ b/drivers/usb/host/xhci-plat.h
> >> >>> @@ -14,7 +14,7 @@
> >> >>>  #include "xhci.h"	/* for hcd_to_xhci() */
> >> >>>  
> >> >>>  enum xhci_plat_type {
> >> >>> -	XHCI_PLAT_TYPE_MARVELL_ARMADA,
> >> >>> +	XHCI_PLAT_TYPE_MARVELL_ARMADA = 1,
> >> >>>  	XHCI_PLAT_TYPE_RENESAS_RCAR_GEN2,
> >> >>>  	XHCI_PLAT_TYPE_RENESAS_RCAR_GEN3,
> >> >>
> >> >> aren't these platforms using device tree ? Why aren't these just
> >> >> different compatible strings ?
> >> >
> >> > According to 4efb2f69411456d35051e9047c15157c9a5ba217 "usb: host:
> >> > xhci-plat: add struct xhci_plat_priv" :
> >> >
> >> > This patch adds struct xhci_plat_priv to simplify the code to match
> >> > platform specific variables. For now, this patch adds a member "type" in
> >> > the structure
> >> 
> >> that's fine but the answer doesn't exactly match my question ;-)
> >> 
> >> My point is that this enum shouldn't be necessary at all. We have
> >> compatible flags to make these checks instead. How about below ?
> >> (untested, uncompiled, yada yada yada). Note that we DON'T need this
> >> xhci_plat_type trickery, just need to be a little bit smarter about how
> >> we use driver_data:
> >
> > Your solution certainly looks more elegant.
> 
> cool thanks. Now that I think about this more carefully, we might wanna
> take $subject anyway for the -rc and get my version applied for v4.7
> merge window. What do you think ?

+1 for a simple/quick fix.

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
