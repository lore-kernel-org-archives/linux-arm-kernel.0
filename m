From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 8 Jul 2014 16:19:24 +0100
Subject: [PATCH v7] ARM: EXYNOS: Use MCPM call-backs to support S2R on
 Exynos5420
In-Reply-To: <CAM4voam18g76JKoaEFJnYLEzexxPpSBYjByhg+2aSfANQ2venA@mail.gmail.com>
References: <1404496024-7113-1-git-send-email-a.kesavan@samsung.com>
 <1404503133-19760-1-git-send-email-a.kesavan@samsung.com>
 <alpine.LFD.2.11.1407041659330.22282@knanqh.ubzr>
 <CAM4voa=13pvayq2d1Om9U5gCd6Nqf-T8OvuAQ6cbeerGK1fgrg@mail.gmail.com>
 <20140708105351.GA24915@e102568-lin.cambridge.arm.com>
 <CAM4voam18g76JKoaEFJnYLEzexxPpSBYjByhg+2aSfANQ2venA@mail.gmail.com>
Message-ID: <20140708151924.GF24915@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 08, 2014 at 02:39:37PM +0100, Abhilash Kesavan wrote:
> Hi Lorenzo,
> 
> On Tue, Jul 8, 2014 at 4:23 PM, Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
> > On Fri, Jul 04, 2014 at 10:21:56PM +0100, Abhilash Kesavan wrote:
> >> On Sat, Jul 5, 2014 at 2:30 AM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> >> > On Sat, 5 Jul 2014, Abhilash Kesavan wrote:
> >> >
> >> >> Use the MCPM layer to handle core suspend/resume on Exynos5420.
> >> >> Also, restore the entry address setup code post-resume.
> >> >>
> >> >> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> >> >
> >> > Acked-by: Nicolas Pitre <nico@linaro.org>
> >> This is one of the last missing bits for exynos MCPM. Thanks for your
> >> patient reviews of all the exynos mcpm back-end patches.
> >
> > Sorry for the delay in getting back to you.
> Thanks for your comments.
> >
> > You still need to handle the residency parameter in the MCPM suspend call
> > properly to differentiate between core gating and cluster gating.
> I am not too familiar with the cpuidle driver, but I see only cluster
> power off state listed in the bL cpuidle driver.
> >
> > CPUidle might want to request a state that allows for core gating
> > residency but not cluster gating one, in that case the last man
> > standing must not shutdown the cluster.
> For this, I would have to add another state to the bL cpuidle driver
> or migrate to using your under-review generic idle state patchset.
> Then based on the residency value skip/do cluster power down. Is this
> correct ?
> >
> > This must be handled in the power down function, and it can be done
> > in a separate patch since it is an optimization. Current MCPM interface has
> > all it is needed to handle this properly, and I am keen on patching the
> > CPUidle bL driver to pass the actual residency instead of hardcoding it
> > to 0 (ie on TC2 it was not needed, no core gating).
> I will look at doing this once the s2r patch gets merged.

Ok, let's get it done once the CPUidle bL driver DT version gets merged,
I will add a patch that passes the proper residency and you can patch
the MCPM back-end then, until then CPUidle will be suboptimal but I
guess we can live with that for now.

Thanks,
Lorenzo
