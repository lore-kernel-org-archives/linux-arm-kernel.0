From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Thu, 05 Mar 2015 12:29:57 +0000
Subject: [PATCH 4.0-rc1 v17 5/6] x86/nmi: Use common printk functions
In-Reply-To: <20150305005424.GA21715@gmail.com>
References: <1422022952-31552-1-git-send-email-daniel.thompson@linaro.org>
 <1425463974-23568-1-git-send-email-daniel.thompson@linaro.org>
 <1425463974-23568-6-git-send-email-daniel.thompson@linaro.org>
 <20150305005424.GA21715@gmail.com>
Message-ID: <1425558597.2769.53.camel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-03-05 at 01:54 +0100, Ingo Molnar wrote:
> * Daniel Thompson <daniel.thompson@linaro.org> wrote:
> 
> > Much of the code sitting in arch/x86/kernel/apic/hw_nmi.c to support 
> > safe all-cpu backtracing from NMI has been copied to printk.c to 
> > make it accessible to other architectures.
> > 
> > Port the x86 NMI backtrace to the generic code.
> 
> Is there any difference between the generic and the x86 code as they 
> stand today?

Shouldn't be any user observable change but there are some changes,
mostly due to review comments.

1. The seq_buf structures are initialized at boot and *after* they
   are consumed (originally they were initialized just before use).

2. The generic code doesn't maintain an equivalent of backtrace_mask
   (which was essentially a copy of cpus_online made when backtracing
   was requested) and instead iterates using for_each_possible_cpu()
   to initialize and dump the seq_buf:s.


Daniel.


PS
The main piece that git code motion tracking should follow if I squashed
the generic and x86 patches together would be nmi_vprintk(). I suspect
most of the rest would be missed as the code copies is in pretty small
fragments.
