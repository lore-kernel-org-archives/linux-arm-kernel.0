From: nm@ti.com (Nishanth Menon)
Date: Thu, 16 Sep 2010 07:15:05 -0500
Subject: [PATCH 2/4] OMAP: OPP: twl/tps: Introduce TWL/TPS-specific code
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB03294424F5@dbde02.ent.ti.com>
References: <1284587799-9637-1-git-send-email-khilman@deeprootsystems.com>
	<1284587799-9637-3-git-send-email-khilman@deeprootsystems.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB03294424F5@dbde02.ent.ti.com>
Message-ID: <4C920A49.5010105@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gopinath, Thara had written, on 09/16/2010 05:40 AM, the following:
> 
>>> -----Original Message-----
>>> From: linux-omap-owner at vger.kernel.org [mailto:linux-omap-owner at vger.kernel.org] On Behalf Of Kevin
>>> Hilman
>>> Sent: Thursday, September 16, 2010 3:27 AM
>>> To: linux-omap at vger.kernel.org
>>> Cc: linux-arm-kernel at lists.infradead.org
>>> Subject: [PATCH 2/4] OMAP: OPP: twl/tps: Introduce TWL/TPS-specific code
>>>
>>> From: Paul Walmsley <paul@pwsan.com>
>>>
>>> The OPP layer code should be independent of the PMIC,
>>> introduce the TWL/TPS-specific code out to its own file.
> 
> Hello Kevin,
> 
> I have been using this code for a while now. I really do not think wee need a separate
> file for implementing the vsel to voltage in (uV) and vice versa formulas. Today only voltage
This split introduces a PMIC level abstraction already. Do you have a 
suggestion which file it should go to? It is definitely not part of 
opp.c, not part of other existing twl files as well. the job of this 
file was to introduce conversion routines which can be used by any layer 
(voltage layer if need be - it used to be srf and smartreflex before)..
in fact one of your voltage layer patches introduces capability for 6030 
as well
http://marc.info/?l=linux-omap&m=128213020927919&w=2

> layer is interested in these conversions. Voltage layer has a structure that can be populated with
> the information required from the PMIC. We only need to add two more function pointers to this structure.
 > This info can then be passed from the actual PMIC driver file. This 
will make it much
> more simpler for OMAP4 where we have different formulas between different revisions of PMIC. Also
> in the omap voltage code we will no longer have to hard code omap_twl_vsel_to_uv and omap_twl_uv_to_vsel.
I think the problem is with the voltage layer (which has not been posted 
upstream) which is using hard coded function pointer. What the patchset 
should have done is to introduce function pointers registration from 
twl_tps.c to voltage layer and voltage layer should ideally been using 
function pointers by itself.

 > So please consider dropping this patch from this series.
I think I disagree - rationale for having this separated as a pmic 
specific file is still sound, only the implementation of the future 
framework should have changed (it should be using function pointers 
instead of hardcoded function names). in fact I can add additional 
suggestion for the voltage layer: the pmic selection should be done from 
a board file - This will allow voltage layer to handle numerous PMICs 
and combination of PMICs controlling various domains as well.. the only 
neat way to handle it is ofcourse using function pointers.


PS: Suggestion
- please fix your mailer to round off for 70/80 chars..
- might be good to point folks to rfc patchset for voltage layer to give 
context.

-- 
Regards,
Nishanth Menon
