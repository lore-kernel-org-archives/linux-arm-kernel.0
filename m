From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Tue, 23 Jun 2015 16:37:11 +0200
Subject: [PATCH 02/13] driver-core: defer all probes until late_initcall
In-Reply-To: <CAL_JsqKTm-F2oajuj07W=DBBjH03FTnqNkGbizERmajCPgjnGg@mail.gmail.com>
References: <1434548543-22949-1-git-send-email-tomeu.vizoso@collabora.com>
 <1585940.7Lfuk0LdBK@vostro.rjw.lan>
 <CAL_JsqKTm-F2oajuj07W=DBBjH03FTnqNkGbizERmajCPgjnGg@mail.gmail.com>
Message-ID: <2342676.6ZCmGB6KsR@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, June 22, 2015 07:07:08 PM Rob Herring wrote:
> On Fri, Jun 19, 2015 at 6:20 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Friday, June 19, 2015 03:36:46 PM Tomeu Vizoso wrote:
> >> On 18 June 2015 at 23:50, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >> > On Wednesday, June 17, 2015 03:42:12 PM Tomeu Vizoso wrote:
> >> >> To decrease the chances of devices deferring their probes because of
> >> >> dependencies not having probed yet because of their drivers not having
> >> >> registered yet, delay all probing until the late initcall level.
> >> >>
> >> >> This will allow us to avoid deferred probes completely later by probing
> >> >> dependencies on demand, or by probing them in dependency order.
> >> >>
> >> >> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> >> >> ---
> >> >>  drivers/base/dd.c | 8 +++++++-
> >> >>  1 file changed, 7 insertions(+), 1 deletion(-)
> >> >>
> >> >> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> >> >> index a638bbb..18438aa 100644
> >> >> --- a/drivers/base/dd.c
> >> >> +++ b/drivers/base/dd.c
> >> >> @@ -407,6 +407,12 @@ int driver_probe_device(struct device_driver *drv, struct device *dev)
> >> >>       if (!device_is_registered(dev))
> >> >>               return -ENODEV;
> >> >>
> >> >> +     /* Defer all probes until we start processing the queue */
> >> >> +     if (!driver_deferred_probe_enable) {
> >> >> +             driver_deferred_probe_add(dev);
> >> >
> >> > Do I think correctly that this will effectively force everybody to use deferred
> >> > probing?
> >>
> >> Guess it depends on the meaning of "using deferred probing". It will
> >> defer the probe of the first device to late_initcall (which will
> >> happen much earlier in time than before), but afterwards all built-in
> >> drivers will be available and depending on the order in which we try
> >> to probe devices, none may actually ask to defer its probe.
> >
> > So this will break things like the PNP system driver which relies on probing
> > stuff at the fs_initcall stage for correctness.  It may also break other
> > things with similar assumptions.
> 
> Yes, but I think that this can be done for only OF based devices
> rather than globally for all platform devices and solve that problem.
> Matching is already dependent of the type of device.

Well, the current patch is not OF-only, though.

Rafael
