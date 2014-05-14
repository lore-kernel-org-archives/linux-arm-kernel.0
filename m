From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 14 May 2014 16:33:46 +0200
Subject: [PATCH v4 7/8] ARM: Exynos: switch to using generic cpufreq-cpu0
 driver
In-Reply-To: <CAL_JsqL0Yi=SjAm0BtS_2SO2xg8kOaLsydo9m6qcZgb+Pcpa8Q@mail.gmail.com>
References: <1400029876-5830-1-git-send-email-thomas.ab@samsung.com>
 <61090198.zodNL4xIig@wuerfel>
 <CAL_JsqL0Yi=SjAm0BtS_2SO2xg8kOaLsydo9m6qcZgb+Pcpa8Q@mail.gmail.com>
Message-ID: <11343238.VgTHVsC3iv@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 14 May 2014 08:45:23 Rob Herring wrote:
> On Wed, May 14, 2014 at 8:18 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Wednesday 14 May 2014 18:44:46 Viresh Kumar wrote:
> >> On 14 May 2014 18:41, Heiko St?bner <heiko@sntech.de> wrote:
> >> > Am Mittwoch, 14. Mai 2014, 18:35:29 schrieb Viresh Kumar:
> >> >> On 14 May 2014 18:20, Arnd Bergmann <arnd@arndb.de> wrote:
> >> >> > Could we please come up with a way to probe this from DT in the
> >> >> > cpufreq-cpu0 driver itself, so we don't have to add a device in every
> >> >> > platform using it?
> >>
> >> >> Its followed that way because DT Maintainers had strong objections
> >> >> to creating virtual device nodes and haven't allowed creation of nodes
> >> >> for cpufreq drivers.. For which there is no physical device, as CPU already
> >> >> has a separate node..
> >> >
> >> > as we already have the "enable-method" property for enabling/disabling cpus,
> >> > would something like a "scaling-method" be feasible?
> >
> > Good idea to put it as a property into the CPU node.
> 
> We already have properties which indicate this driver can be used by a
> platform: opp table and a clock for the cpu. If this information is
> not sufficient to determine whether you can use this driver or not,
> then you simply need to match against the platform. Perhaps the match
> list should be a blacklist rather than a whitelist, so new platforms
> work without a kernel change.

We'd not only need a blacklist, but also a way to tell whether we
want to use the cpu0 or the big/little implementation, which currently
have indistinguishable bindings.

> Alternatively, create a new OPP binding that addresses this and all
> the other limitations in the current OPP binding.

Yes.

> >> Lets see what DT maintainers have to say on this, I would rather go for a
> >> more straight forward name: "scaling-driver"  ..
> >
> > Both sound fine to me.
> 
> The fact that linux needs a way to create a platform device to enable
> a certain driver is not a DT problem. I proposed a solution for how to
> get this out of the platform code [1], but evidently we want people to
> open code the exceptions and adding boilerplate helpers will just
> encourage the exceptions.

I think the only benefit we have from using platform devices at all
for cpufreq (not for cpuidle, which has a similar problem) is module
autoloading. I think your patch doesn't actually help with that.

	Arnd
