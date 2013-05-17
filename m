From: ming.lei@canonical.com (Ming Lei)
Date: Fri, 17 May 2013 10:16:40 +0800
Subject: [Bug] ARM 'perf' regression by commit a43cb95d5
Message-ID: <CACVXFVPjo2dQpYPpqZS8GC8UPNzB5HLURpYm6-g1FOBbSUjDyA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The commit a43cb95d5(dump_stack: unify debug information printed by show_regs())
caused ARM perf regression, then 'perf top' outputs mistakenly, see
[1].  The correct
output should be [2], which can be got after reverting the commit or
doing it partly
by the one line change below:

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index f219703..89bc3a4 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -225,7 +225,7 @@ void __show_regs(struct pt_regs *regs)
        unsigned long flags;
        char buf[64];

-       show_regs_print_info(KERN_DEFAULT);
+       //show_regs_print_info(KERN_DEFAULT);


Looks a bit weird, anyone can give a hint?


Thanks,
--
Ming Lei

[1], 'perf top' mistaken output
Samples: 17K of event 'cpu-clock', Event count (approx.): 3516532661
 97.51%  [smsc95xx]            [k] 0x013645b8
  0.21%  libc-2.15.so          [.] strstr
  0.14%  libc-2.15.so          [.] strchr
  0.12%  libc-2.15.so          [.] strcmp
  0.12%  perf                  [.] perf_evsel__parse_sample
  0.09%  perf                  [.] symbols__insert
  0.09%  perf                  [.] dso__load_sym
  0.08%  perf                  [.] perf_top__mmap_read_idx
  0.08%  perf                  [.] symbol_filter
  0.07%  libc-2.15.so          [.] memchr
  0.07%  libc-2.15.so          [.] memset
  0.07%  perf                  [.] internal_cplus_demangle
  0.06%  perf                  [.] sort__dso_cmp
  0.06%  libc-2.15.so          [.] strncmp
  0.06%  perf                  [.] add_hist_entry.isra.2
  0.06%  perf                  [.] dso__find_symbol
  0.06%  libc-2.15.so          [.] _int_malloc
  0.05%  perf                  [.] 0x00010d60
  0.04%  libc-2.15.so          [.] memcpy
  0.04%  perf                  [.] map__find_symbol
  0.04%  perf                  [.] rb_next
  0.04%  libelf-0.154.so       [.] gelf_getsym


[2], 'perf top' correct output
Samples: 46K of event 'cpu-clock', Event count (approx.): 937128704
 96.44%  [kernel]            [k] cpuidle_enter_state
  0.19%  libc-2.15.so        [.] strstr
  0.16%  [kernel]            [k] kallsyms_expand_symbol.clone.0
  0.13%  [kernel]            [k] _raw_spin_unlock_irq
  0.13%  [kernel]            [k] _raw_spin_unlock_irqrestore
  0.10%  [kernel]            [k] format_decode
  0.10%  perf                [.] perf_top__mmap_read_idx
  0.10%  perf                [.] rb_next
  0.09%  perf                [.] dso__find_symbol
  0.08%  [kernel]            [k] vsnprintf
  0.08%  perf                [.] add_hist_entry.isra.2
  0.08%  libc-2.15.so        [.] strcmp
  0.08%  libc-2.15.so        [.] memchr
  0.07%  perf                [.] sort__dso_cmp
  0.07%  libc-2.15.so        [.] strchr
  0.07%  [kernel]            [k] number.clone.1
  0.07%  perf                [.] map__process_kallsym_symbol
  0.06%  [kernel]            [k] memcpy
  0.05%  perf                [.] perf_evsel__parse_sample
  0.05%  libc-2.15.so        [.] _int_malloc
  0.05%  libc-2.15.so        [.] memcpy
  0.05%  perf                [.] perf_event__preprocess_sample
