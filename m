From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Tue, 27 Sep 2016 10:01:15 -0700
Subject: [PATCH v9 17/19] drm/virtio: kconfig: Fix recursive dependency
 issue.
In-Reply-To: <CACvgo53fuoPVjBAkZbWFPVxosObjvxoDgFdR_BkSTgevqyGg9g@mail.gmail.com>
References: <1473081421-16555-1-git-send-email-peter.griffin@linaro.org>
 <1473081421-16555-18-git-send-email-peter.griffin@linaro.org>
 <CACvgo52_g7anGBd9HTUyYsbp5QmQEk9LR3nNHgSTgjQ29G3ViA@mail.gmail.com>
 <20160920083251.GB26093@griffinp-ThinkPad-X1-Carbon-2nd>
 <CACvgo53fuoPVjBAkZbWFPVxosObjvxoDgFdR_BkSTgevqyGg9g@mail.gmail.com>
Message-ID: <20160927170115.GD7509@tuxbot>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 21 Sep 05:09 PDT 2016, Emil Velikov wrote:

> On 20 September 2016 at 09:32, Peter Griffin <peter.griffin@linaro.org> wrote:
> > Hi Emil,
> >
> > On Tue, 20 Sep 2016, Emil Velikov wrote:
> >
> >> On 5 September 2016 at 14:16, Peter Griffin <peter.griffin@linaro.org> wrote:
> >> > ST_SLIM_REMOTEPROC must select REMOTEPROC, which exposes the following
> >> > recursive dependency.
> >
> >
> >> >
> >> From a humble skim through remoteproc, drm and a few other subsystems
> >> I think the above is wrong. All the drivers (outside of remoteproc),
> >> that I've seen, depend on the core component, they don't select it.
> >
> > I will let Bjorn comment on the remoteproc subsystem Kconfig design, and
> > why it is like it is.
> >
> > For this particular SLIM_RPROC I have added it to Kconfig in keeping with all
> > the other drivers in the remoteproc subsystem which has exposed this recursive
> > dependency issue.
> >
> > For this particular kconfig symbol a quick grep reveals more drivers in
> > the kernel using 'select', than 'depend on'
> >
> > git grep "select VIRTIO" | wc -l
> > 14
> >
> > git grep "depends on VIRTIO" | wc -l
> > 10
> >
> Might be worth taking a closer look into these at some point.
> 

The general idea here is that VIRTIO provides the "framework" and as
such drivers implementing VIRTIO do select and drivers using virtio use
depends.

This is found in several places around the kernel.

> >
> >> Furthermore most places explicitly hide the drivers from the menu if
> >> the core component isn't enabled.
> >
> > Remoteproc subsystem takes a different approach, the core code is only enabled
> > if a driver which relies on it is enabled. This IMHO makes sense, as
> > remoteproc is not widely used (only a few particular ARM SoC's).
> >
> > It is true that for subsystems which rely on the core component being
> > explicitly enabled, they often tend to hide drivers which depend on it
> > from the menu unless it is. This also makes sense.
> >
> >>
> >> Is there something that requires such a different/unusual behaviour in
> >> remoteproc ?
> >>

There's nothing unusual in remoteproc that forces us to stay with this
model; however the parts related to the REMOTEPROC config is useless by
themselves.

Regards,
Bjorn
