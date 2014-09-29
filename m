From: will.deacon@arm.com (Will Deacon)
Date: Mon, 29 Sep 2014 10:03:13 +0100
Subject: [PATCH] ARM: fix set_tls for !CONFIG_KUSER_HELPERS
In-Reply-To: <CAGhQ9VzRRAj76VU19DoBZNP4HAKrEoTNmXEswkUtL00gjSyqCQ@mail.gmail.com>
References: <1411775208-14280-1-git-send-email-nathan_lynch@mentor.com>
 <CAGhQ9VzRRAj76VU19DoBZNP4HAKrEoTNmXEswkUtL00gjSyqCQ@mail.gmail.com>
Message-ID: <20140929090313.GA20303@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 27, 2014 at 11:30:26AM +0100, Joachim Eastwood wrote:
> On 27 September 2014 01:46, Nathan Lynch <nathan_lynch@mentor.com> wrote:
> > Joachim Eastwood reports that commit fbfb872f5f41 "ARM: 8148/1: flush
> > TLS and thumbee register state during exec" causes a boot-time crash
> > on a Cortex-M4 nommu system:
> >
> > Freeing unused kernel memory: 68K (281e5000 - 281f6000)
> > Unhandled exception: IPSR = 00000005 LR = fffffff1
> > CPU: 0 PID: 1 Comm: swapper Not tainted 3.17.0-rc6-00313-gd2205fa30aa7 #191
> > task: 29834000 ti: 29832000 task.ti: 29832000
> > PC is at flush_thread+0x2e/0x40
> > LR is at flush_thread+0x21/0x40
> > pc : [<2800954a>] lr : [<2800953d>] psr: 4100000b
> > sp : 29833d60 ip : 00000000 fp : 00000001
> > r10: 00003cf8 r9 : 29b1f000 r8 : 00000000
> > r7 : 29b0bc00 r6 : 29834000 r5 : 29832000 r4 : 29832000
> > r3 : ffff0ff0 r2 : 29832000 r1 : 00000000 r0 : 282121f0
> > xPSR: 4100000b
> > CPU: 0 PID: 1 Comm: swapper Not tainted 3.17.0-rc6-00313-gd2205fa30aa7 #191
> > [<2800afa5>] (unwind_backtrace) from [<2800a327>] (show_stack+0xb/0xc)
> > [<2800a327>] (show_stack) from [<2800a963>] (__invalid_entry+0x4b/0x4c)
> >
> > The problem is that set_tls is attempting to clear the TLS location in
> > the kernel-user helper page, which isn't set up on V7M.
> >
> > Fix this by guarding the write to the kuser helper page with
> > a CONFIG_KUSER_HELPERS ifdef.
> >
> > Reported-by: Joachim Eastwood <manabian@gmail.com>
> > Fixes: fbfb872f5f41 ARM: 8148/1: flush TLS and thumbee register state during exec
> > Cc: stable at vger.kernel.org
> > Signed-off-by: Nathan Lynch <nathan_lynch@mentor.com>
> > ---
> 
> Works for me.
> 
> Tested-by: Joachim Eastwood <manabian@gmail.com>

Out of interest, which M4 board are you using to run Linux? Are they
generally available?

Will
