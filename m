From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 04 May 2012 11:51:42 +0300
Subject: [PATCH 2/2] ARM: OMAP4: DSS hwmods: Add OCPIF_SWSUP_IDLE to all
 DSS L3 slave interfaces
In-Reply-To: <4FA37F41.3070102@ti.com>
References: <1334304116-18872-1-git-send-email-archit@ti.com>
 <1334304116-18872-3-git-send-email-archit@ti.com> <4F87E72A.2050104@ti.com>
 <4F87E924.5040601@ti.com>
 <alpine.DEB.2.00.1205040038510.20926@utopia.booyaka.com>
 <4FA37F41.3070102@ti.com>
Message-ID: <1336121502.2701.12.camel@deskari>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-05-04 at 12:33 +0530, Archit Taneja wrote:
> Hi Paul,
> 
> On Friday 04 May 2012 12:09 PM, Paul Walmsley wrote:
> > Hi Archit,
> >
> > On Fri, 13 Apr 2012, Archit Taneja wrote:
> >
> >> On Friday 13 April 2012 02:13 PM, Cousson, Benoit wrote:
> >>> On 4/13/2012 10:01 AM, Archit Taneja wrote:
> >>>> The clock for all DSS L3 slave interfaces had been recently changed to
> >>>> "dss_fck" from "l3_div_ck". "dss_fck" is an optional clock in DSS
> >>>> clock domain
> >>>> which can't autoidle when enabled.
> >>>>
> >>>> Add OCPIF_SWSUP_IDLE flag to all the L3 slave interfaces used by DSS
> >>>> hwmods so
> >>>> that clock is explicitly enabled and disabled by software. Without this,
> >>>> "dss_fck" would be left as enabled and the OMAP4 device won't idle
> >>>> even when
> >>>> DSS is not in use.
> >>>
> >>> Yeah, that was done on purpose with Tomi knowning well that limitation.
> >>>
> >>> The issue was mainly due to the lack of proper parent / child
> >>> relationship between the DSS (the whole subsystem) and the DSS children
> >>> at that time.
> >>>
> >>> I think that Tomi posted a series to fix that for 3.4. So if we ensure
> >>> that every DSS IPs are children of the DSS, then pm_runtime will always
> >>> ensure that the DSS will be enabled each time a submodule is used.
> >>>
> >>> So the right fix is to put back the proper iclk (l3_div) to the DSS
> >>> instead of the dss_fck.
> >>
> >> Ok, I get it now. Tomi's patch series ensured the parent-child
> >> dependency, but they didn't switch the iclks back to l3_div, I guess
> >> that should be a part of the series too.
> >
> > Just checking on this one.  Does this patch need to be updated ?
> >
> 
> We were working on this, but we realised that only having a parent-child 
> relation in dss platform devices won't be sufficient to remove "the use 
> of dss_fck(or MODULEMODE bits) as a slave clock" hack.
> 
> The issue is that during bootup(when omap_hwmod_setup_all() is called), 
> all hwmods are enabled independently, so all dss hwmods need to enable 
> the MODULEMODE bits for them to be setup correctly.
> 
> With the parent-child relation in platform devices in DSS, only the 
> parent platform device's hwmod("dss_core" in our case) should enable and 
> disable the MODULEMODE bits. If the children also become capable of 
> enabling/disabling it, then things wouldn't work.
> 
> Hence, to go ahead with this approach, the hwmod's themselves need to 
> have some sort of parent child relationship, or atleast some sort of use 
> counting for MODULEMODE bits. Benoit and Tomi could comment more on this.
> 
> Hence we are sort of stuck :)

Yes, this is my understanding also. I got the impression from Benoit
that adding such a parent-child relationship is not trivial.

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120504/c2262ca4/attachment-0001.sig>
