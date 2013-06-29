From: sukadev@linux.vnet.ibm.com (Sukadev Bhattiprolu)
Date: Fri, 28 Jun 2013 17:09:51 -0700
Subject: [PATCH] perf: ARM: Record the user-mode PC in the call chain.
In-Reply-To: <20130620090728.GA2842@mudshark.cambridge.arm.com>
References: <20130613232111.GA12536@mozilla.com>
 <20130618131319.GC6801@mudshark.cambridge.arm.com>
 <20130620031706.GB27428@mozilla.com>
 <20130620090728.GA2842@mudshark.cambridge.arm.com>
Message-ID: <20130629000951.GA5117@us.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will Deacon [will.deacon at arm.com] wrote:
| On Thu, Jun 20, 2013 at 04:17:06AM +0100, Jed Davis wrote:
| > On Tue, Jun 18, 2013 at 02:13:19PM +0100, Will Deacon wrote:
| > > On Fri, Jun 14, 2013 at 12:21:11AM +0100, Jed Davis wrote:
| > > > With this change, we no longer lose the innermost entry in the user-mode
| > > > part of the call chain.  See also the x86 port, which includes the ip.
| > > > 
| > > > It's possible to partially work around this problem by post-processing
| > > > the data to use the PERF_SAMPLE_IP value, but this works only if the CPU
| > > > wasn't in the kernel when the sample was taken.
| > > 
| > > Thanks. I guess we need something similar for arm64 too. Could you cook a
| > > similar patch please?
| > 
| > Done (and tested, on the ARM V8 Foundation Model).
| 
| Wow, I didn't expect you to test it. Thanks!
| 
| > It looked as if the powerpc and sparc ports might have similar issues,
| > but I haven't checked on them yet.
| 
| I can extract some hardware from the pile in the corner of my flat if you
| want a hand with testing.

Interesting. Powerpc already saves the next_ip for the first entry:

	arch/powerpc/perf/callchain.c:

	perf_callchain_user_64():
	...

		next_ip = perf_instruction_pointer(regs);
		lr = regs->link;
		sp = regs->gpr[1];
		perf_callchain_store(entry, next_ip);

		for (;;) {


Do you have a test case/output that I can run on Power ?

We actually have the opposite problem where we see duplication in
callchains like this. We considered not saving the "link register"
but that seems to break for a "leaf-node" functions.

    13.65%  sprintft  libc-2.12.so       [.] __random                            
            | 
            --- __random
               |           
               |--62.82%-- __random
               |          |    
               |          |--97.31%-- rand
               |          |          do_my_sprintf
               |          |          main
               |          |          generic_start_main
               |          |          __libc_start_main
               |          |          0x0
               |          |
               |           --2.69%-- do_my_sprintf
               |                     main
               |                     generic_start_main
               |                     __libc_start_main
               |                     0x0
               |
                --37.18%-- rand
                          |
                          |--93.30%-- rand
                          |          do_my_sprintf
                          |          main
                          |          generic_start_main
                          |          __libc_start_main
                          |          0x0
                          |
                           --6.70%-- do_my_sprintf
                                     main
                                     generic_start_main
                                     __libc_start_main
                                     0x0
