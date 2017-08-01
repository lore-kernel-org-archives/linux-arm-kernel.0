From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 1 Aug 2017 10:17:56 -0600
Subject: [PATCH v1] perf: cs-etm: Fix ETMv4 CONFIGR entry in perf.data file
In-Reply-To: <CANLsYkx0AW0R21m04rE987bDtYmsd=r_w2ipWyPLs=StENhEiw@mail.gmail.com>
References: <1499878883-3066-1-git-send-email-mike.leach@linaro.org>
 <CANLsYkxDLVONpuQpF6Zo-gUPf+WVt2v+DLNduq0mDMk0XAZ5hw@mail.gmail.com>
 <20170721161916.GH4134@kernel.org> <20170721183533.GP4134@kernel.org>
 <20170721183740.GQ4134@kernel.org> <20170721191103.GR4134@kernel.org>
 <CANLsYkx0AW0R21m04rE987bDtYmsd=r_w2ipWyPLs=StENhEiw@mail.gmail.com>
Message-ID: <CANLsYkzTyjmVYA+mYCp-6P9WjCMjEH4gcm_Ua2gKN04bWTz2CQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 July 2017 at 13:37, Mathieu Poirier <mathieu.poirier@linaro.org> wrote:
> On 21 July 2017 at 13:11, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>> Em Fri, Jul 21, 2017 at 03:37:40PM -0300, Arnaldo Carvalho de Melo escreveu:
>>> Em Fri, Jul 21, 2017 at 03:35:33PM -0300, Arnaldo Carvalho de Melo escreveu:
>>> > Em Fri, Jul 21, 2017 at 01:19:16PM -0300, Arnaldo Carvalho de Melo escreveu:
>>> > > Em Fri, Jul 21, 2017 at 08:50:09AM -0600, Mathieu Poirier escreveu:
>>> > > > On 12 July 2017 at 11:01, Mike Leach <mike.leach@linaro.org> wrote:
>>> > > > > The value passed into the perf.data file for the CONFIGR register in ETMv4
>>> > > > > was incorrectly being set to the command line options/ETMv3 value.
>>> > > > >
>>> > > > >                 info->priv[*offset + CS_ETMV4_TRCTRACEIDR] =
>>> > > > >                                                 coresight_get_trace_id(cpu);
>>> > > >
>>> > > > I have tested this patch on my side and things work as advertised now.
>>> > > >
>>> > > > Arnaldo, if you want to pick this up through your tree then:
>>> > > >
>>> > > > Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>>> > > >
>>> > > > Otherwise I'll get this, whatever you prefer.
>>> > >
>>> > > I'll get it, thanks for the ping,
>>> >
>>> > It is breaking the build in one of my containers, one with fedora 24 and
>>> > a android toolchain from http://dl.google.com/android/repository/android-ndk-r12b-linux-x86_64.zip
>>> >
>>> > arch/arm/util/cs-etm.c: In function 'cs_etmv4_get_config':^M
>>> > arch/arm/util/cs-etm.c:289:24: error: 'ETM_OPT_RETSTK' undeclared (first use in this function)^M
>>> >   if (config_opts & BIT(ETM_OPT_RETSTK))
>>> >
>>> > It builds as
>>> >
>>> > NDK=/opt/android-ndk-r12b/
>>> > NDK_TOOLCHAIN=${NDK}/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64/bin/arm-linux-androideabi-
>>> > NDK_SYSROOT=${NDK}/platforms/android-24/arch-arm
>>> > make -C /git/linux/tools/perf O=/tmp/build/perf WERROR=0 CFLAGS=${CFLAGS} ARCH=arm CROSS_COMPILE=${NDK_TOOLCHAIN} EXTRA_CFLAGS="-pie --sysroot=${NDK_SYSROOT}"
>>> > Ideas?
>>>
>>> Ok, it also fails on:
>>>
>>>   14 debian:experimental-x-arm64: FAIL
>>
>> Ok, we need a definition for ETM_OPT_RETSTK, just like we have for the
>> other two...
>>
>> Nuked it from my perf/core branch, please resubmit.
>
> Symbol ETM_OPT_RETSTK was added as part of another patch [1] that is
> already in my CoreSight tree.  Do you mind if we make this one go
> through my tree then?

I haven't heard back from this so I'll assume you want me to take the patch.

>
> Thanks,
> Mathieu
>
> [1]. https://www.spinics.net/lists/arm-kernel/msg593008.html
>
>> - Arnaldo
>>
>>>
>>> Same problem:
>>>
>>>   CC       /tmp/build/perf/arch/arm64/util/../../arm/util/cs-etm.o
>>>   CC       /tmp/build/perf/util/config.o
>>> arch/arm64/util/../../arm/util/cs-etm.c: In function 'cs_etmv4_get_config':
>>> arch/arm64/util/../../arm/util/cs-etm.c:289:24: error: 'ETM_OPT_RETSTK' undeclared (first use in this function)
>>>   if (config_opts & BIT(ETM_OPT_RETSTK))
>>>                         ^
>>> arch/arm64/util/../../arm/util/cs-etm.c:270:25: note: in definition of macro 'BIT'
>>>  #define BIT(N) (1UL << (N))
>>>                          ^
>>> arch/arm64/util/../../arm/util/cs-etm.c:289:24: note: each undeclared identifier is reported only once for each function it appears in
>>>   if (config_opts & BIT(ETM_OPT_RETSTK))
>>>                         ^
>>> arch/arm64/util/../../arm/util/cs-etm.c:270:25: note: in definition of macro 'BIT'
>>>  #define BIT(N) (1UL << (N))
>>>                          ^
>>> mv: cannot stat '/tmp/build/perf/arch/arm64/util/../../arm/util/.cs-etm.o.tmp': No such file or directory
>>> /git/linux/tools/build/Makefile.build:101: recipe for target '/tmp/build/perf/arch/arm64/util/../../arm/util/cs-etm.o' failed
>>> make[6]: *** [/tmp/build/perf/arch/arm64/util/../../arm/util/cs-etm.o] Error 1
>>> /git/linux/tools/build/Makefile.build:144: recipe for target 'util' failed
>>> make[5]: *** [util] Error 2
>>> /git/linux/tools/build/Makefile.build:144: recipe for target 'arm64' failed
>>> make[4]: *** [arm64] Error 2
>>> /git/linux/tools/build/Makefile.build:144: recipe for target 'arch' failed
>>> make[3]: *** [arch] Error 2
>>> make[3]: *** Waiting for unfinished jobs....
>>>   CC       /tmp/build/perf/util/ctype.o
>>>
>>> Builds with:
>>>
>>> ARCH=arm64
>>> TARGET=aarch64-linux-gnu
>>> make ARCH=${ARCH} CROSS_COMPILE=${TARGET}- -C /git/linux/tools/perf O=/tmp/build/perf
>>>
>>> - Arnaldo
