From: acme@kernel.org (Arnaldo Carvalho de Melo)
Date: Fri, 21 Jul 2017 15:35:33 -0300
Subject: [PATCH v1] perf: cs-etm: Fix ETMv4 CONFIGR entry in perf.data file
In-Reply-To: <20170721161916.GH4134@kernel.org>
References: <1499878883-3066-1-git-send-email-mike.leach@linaro.org>
 <CANLsYkxDLVONpuQpF6Zo-gUPf+WVt2v+DLNduq0mDMk0XAZ5hw@mail.gmail.com>
 <20170721161916.GH4134@kernel.org>
Message-ID: <20170721183533.GP4134@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Em Fri, Jul 21, 2017 at 01:19:16PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Jul 21, 2017 at 08:50:09AM -0600, Mathieu Poirier escreveu:
> > On 12 July 2017 at 11:01, Mike Leach <mike.leach@linaro.org> wrote:
> > > The value passed into the perf.data file for the CONFIGR register in ETMv4
> > > was incorrectly being set to the command line options/ETMv3 value.
> > >
> > >                 info->priv[*offset + CS_ETMV4_TRCTRACEIDR] =
> > >                                                 coresight_get_trace_id(cpu);
> > 
> > I have tested this patch on my side and things work as advertised now.
> > 
> > Arnaldo, if you want to pick this up through your tree then:
> > 
> > Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > 
> > Otherwise I'll get this, whatever you prefer.
> 
> I'll get it, thanks for the ping,

It is breaking the build in one of my containers, one with fedora 24 and
a android toolchain from http://dl.google.com/android/repository/android-ndk-r12b-linux-x86_64.zip

arch/arm/util/cs-etm.c: In function 'cs_etmv4_get_config':^M
arch/arm/util/cs-etm.c:289:24: error: 'ETM_OPT_RETSTK' undeclared (first use in this function)^M
  if (config_opts & BIT(ETM_OPT_RETSTK))

It builds as

NDK=/opt/android-ndk-r12b/
NDK_TOOLCHAIN=${NDK}/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64/bin/arm-linux-androideabi-
NDK_SYSROOT=${NDK}/platforms/android-24/arch-arm
make -C /git/linux/tools/perf O=/tmp/build/perf WERROR=0 CFLAGS=${CFLAGS} ARCH=arm CROSS_COMPILE=${NDK_TOOLCHAIN} EXTRA_CFLAGS="-pie --sysroot=${NDK_SYSROOT}" 
Ideas?

- Arnaldo
