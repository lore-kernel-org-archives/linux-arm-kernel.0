From: will.deacon@arm.com (Will Deacon)
Date: Tue, 10 Nov 2015 10:05:48 +0000
Subject: [PATCH] arm64: add HAVE_LATENCYTOP_SUPPORT config
In-Reply-To: <20151110074124.GB6672@osiris>
References: <1446825478-24824-1-git-send-email-yalin.wang2010@gmail.com>
 <20151106160501.GR6087@arm.com>
 <247F438B-3EEA-4550-970E-A649D0E604ED@gmail.com>
 <20151106162109.GT6087@arm.com> <20151110074124.GB6672@osiris>
Message-ID: <20151110100547.GC31947@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

On Tue, Nov 10, 2015 at 08:41:24AM +0100, Heiko Carstens wrote:
> On Fri, Nov 06, 2015 at 04:21:10PM +0000, Will Deacon wrote:
> > On Sat, Nov 07, 2015 at 12:11:16AM +0800, yalin wang wrote:
> > > i just enable it on ARM64,
> > > and it can work,
> > > i don?t see some special requirement to enable this config .
> > 
> > Right, so why does HAVE_LATENCYTOP_SUPPORT exist?
> 
> If I remember correctly then the only dependency was that an architecture
> must have implemented save_stack_trace_tsk().
> See git commit a3afe70b83fdbbd4d757d2911900d168bc798a31.

Thanks for the pointer.

> So the name of HAVE_LATENCYTOP_SUPPORT is surely a not well chosen, and I
> think I introduced it back then. Oh, well.
> 
> And looking through the kernel there is at least avr32 which would break
> at build time if the config option would be removed completely.
> 
> So.. renaming it to STACKTRACE_TSK_SUPPORT would be a good idea.

ftrace has a similar issue and solves it by having architectures define
a `config STACKTRACE_SUPPORT' symbol. Over in kernel/trace/Kconfig,
there's a `select STACKTRACE if STACKTRACE_SUPPORT', which means
that kernel/stacktrace.c gets built and a dummy (weak symbol) version of
save_stack_trace_tsk appears.

I don't think adding another STACKTRACE-related Kconfig option is
necessarily the best thing to do. Maybe we should instead have LATENCYTOP
depend on STACKTRACE_SUPPORT (already the case) and select STACKTRACE?

Will
