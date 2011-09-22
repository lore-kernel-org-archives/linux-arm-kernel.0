From: jon.medhurst@linaro.org (Jon Medhurst (Tixy))
Date: Thu, 22 Sep 2011 12:06:46 +0100
Subject: [PATCH] arm: Add unwinding annotations for 64bit division
	functions
In-Reply-To: <CAHkRjk7B4Bmt2g6ptHO3TudXgrkr5rv4b--Hbx-mw7=MO9Q+BQ@mail.gmail.com>
References: <1316470297-5063-1-git-send-email-lauraa@codeaurora.org>
	<alpine.LFD.2.00.1109191913210.12663@xanadu.home>
	<2285dff3fee56758b6279062a5a30dc7.squirrel@www.codeaurora.org>
	<20110921113906.GB2872@arm.com>
	<20110921115553.GF17169@n2100.arm.linux.org.uk>
	<1316676488.2053.9.camel@linaro1>
	<CAHkRjk7B4Bmt2g6ptHO3TudXgrkr5rv4b--Hbx-mw7=MO9Q+BQ@mail.gmail.com>
Message-ID: <1316689606.2053.29.camel@linaro1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-09-22 at 10:48 +0100, Catalin Marinas wrote:
> On 22 September 2011 08:28, Jon Medhurst (Tixy) <jon.medhurst@linaro.org> wrote:
> > On Wed, 2011-09-21 at 12:55 +0100, Russell King - ARM Linux wrote:
> >> Instructions such as VFP, kprobes tracing, etc are expected fault
> >> locations, and those are fairly well controlled where they can be placed.
> >> With things like ftrace, it certainly is the case that the unwinder can
> >> theoretically be called from almost anywhere in a function.
> >
> > Actually, kprobes can be places on any instruction in the kernel that
> > isn't in the section .kprobes.text.
> >
> > I also strongly suspect that stack unwinding won't happen correctly
> > across the boundary between the kprobes handling code and the function
> > which was probed - there's an awful lot of stack jiggery pokery going on
> > there.
> 
> Are people most likely to place kprobes on the first instruction of a
> function? 

I believe that is the usual case.

> We could improve things a bit in the unwinder and assume
> that if the fault address is the same as the .fnstart address, the
> return value is always in LR and the SP not affected (that's unwinding
> bytecode 0xb0). For a few instructions into the function prologue we
> can't reliably get the unwinding information.

That would help make it possible to unwind out of kprobes handlers to
the probed function. The kprobes code itself would need work as well,
and possibly the undef handler. Do we think it is worthwhile to do
this? 

-- 
Tixy
