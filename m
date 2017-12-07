From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Thu, 7 Dec 2017 09:29:58 +0100
Subject: [PATCH] ACPI / GED: unregister interrupts during shutdown
In-Reply-To: <CAJZ5v0hEdK_vJcHeoz=Z2H6od=bktspPpTo37Y6qiOT2qptnaA@mail.gmail.com>
References: <1512507705-2411-1-git-send-email-okaya@codeaurora.org>
 <CAJZ5v0jcFqG=Jd19ms7XQMR+rGfdKTEaN7SK91DPzBa=xcMY1w@mail.gmail.com>
 <0b661eec-f9c7-7818-ad09-f3d488adcefe@codeaurora.org>
 <CAJZ5v0hkajauiqEmEVv+k-OYeP+_S4wufjuR7vmhcxARpRpw=g@mail.gmail.com>
 <fe65ff1a-a8b8-c29b-161d-72cbfea5c056@codeaurora.org>
 <aa5bcbab-b059-1abf-1553-371fe5750455@codeaurora.org>
 <CAJZ5v0iifeFpJsSwXO1AGLW3rn1cG7t3V6ZAnu34-K=D_DavBA@mail.gmail.com>
 <e0f77da3-93d8-d474-3531-488f8f5f6108@codeaurora.org>
 <CAJZ5v0iaursWFP_KRoJqT6-QoGkvpTot0oMvs6qdjkaP12p9jQ@mail.gmail.com>
 <CAJZ5v0hEdK_vJcHeoz=Z2H6od=bktspPpTo37Y6qiOT2qptnaA@mail.gmail.com>
Message-ID: <20171207082958.GA11882@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 07, 2017 at 12:19:25AM +0100, Rafael J. Wysocki wrote:
> Hi Greg,
> 
> On Wed, Dec 6, 2017 at 6:16 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > On Wed, Dec 6, 2017 at 5:55 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
> >> On 12/6/2017 11:41 AM, Rafael J. Wysocki wrote:
> >>> On Wed, Dec 6, 2017 at 5:11 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
> >>>> On 12/6/2017 9:57 AM, Sinan Kaya wrote:
> >>>>>> Yes, it should, so I'm not sure why you need the list in the first place.
> >>>>>>
> >>>>>> Also it looks like something along the lines of devres_release_all()
> >>>>>> should be sufficient.
> >>>>> Good suggestion, let me test this.
> >>>>>
> >>>>
> >>>> I tried to pull the code into GED but the API is not public. I also looked
> >>>> at how it is used. I was afraid to mess up with the internals of base.c by
> >>>> calling devres_release_all() externally first and by the driver framework
> >>>> next. I moved away from this approach.
> >>>
> >>> Are you sure it is called by the core in the shutdown path?
> >>
> >> Sorry, I was thinking about a general case not the shutdown path. If we open
> >> this API and have device drivers call it from arbitrary places; then we could
> >> be opening a new can of worms that show up during device driver removal.
> 
> [cut]
> 
> >
> > OK
> >
> > Anyway, it looks like something is missing in the core.
> >
> > You shouldn't really need to do all that dance in a driver.
> 
> We have a problem with the ACPI GED driver which essentially is a
> platform driver requesting a number of interrupts and handling them by
> dispatching a specific AML method.
> 
> It uses devm_request_threaded_irq() to request the interrupts, so it
> doesn't need a ->remove() callback, but it turns out to need a
> ->shutdown() one to free all of these interrupts at the shutdown time.
> 
> While we can add a ->shutdown() callback to it, that essentially needs
> to duplicate devres_release_all() somewhat.
> 
> Any suggestions what to do with that?

Just don't use devm_request_threaded_irq()?  :)

Seriously, those are just "helper" functions if your code happens to
follow the pattern they provide, if not, then don't use them, it's not
that hard to provide the correct code to unwind things properly by "open
coding" this logic as needed.

The devm_*irq() functions are known for not being able to be used all of
the time for lots of shutdown and cleanup issues, this isn't the first
time it has happened, which is why we are very careful when taking
"cleanup" patches that use those functions.

thanks,

greg k-h
