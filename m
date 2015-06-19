From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Sat, 20 Jun 2015 01:20:46 +0200
Subject: [PATCH 02/13] driver-core: defer all probes until late_initcall
In-Reply-To: <CAAObsKDGLVx5wtsiY_o_-r6bp4qTgOfAExbSr7w=xn2eM-CQ6A@mail.gmail.com>
References: <1434548543-22949-1-git-send-email-tomeu.vizoso@collabora.com>
 <2834968.DlsDAmbXkG@vostro.rjw.lan>
 <CAAObsKDGLVx5wtsiY_o_-r6bp4qTgOfAExbSr7w=xn2eM-CQ6A@mail.gmail.com>
Message-ID: <1585940.7Lfuk0LdBK@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, June 19, 2015 03:36:46 PM Tomeu Vizoso wrote:
> On 18 June 2015 at 23:50, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Wednesday, June 17, 2015 03:42:12 PM Tomeu Vizoso wrote:
> >> To decrease the chances of devices deferring their probes because of
> >> dependencies not having probed yet because of their drivers not having
> >> registered yet, delay all probing until the late initcall level.
> >>
> >> This will allow us to avoid deferred probes completely later by probing
> >> dependencies on demand, or by probing them in dependency order.
> >>
> >> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> >> ---
> >>  drivers/base/dd.c | 8 +++++++-
> >>  1 file changed, 7 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> >> index a638bbb..18438aa 100644
> >> --- a/drivers/base/dd.c
> >> +++ b/drivers/base/dd.c
> >> @@ -407,6 +407,12 @@ int driver_probe_device(struct device_driver *drv, struct device *dev)
> >>       if (!device_is_registered(dev))
> >>               return -ENODEV;
> >>
> >> +     /* Defer all probes until we start processing the queue */
> >> +     if (!driver_deferred_probe_enable) {
> >> +             driver_deferred_probe_add(dev);
> >
> > Do I think correctly that this will effectively force everybody to use deferred
> > probing?
> 
> Guess it depends on the meaning of "using deferred probing". It will
> defer the probe of the first device to late_initcall (which will
> happen much earlier in time than before), but afterwards all built-in
> drivers will be available and depending on the order in which we try
> to probe devices, none may actually ask to defer its probe.

So this will break things like the PNP system driver which relies on probing
stuff at the fs_initcall stage for correctness.  It may also break other
things with similar assumptions.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
