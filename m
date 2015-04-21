From: masami.hiramatsu.pt@hitachi.com (Masami Hiramatsu)
Date: Tue, 21 Apr 2015 20:42:09 +0900
Subject: [PATCH v6 0/6] arm64: Add kernel probes (kprobes) support
In-Reply-To: <1429561187-3661-1-git-send-email-dave.long@linaro.org>
References: <1429561187-3661-1-git-send-email-dave.long@linaro.org>
Message-ID: <55363791.4070706@hitachi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(2015/04/21 5:19), David Long wrote:
> From: "David A. Long" <dave.long@linaro.org>
> 
> This patchset is heavily based on Sandeepa Prabhu's ARM v8 kprobes patches,
> first seen in October 2013. This version attempts to address concerns raised by
> reviewers and also fixes problems discovered during testing.
> 
> This patchset adds support for kernel probes(kprobes), jump probes(jprobes)
> and return probes(kretprobes) support for ARM64.
> 
> The kprobes mechanism makes use of software breakpoint and single stepping
> support available in the ARM v8 kernel.
> 
[...]
> Changes since v5 include:
> 
> 1) Replaced installation of breakpoint hook with direct call from the
> handlers in debug-monitors.c, as requested.
> 2) Reject probing of instructions that read the interrupt mask, in
> addition to instructions that set it.
> 3) Cleaned up comments describing usage of Debug Mask.
> 4) Added KPROBE_REENTER case in reenter_kprobe.
> 5) Corrected the ifdef'd definitions for notify_page_fault() to be
> consistent when KPROBES is not configed.
> 6) Changed "cpsr" to "pstate" for HAVE_REGS_AND_STACK_ACCESS_API feature.
> 7) Added back in missing new files in previous patch.
> 8) Changed two instances of pr_warning() to pr_warn().

Looks OK to me:)
BTW, have you tried to build and test this with CONFIG_KPROBE_EVENT?
If so, you can also test it by tools/testing/selftests/ftrace/ftracetest.

> Note that there seems to be at least a potential issue with kprobes
> on multiple (possibly all) platforms having to do with use of kfree
> inside of the kretprobes trampoline handler.  This has manifested
> occasionally in systemtap testing on arm64.  There does not appear to
> be an simple solution to the problem.

No, trampoline handler must call recycle_rp_inst() instead of kfree
to return kretprobe instance to the pool. Hmm, I should look into it.

Thank you,

-- 
Masami HIRAMATSU
Linux Technology Research Center, System Productivity Research Dept.
Center for Technology Innovation - Systems Engineering
Hitachi, Ltd., Research & Development Group
E-mail: masami.hiramatsu.pt at hitachi.com
