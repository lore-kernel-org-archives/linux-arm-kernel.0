From: will.deacon@arm.com (Will Deacon)
Date: Wed, 18 Jun 2014 13:53:55 +0100
Subject: [PATCH] ARM: perf: allow tracing with kernel tracepoints events
In-Reply-To: <1403025065-18001-1-git-send-email-jean.pihet@linaro.org>
References: <CAFrcx1n-cPXm=w+84gQiUjZoFKi7gYnvJ0BQ+8yXKS=k3nEt3g@mail.gmail.com>
 <1403025065-18001-1-git-send-email-jean.pihet@linaro.org>
Message-ID: <20140618125355.GA2186@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean,

On Tue, Jun 17, 2014 at 06:11:05PM +0100, Jean Pihet wrote:
> When tracing with tracepoints events the IP and CPSR are set to 0,
> preventing the perf code to resolve the symbols:
> 
> ./perf record -e kmem:kmalloc cal
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.007 MB perf.data (~321 samples) ]
> 
> ./perf report
> Overhead Command Shared Object Symbol
> ........ ....... ............. ...........
> 40.78%   cal     [unknown]     [.]00000000
> 31.6%    cal     [unknown]     [.]00000000
> 
> The examination of the gathered samples (perf report -D) shows the IP
> is set to 0 and that the samples are considered as user space samples,
> while the IP should be set from the registers and the samples should be
> considered as kernel samples.
> 
> The fix is to implement perf_arch_fetch_caller_regs for ARM, which
> fills the necessary registers used for the callchain unwinding and
> to determine the user/kernel space property of the samples: ip, sp, fp
> and cpsr.

Surely its only the CPSR that identifies whether it's user or kernel?

> Tested with perf record and tracepoints filtering (-e <tracepoint>), with
> unwinding using fp (--call-graph fp) and dwarf info (--call-graph dwarf).

Whilst the old ACPS unwinding only needs PC, FP and SP, is this definitely
true for exidx and DWARF-based unwinding? Given that libunwind ends up
running a state machine for the latter, can we guarantee that we won't hit
instructions that require access to other general purpose registers?

Will
