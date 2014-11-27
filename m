From: edubezval@gmail.com (Eduardo Valentin)
Date: Thu, 27 Nov 2014 10:08:06 -0400
Subject: [PATCH 1/1] thermal: cpu_cooling: check for the readiness of
 cpufreq layer
In-Reply-To: <CAKohponxUWVT1mjRfJarNtj-+=rXNOa_ONHUjmdu_+6N+=ZjPQ@mail.gmail.com>
References: <1417024212-1775-1-git-send-email-edubezval@gmail.com>
 <CAKohponxUWVT1mjRfJarNtj-+=rXNOa_ONHUjmdu_+6N+=ZjPQ@mail.gmail.com>
Message-ID: <20141127140803.GA3342@developer>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hello Viresh,

On Thu, Nov 27, 2014 at 09:38:39AM +0530, Viresh Kumar wrote:
> Few nits..
> 
> On 26 November 2014 at 23:20, Eduardo Valentin <edubezval@gmail.com> wrote:
> 
> > Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
> > ---
> 
> The normal practice is to write the non-commitable part here ...
> 

err... normal practice by whom? hehe...

My "normal" practice is to allow people to read the diff stat before my
extra comments :-)

> >  drivers/thermal/cpu_cooling.c                      | 5 +++++
> >  drivers/thermal/db8500_cpufreq_cooling.c           | 5 -----
> >  drivers/thermal/imx_thermal.c                      | 5 -----
> >  drivers/thermal/samsung/exynos_thermal_common.c    | 2 +-
> >  drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 6 ------
> >  5 files changed, 6 insertions(+), 17 deletions(-)
> > ---
> 
> But this works as well :)
> 

hehe ok.

> > This is attempt to organize the cpu cooling vs. cpufreq boot sequencing.
> > The main change in this patch, as in the commit log, is to have the check
> > for the cpufreq layer in the cpu cooling device registration, instead of
> > in thermal drivers. This way, drivers don't need to bother about it, they
> > just need to propagate the error value.
> >
> > This change was tested on top of:
> > (0) - Viresh's change in cpufreq layer and cpufreq-dt (up to patch 4):
> > https://patchwork.kernel.org/patch/5384141/
> > https://patchwork.kernel.org/patch/5384151/
> > https://patchwork.kernel.org/patch/5384161/
> > https://patchwork.kernel.org/patch/5384171/
> > (1) - fix of thermal core:
> > https://patchwork.kernel.org/patch/5326991/
> >
> > After Viresh's changes, cpufreq-dt is properly sequenced with cpu cooling
> > registration. Non-of based drivers also should take advantage if these
> > changes, as now they do not need to check for cpufreq layer. The check is
> > where it belongs, in cpu cooling device registration.
> >
> > BR, Eduardo Valentin
> >
> >
> > diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> > index 1ab0018..9e6945b 100644
> > --- a/drivers/thermal/cpu_cooling.c
> > +++ b/drivers/thermal/cpu_cooling.c
> > @@ -440,6 +440,11 @@ __cpufreq_cooling_register(struct device_node *np,
> >         int ret = 0, i;
> >         struct cpufreq_policy policy;
> >
> > +       if (!cpufreq_get_current_driver() || !cpufreq_frequency_get_table(0)) {
> 
> Only !cpufreq_frequency_get_table(0) is enough here.
> 

Yeah, I thought of it too. Just combined what people had in their
drivers here. But I agree that latter is enough.

> For rest:
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Ok.

though.. "normal practice" says  ack's are oftern used by the maintainer
of the affected code (quoting Documentation/SubmittingPatches) :-)
BR, Eduardo Valenti
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141127/8e88e19b/attachment.sig>
