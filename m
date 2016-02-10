From: juri.lelli@arm.com (Juri Lelli)
Date: Wed, 10 Feb 2016 14:25:24 +0000
Subject: [PATCH v3 2/6] drivers/cpufreq: implement
 init_cpu_capacity_default()
In-Reply-To: <56BA0BCA.6090903@arm.com>
References: <CAKfTPtDGk5BC25WqHdhDYDOBgUsuidAMhrXS=eDi6wJPZjfrwA@mail.gmail.com>
 <20160204093559.GA14099@e105550-lin.cambridge.arm.com>
 <CAKfTPtB4G3bP5N0hU6zWXJTddO34x3RnyGpp-4_otc8O=Wq2hw@mail.gmail.com>
 <20160204121620.GB29586@e106622-lin>
 <CAKfTPtDVasamRtG2kLxP0HsohmVQTPrXRgx36e+jb3gozDoo6g@mail.gmail.com>
 <20160204141345.GD29586@e106622-lin>
 <CAKfTPtDWP-AgqXsSuxCfVj33dh+i7oqDTkL=gUy7n-AB1anoow@mail.gmail.com>
 <CAKfTPtD4jTmUZoShGBm3oAFywizjp8jsEukmkeZU+x+zk-KZRA@mail.gmail.com>
 <20160205093040.GG29586@e106622-lin> <56BA0BCA.6090903@arm.com>
Message-ID: <20160210142524.GE11415@e106622-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/02/16 15:54, Dietmar Eggemann wrote:
> On 05/02/16 09:30, Juri Lelli wrote:
> > On 04/02/16 16:46, Vincent Guittot wrote:
> >> On 4 February 2016 at 16:44, Vincent Guittot <vincent.guittot@linaro.org> wrote:
> >>> On 4 February 2016 at 15:13, Juri Lelli <juri.lelli@arm.com> wrote:
> >>>> On 04/02/16 13:35, Vincent Guittot wrote:
> >>>>> On 4 February 2016 at 13:16, Juri Lelli <juri.lelli@arm.com> wrote:
> >>>>>> Hi Vincent,
> >>>>>>
> >>>>>> On 04/02/16 13:03, Vincent Guittot wrote:
> >>>>>>> On 4 February 2016 at 10:36, Morten Rasmussen <morten.rasmussen@arm.com> wrote:
> >>>>>>>> On Wed, Feb 03, 2016 at 10:04:37PM +0100, Vincent Guittot wrote:
> >>>>>>>>> On 3 February 2016 at 12:59, Juri Lelli <juri.lelli@arm.com> wrote:
> 
> [...]
> 
> >>>
> >>> AFAICT, They don't have a dedicated cpufreq driver.
> >>>
> >>> More generally speaking, it can take time before having
> >>
> >> email sent before the ne d of the sentence ...
> >>
> >> More generally speaking, it can take time before having a cpufreq
> >> driver whereas we want to run and test scheduler behavior of these
> >> heterogenous platform
> >>
> > 
> > I'm not familiar with this platform, but from what you are saying and
> > what I could find online, it looks like full Linux support is not
> > finished yet. Can we consider that as still in development? And if we
> > can do that, maybe is fair enough that we use the sysfs interface to
> > play with that platform until support is complete.
> > 
> > Do others have any opinion on this point?
> 
> IMHO, the solution should work for all of heterogeneous systems, (a) w/
> cpufreq and driver, (b) w/ cpufreq and no driver loaded (yet) or (c) w/o
> cpufreq.
> 
> That means that you can't put the benchmarking only into
> cpufreq_register_driver() and rely on cpufreq policy topology.
> 
> Maybe you could do this for (b) and (c) inside an initcall and use
> topology_core_cpumask() to figure out which cpu to profile?
> 
> This would then happen w/ the cpu frequency set by the fw.
> 
> But this then has to be synchronized somehow with the benchmarking
> approach in cpufreq_register_driver().
> 

Yes, I guess the tricky situation is the mixed one, when we might have
the benchmarking executing in a late_initcall when cpufreq kicks in. Or
we can also end up doing the benchmarking twice if cpufreq finishes
initialization after the late_initcall has been executed.

I'm not sure how this can be solved in a clean way. Ideally we would
start benchmarking in the late_initcall (at the frequency set by fw) and
then bailout if cpufreq kicks in. That should work also for the cpufreq
driver as a module case. But, we could do the same thing twice if the
late_initcall is faster or gets executed before cpufreq starts to be
initialized.

Any suggestion anyone? :)

Best,

- Juri
