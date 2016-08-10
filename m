From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Wed, 10 Aug 2016 13:40:49 -0700
Subject: [PATCH 1/2] remoteproc: core: Add rproc OF look-up functions
In-Reply-To: <7650e5fa-f52c-1ab5-e197-8630fd7d0322@ti.com>
References: <20160719154905.23344-1-lee.jones@linaro.org>
 <20160810174049.GO26240@tuxbot>
 <7650e5fa-f52c-1ab5-e197-8630fd7d0322@ti.com>
Message-ID: <20160810204049.GV26240@tuxbot>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 10 Aug 12:37 PDT 2016, Suman Anna wrote:

> Hi Lee, Bjorn,
> 
> On 08/10/2016 12:40 PM, Bjorn Andersson wrote:
> > On Tue 19 Jul 08:49 PDT 2016, Lee Jones wrote:
> > 
> >> - of_rproc_by_index(): look-up and obtain a reference to a rproc
> >>                        using the DT phandle "rprocs" and a index.
> >>
> >> - of_rproc_by_name():  lookup and obtain a reference to a rproc
> >>                        using the DT phandle "rprocs" and "rproc-names".
> >>
> >> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> >> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> >> ---
> > 
> > I'm happy with this, so I whipped up a binding document describing our
> > two new properties. Waiting for an opinion on that before I merge this.
> 
> Yeah, I like the two new API too, I have just about run into the need
> for the same on my product trees. We can probably make it less
> complicated than what the current series is. The wkup_m3_ipc usage was
> before there was any standardization on the property names, so we went
> with a ti, prefixed property specific to the wkup_m3_ipc node and a
> general API that is agnostic of property name. We don't have all the
> pieces for PM on AM335x/AM437x SoCs on upstream kernel yet, so we should
> be able to switch over to using the new property as we cannot achieve
> the desired functionality even though we can boot the wkup_m3.
> 

Glad to hear you're onboard with dropping the old property name, even if
it's later.

> Here's what I propose:
> 1. Let's not burden the new of_get_rproc_by_index() API with having to
> fall-back and look for ti,rprocs. The rproc_get_by_phandle() core logic
> of looking up against the rproc list is self-contained, and the API
> usage is limited to just the wkup_m3_ipc driver at the moment.
> 2. Keep the rproc_get_by_phandle API as is but mark it as deprecated.
> IMHO, the rename of this API to of_get_rproc_by_phandle() in Patch 2 but
> using a device node pointer as input argument doesn't add any value.
> 3. Provide a fallback in wkup_m3_ipc driver to look for both rprocs and
> ti,rproc property, while switching over the node to use rprocs property.
> 4. We can get rid of the rproc_get_by_phandle() API after the
> wkup_m3_ipc transition is done to use of_get_rproc_by_index() API.
> 

I don't fancy the idea of leaving the kernel builds with a deprecation
warning for some time and I don't feel the cost of carrying those 2
extra statements is a bigger issue than keeping a deprecated API around.
And it will be less than the dance we have to do in wkup_m3_ipc.

So I think that we should merge these patches and if it can be concluded
that we don't need backwards compatibility with the old DT property we
can drop the inner conditional in the API.

Regards,
Bjorn
