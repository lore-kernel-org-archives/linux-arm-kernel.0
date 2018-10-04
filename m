From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 4 Oct 2018 17:48:43 +0200
Subject: [GIT PULL] fixes for soc/fsl drivers for v4.19 take 2
In-Reply-To: <f1847dd8-0cbc-3be6-303f-73e5dac5e5d1@nxp.com>
References: <20181001225827.21946-1-leoyang.li@nxp.com>
 <f1847dd8-0cbc-3be6-303f-73e5dac5e5d1@nxp.com>
Message-ID: <CAK8P3a3t1oKTxPU=7_S4K=_rA=YcOpBUTs9-aHDFAJAwHGyBpw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 4, 2018 at 11:39 AM Laurentiu Tudor <laurentiu.tudor@nxp.com> wrote:
>
> > ----------------------------------------------------------------
> > NXP/FSL SoC driver fixes for v4.19 round 2
> >
> > - Fix crash of qman_portal by deferring its probe if qman is not probed
> >
> > ----------------------------------------------------------------
> > Laurentiu Tudor (2):
> >        soc: fsl: qbman: add APIs to retrieve the probing status
> >        soc: fsl: qman_portals: defer probe after qman's probe
>
> There's a similar fix for bman portals [1]. I was under the impression
> that you plan to pick that up too.
>
> [1] "soc/fsl/bman_portals: defer probe after bman's probe", found here:
> https://lore.kernel.org/patchwork/patch/992009/

I've pulled the first two into the fixes branch for now, but it does sound
like we need the third patch as well.

The new interface seems a bit odd, since it does not pass
an instance pointer at all, but instead relies on the idea that
there is only one qman/bman instance in the system. While this
may be true in all cases, generally our driver interfaces should
be based around device objects instead of making assumptions
like this. I assume that is part of what led to the bug in the first
place.

Of course that is nothing that can be changed easily, and the
bug needs to be fixed, so I have pulled the fixes for 4.19, but
it would be good to see if the interfaces could be restructured
to behave more like other subsystems in the future.

     Arnd
