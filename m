From: dave.martin@linaro.org (Dave Martin)
Date: Mon, 20 Jun 2011 11:56:05 +0100
Subject: [RFC PATCH v2 1/5] ARM: mm: Add generic proc/arch struct
	definition macros
In-Reply-To: <alpine.LFD.2.00.1106192311080.2142@xanadu.home>
References: <1308049105-16080-1-git-send-email-dave.martin@linaro.org>
	<1308049105-16080-2-git-send-email-dave.martin@linaro.org>
	<alpine.LFD.2.00.1106151944240.2142@xanadu.home>
	<20110616100328.GA2460@arm.com>
	<alpine.LFD.2.00.1106192311080.2142@xanadu.home>
Message-ID: <20110620105605.GA2067@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 19, 2011 at 11:13:46PM -0400, Nicolas Pitre wrote:
> On Thu, 16 Jun 2011, Dave Martin wrote:
> 
> > Alternatively, we could propose a change <linux/init.h> to split the
> > __INITDATA macro up, and define the related macros in a sane way:
> > 
> > #define __INITDATA_NAME .init.data
> > #define __INITDATA_FLAGS "aw",%progbtis
> > #define __initdata __section(__INITDATA_NAME)
> > #define __INITDATA .section __stringify(__INITDATA_NAME),__INITDATA_FLAGS
> > 
> > Any thoughts on that?
> 
> I do like it.

I think that all this data (the cache, tlb and processor funcs tables, and
the name strings) should theoretically go in __INITRODATA, since it is not
written and is only referenced via .proc.info.init so is not findable after
init data has been discarded anyway.  This data is all copied by setup.c
during startup, AFAICT.

However, the current section assignment situation is somewhat
inconsistent.

 * processor_functions, cache_fns: __INITDATA (writable)
 * tlb_fns: various (tlb-v3.S has __INITDATA; tlb-v7.S has __INIT)
 * name strings: .rodata (not initdata)


I don't really understand how this stuff interacts with CPU hotplug however;
maybe this stuff should all be in __CPUINITRODATA instead.


Since I will likely patch all the proc-*.S and cache-*.S files, I will
try to avoid any potential breakage in the initial series; so I'll keep
the section directives out of the macros so that we can prove in an
automated way that there is zero change the generated binaries.

This still brings much of the benefits.

Moving the section directives in the macros could possibly occur as a
separate follow-up.

Cheers
---Dave
