From: mhiramat@kernel.org (Masami Hiramatsu)
Date: Mon, 27 Nov 2017 10:40:34 +0900
Subject: do page fault in atomic bug on arm
In-Reply-To: <08bb4658-5b62-e306-5aa8-366be25986ca@linaro.org>
References: <d83cdbf1-0d27-fb82-14c8-3d37101c3c06@linaro.org>
 <20171121132001.GH31757@n2100.armlinux.org.uk>
 <64cbcda0-d040-4872-4a6b-7cd18375b4aa@linaro.org>
 <20171124192700.GU31757@n2100.armlinux.org.uk>
 <20171124202553.GV31757@n2100.armlinux.org.uk>
 <08bb4658-5b62-e306-5aa8-366be25986ca@linaro.org>
Message-ID: <20171127104034.205fc0b50e9bf9dafdcd05c7@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 26 Nov 2017 22:59:58 +0800
Alex Shi <alex.shi@linaro.org> wrote:

> cc mhiramat at kernel.org
> 
> Thanks a lot for look into this! :)
> 
> Regards
> Alex
> 
> On 11/25/2017 04:25 AM, Russell King - ARM Linux wrote:
> > On Fri, Nov 24, 2017 at 07:27:00PM +0000, Russell King - ARM Linux wrote:
> >> Adding Tixy, as he's more knowledgable in this area - I suggest
> >> someone knowledgable in this area runs
> >>
> >> 	ftracetest test.d/kprobe/multiple_kprobes.tc
> >>
> >> and fixes these bugs... also running the entire ftracetest suite
> >> would probably also be a very good idea.
> > 
> > There's some other stupidities as well:
> > 
> > trace_kprobe: Inserting kprobe at __error_lpae+0
> > trace_kprobe: Inserting kprobe at str_lpae+0
> > trace_kprobe: Inserting kprobe at __error_p+0
> > trace_kprobe: Inserting kprobe at str_p1+0
> > trace_kprobe: Inserting kprobe at str_p2+0
> > trace_kprobe: Could not insert probe at str_p2+0: -22
> > 
> > str_lpae: .asciz "\nError: Kernel with LPAE support, but CPU does not support LPAE.\n"
> > str_p1: .asciz  "\nError: unrecognized/unsupported processor variant (0x"
> > str_p2: .asciz  ").\n"
> > 
> > So we successfully placed a kprobe on some ASCII strings, which are
> > used prior to the kernel being properly up and running, which means
> > we have to use relative references to these strings, and relative
> > references to strings in other sections is not simple.

Oops, that's my mistake. It should pick only text symbols.

> > 
> > More worrying:
> > 
> > trace_kprobe: Inserting kprobe at __turn_mmu_on+0
> > trace_kprobe: Inserting kprobe at __idmap_text_start+0
> > trace_kprobe: Inserting kprobe at __turn_mmu_on_end+0
> > ...
> > trace_kprobe: Inserting kprobe at __idmap_text_end+0
> > ...
> > trace_kprobe: Inserting kprobe at secondary_startup+0
> > trace_kprobe: Inserting kprobe at secondary_startup_arm+0
> > trace_kprobe: Inserting kprobe at __secondary_switched+0
> > trace_kprobe: Inserting kprobe at __secondary_data+0
> > trace_kprobe: Inserting kprobe at __enable_mmu+0
> > trace_kprobe: Inserting kprobe at __do_fixup_smp_on_up+0
> > trace_kprobe: Inserting kprobe at __fixup_a_pv_table+0
> > trace_kprobe: Inserting kprobe at fixup_pv_table+0
> > trace_kprobe: Inserting kprobe at __lookup_processor_type+0
> > trace_kprobe: Inserting kprobe at __lookup_processor_type_data+0
> > 
> > These are definitely a no-no for tracing, because they're part of the
> > early startup code for the kernel when no stacks are available.

It should be rejected by kprobes arch dependent code.

> > Some of these can't live in the special "do not use kprobes here"
> > section as they need to be in other sections (like .idmap) because
> > they need to be part of the identity-mapped code.

kprobes already has a blacklist on x86, so it is a good time to start
making it on arm/arm64 too.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
