From: abelvesa@gmail.com (Abel Vesa)
Date: Tue, 24 Jan 2017 00:43:19 +0000
Subject: [PATCH] arm: ftrace: Adds support for
 CONFIG_DYNAMIC_FTRACE_WITH_REGS
In-Reply-To: <CACh+v5MsC8_qOMYdm1qpduEPVmRG+mgCDibVEfyc3Pzk06V1Eg@mail.gmail.com>
References: <1481233595-22112-1-git-send-email-abelvesa@linux.com>
 <20161208224655.GA6319@gce> <20170110155112.GB14894@pathway.suse.cz>
 <20170112001957.GA5458@nuc>
 <CACh+v5M-BDru3OyhrROBqPKJuSN=yoxVstN-fqZGh8SU1EHQiw@mail.gmail.com>
 <CACh+v5MsC8_qOMYdm1qpduEPVmRG+mgCDibVEfyc3Pzk06V1Eg@mail.gmail.com>
Message-ID: <CAEZQSseKMRnkxEQt4dLSUQfxRk00hJOOe8puA9esVX9JNt_KWg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean-Jacques,

Here is the implementation I've made for ftrace_graph_regs_caller:

.macro __ftrace_graph_regs_caller

       sub     r0, fp, #4                          @ lr of
instrumented routine (parent)

       @ called from __ftrace_regs_caller
       ldr     r1, [sp, #56]                       @ instrumented routine (func)
       mcount_adjust_addr      r1, r1

       sub     r2, r0, #4                          @ frame pointer
       bl      prepare_ftrace_return

       ldr     lr, [sp, #64]                        @ restore lr from the stack
       ldmia   sp, {r0-r11, ip, sp}            @ restore r0 through sp
       ret     ip

.endm

AFAIK, you can still use fp (see the implementation without regs) since
it is an alternative name for r11. The FRAME_POINTER config options does
something else entirely and has nothing to do with what we need here.

I tested it but unfortunately, my current setup is with qemu and I don't have
a real hardware here close to test it properly. Could you please tell me if this
works on your setup?

Also the way I tested it was to comment out the code that uses the default
ftrace_graph_caller in ftrace_modify_graph_caller and enforced the usage of
the one with regs.

I will create a proper patch later today (I need to cleanup some stuff
first) and
send it.

Thanks,
Abel
