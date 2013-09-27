From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Fri, 27 Sep 2013 08:58:59 -0700
Subject: [PATCH 1/2] ARM: zynq: cpuidle: Remove useless compatibility
 string
In-Reply-To: <5245471F.6040707@xilinx.com>
References: <1380269867-18336-1-git-send-email-daniel.lezcano@linaro.org>
 <31f13d14-2af7-4285-8770-3cc7ef7e7b09@AM1EHSMHS008.ehs.local>
 <52454342.80706@linaro.org> <5245471F.6040707@xilinx.com>
Message-ID: <43fa0b3d-019f-4438-899d-0adaf730591a@DB9EHSMHS030.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 27, 2013 at 10:51:43AM +0200, Michal Simek wrote:
> On 09/27/2013 10:35 AM, Daniel Lezcano wrote:
> > On 09/27/2013 10:19 AM, Michal Simek wrote:
> >> On 09/27/2013 10:17 AM, Daniel Lezcano wrote:
> >>> All zynq platforms have this compatibility string and there is no any other
> >>> clone.
> >>>
> >>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > 
> > The patchset is only compile-tested (I don't have the hardware).
> > 
> > Michal or someone else, if you have the time can you give it a try ?
> > 
> 
> Soren: Can you please retest it on hw?
Hmm, I'm not subscribed to LAKML (only LKML), but well found the series on
patchworks.

The series introduces new build warnings:
WARNING: drivers/cpuidle/built-in.o(.data+0x28c): Section mismatch in reference from the variable zynq_cpuidle_driver to the function .init.text:zynq_cpuidle_probe()
The variable zynq_cpuidle_driver references
the function __init zynq_cpuidle_probe()
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the variable:
*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console

  CC      kernel/trace/trace.o
  LD      drivers/built-in.o
WARNING: drivers/built-in.o(.data+0x13870): Section mismatch in reference from the variable zynq_cpuidle_driver to the function .init.text:zynq_cpuidle_probe()
The variable zynq_cpuidle_driver references
the function __init zynq_cpuidle_probe()
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the variable:
*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console

  LD      kernel/trace/built-in.o
  LD      kernel/built-in.o
  LINK    vmlinux
  LD      vmlinux.o
  MODPOST vmlinux.o
WARNING: vmlinux.o(.data+0x2e0b0): Section mismatch in reference from the variable zynq_cpuidle_driver to the function .init.text:zynq_cpuidle_probe()
The variable zynq_cpuidle_driver references
the function __init zynq_cpuidle_probe()
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the variable:
*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console


Other than that it looks good. I assume there is just some __init
annotation missing somewhere. Feel free to add my 'Tested-by'.

	S?ren
