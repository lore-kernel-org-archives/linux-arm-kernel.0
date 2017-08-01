From: acme@kernel.org (Arnaldo Carvalho de Melo)
Date: Tue, 1 Aug 2017 13:44:46 -0300
Subject: [PATCH v1] perf: cs-etm: Fix ETMv4 CONFIGR entry in perf.data file
In-Reply-To: <CANLsYkzTyjmVYA+mYCp-6P9WjCMjEH4gcm_Ua2gKN04bWTz2CQ@mail.gmail.com>
References: <1499878883-3066-1-git-send-email-mike.leach@linaro.org>
 <CANLsYkxDLVONpuQpF6Zo-gUPf+WVt2v+DLNduq0mDMk0XAZ5hw@mail.gmail.com>
 <20170721161916.GH4134@kernel.org>
 <20170721183533.GP4134@kernel.org>
 <20170721183740.GQ4134@kernel.org>
 <20170721191103.GR4134@kernel.org>
 <CANLsYkx0AW0R21m04rE987bDtYmsd=r_w2ipWyPLs=StENhEiw@mail.gmail.com>
 <CANLsYkzTyjmVYA+mYCp-6P9WjCMjEH4gcm_Ua2gKN04bWTz2CQ@mail.gmail.com>
Message-ID: <20170801164446.GE12201@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Em Tue, Aug 01, 2017 at 10:17:56AM -0600, Mathieu Poirier escreveu:
> On 24 July 2017 at 13:37, Mathieu Poirier <mathieu.poirier@linaro.org> wrote:
> > On 21 July 2017 at 13:11, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >> Em Fri, Jul 21, 2017 at 03:37:40PM -0300, Arnaldo Carvalho de Melo escreveu:
> >>> Em Fri, Jul 21, 2017 at 03:35:33PM -0300, Arnaldo Carvalho de Melo escreveu:
> >>> > Em Fri, Jul 21, 2017 at 01:19:16PM -0300, Arnaldo Carvalho de Melo escreveu:
> >>> > > Em Fri, Jul 21, 2017 at 08:50:09AM -0600, Mathieu Poirier escreveu:
> >>> > > > On 12 July 2017 at 11:01, Mike Leach <mike.leach@linaro.org> wrote:
> >>> > > > > The value passed into the perf.data file for the CONFIGR register in ETMv4
> >>> > > > > was incorrectly being set to the command line options/ETMv3 value.
> >>> > > > >
> >>> > > > >                 info->priv[*offset + CS_ETMV4_TRCTRACEIDR] =
> >>> > > > >                                                 coresight_get_trace_id(cpu);
> >>> > > >
> >>> > > > I have tested this patch on my side and things work as advertised now.
> >>> > > >
> >>> > > > Arnaldo, if you want to pick this up through your tree then:
> >>> > > >
> >>> > > > Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> >>> > > >
> >>> > > > Otherwise I'll get this, whatever you prefer.
> >>> > >
> >>> > > I'll get it, thanks for the ping,
> >>> >
> >>> > It is breaking the build in one of my containers, one with fedora 24 and
> >>> > a android toolchain from http://dl.google.com/android/repository/android-ndk-r12b-linux-x86_64.zip
> >>> >
> >>> > arch/arm/util/cs-etm.c: In function 'cs_etmv4_get_config':^M
> >>> > arch/arm/util/cs-etm.c:289:24: error: 'ETM_OPT_RETSTK' undeclared (first use in this function)^M
> >>> >   if (config_opts & BIT(ETM_OPT_RETSTK))
> >>> >
> >>> > It builds as
> >>> >
> >>> > NDK=/opt/android-ndk-r12b/
> >>> > NDK_TOOLCHAIN=${NDK}/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64/bin/arm-linux-androideabi-
> >>> > NDK_SYSROOT=${NDK}/platforms/android-24/arch-arm
> >>> > make -C /git/linux/tools/perf O=/tmp/build/perf WERROR=0 CFLAGS=${CFLAGS} ARCH=arm CROSS_COMPILE=${NDK_TOOLCHAIN} EXTRA_CFLAGS="-pie --sysroot=${NDK_SYSROOT}"
> >>> > Ideas?
> >>>
> >>> Ok, it also fails on:
> >>>
> >>>   14 debian:experimental-x-arm64: FAIL
> >>
> >> Ok, we need a definition for ETM_OPT_RETSTK, just like we have for the
> >> other two...
> >>
> >> Nuked it from my perf/core branch, please resubmit.
> >
> > Symbol ETM_OPT_RETSTK was added as part of another patch [1] that is
> > already in my CoreSight tree.  Do you mind if we make this one go
> > through my tree then?
> 
> I haven't heard back from this so I'll assume you want me to take the patch.

Yeah, I should've replied to you, but since this depends on stuff only
in your tree, going thru that is sensible :-)

Ack.

- Arnaldo
