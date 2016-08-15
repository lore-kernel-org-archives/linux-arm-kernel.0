From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 15 Aug 2016 14:55:05 +0100
Subject: [PATCH 1/2] remoteproc: core: Add rproc OF look-up functions
In-Reply-To: <abae5c30-62ab-55c7-a144-cb8707832941@ti.com>
References: <20160810204049.GV26240@tuxbot>
 <f9641050-0a3f-11de-fa69-e587034e0527@ti.com>
 <20160810211947.GW26240@tuxbot>
 <b1a01567-7a5d-20de-a2b5-b673b9ce67ec@ti.com>
 <20160811073122.GA1715@dell>
 <05d4c9c1-79ea-bde3-e5e5-d26e6b07c916@ti.com>
 <b1b2a510-e0cb-5d8f-9f44-48c9dd747d4d@ti.com>
 <06f795ef-e71c-2cda-5306-5b75e0f15125@ti.com>
 <20160812180751.GH26240@tuxbot>
 <abae5c30-62ab-55c7-a144-cb8707832941@ti.com>
Message-ID: <20160815135505.GI25844@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 12 Aug 2016, Suman Anna wrote:
> On 08/12/2016 01:07 PM, Bjorn Andersson wrote:
> > On Fri 12 Aug 09:37 PDT 2016, Suman Anna wrote:
> > 
> >> Hi Bjorn,
> >>
> >>>> On 08/11/2016 02:31 AM, Lee Jones wrote:
> >>>>> On Wed, 10 Aug 2016, Suman Anna wrote:
> >>>>>
> >>>>>> On 08/10/2016 04:19 PM, Bjorn Andersson wrote:
> >>>>>>> On Wed 10 Aug 14:04 PDT 2016, Suman Anna wrote:
> >>>>>>>
> >>>>>>>> On 08/10/2016 03:40 PM, Bjorn Andersson wrote:
> >>>>>>>>> On Wed 10 Aug 12:37 PDT 2016, Suman Anna wrote:
> >>>>>>>>>
> >>>>>>>>>> Hi Lee, Bjorn,
> >>>>>>>>>>
> >>>>>>>>>> On 08/10/2016 12:40 PM, Bjorn Andersson wrote:
> >>>>>>>>>>> On Tue 19 Jul 08:49 PDT 2016, Lee Jones wrote:
> >>>>>>>>>>>
> >>>>>>>>>>>> - of_rproc_by_index(): look-up and obtain a reference to a rproc
> >>>>>>>>>>>>                        using the DT phandle "rprocs" and a index.
> >>>>>>>>>>>>
> >>>>>>>>>>>> - of_rproc_by_name():  lookup and obtain a reference to a rproc
> >>>>>>>>>>>>                        using the DT phandle "rprocs" and "rproc-names".
> >>>>>>>>>>>>
> >>>>>>>>>>>> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> >>>>>>>>>>>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> >>>>>>>>>>>> ---
> >>>>>>>>>>>
> >>>>>>>>>>> I'm happy with this, so I whipped up a binding document describing our
> >>>>>>>>>>> two new properties. Waiting for an opinion on that before I merge this.
> >>
> >> One last comment on this is the return code convention change on these
> >> rproc_get APIs. I am fine in general with returning ERR_PTRs, but most
> >> of the remoteproc code is using NULL checking for rproc. If you remember
> >> the discussion back during the hwspinlock DT conversion [1], Ohad
> >> preferred to return NULL, and that's why even the rproc_get_by_phandle
> >> was returning NULL. We ought to make this consistent across the board if
> >> we want to make this switch.

IMHO it's always better to use the appropriate Linux error code in the
event of a failure and if it's available.  Returning NULL doesn't
actually tell us anything about the failure.  This will also come in
handy when we start playing around with resource tables.  For
instance, NULL will insinuate "no table supplied", which is valid and
execution should continue.  Where as a positive IS_ERR() insinuates
that something went wrong and execution should be cut short and an
error value returned to the caller.

> > I think it makes sense to return the actual error from these functions,
> > if nothing else to keep it consistent with other frameworks.
> > 
> > The other case I see returning NULL is rproc_alloc(), which is think is
> > analog to kmalloc(), so I think that's fine to keep.
> > 
> > Luckily wkup_m3 is the only consumer of this API in the kernel today, so
> > we shouldn't have any issues wrt changing the return value here.
> 
> Yeah, not worried about the consumers, I am talking about the few
> functions in remoteproc core code that do some checking like in
> rproc_del(), __rproc_boot() or rproc_report_crash(). We would need to
> modify these to use IS_ERR_OR_NULL instead of a NULL check atleast.

I haven't looked at the code, but +1 in principle.

> >> [1] http://marc.info/?t=138965891200008
> > 
> > Regards,
> > Bjorn
> > 
> 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
