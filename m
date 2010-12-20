From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 20 Dec 2010 17:10:20 -0500 (EST)
Subject: [PATCH 1/3] hvc_dcc: Fix bad code generation by marking assembly
	volatile
In-Reply-To: <4D0FD02E.3080901@codeaurora.org>
References: <1292649385-28771-1-git-send-email-sboyd@codeaurora.org>
	<1292875718-7980-1-git-send-email-sboyd@codeaurora.org>
	<1292875718-7980-2-git-send-email-sboyd@codeaurora.org>
	<AANLkTi=8F3keaAQ2o+V8gNncNM02c9k9=DRtd5GyP_LH@mail.gmail.com>
	<4D0FD02E.3080901@codeaurora.org>
Message-ID: <alpine.LFD.2.00.1012201702540.10437@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 20 Dec 2010, Stephen Boyd wrote:

> On 12/20/2010 01:49 PM, Arnaud Lacombe wrote:
> > Hi,
> >
> > On Mon, Dec 20, 2010 at 3:08 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> >> Without marking the asm __dcc_getstatus() volatile my compiler
> >> decides [...]
> > What compiler ? That might be a usefull information to know,
> > espectially 5 years from now when tracing code history. There has been
> > similar issue with gcc 4.5 recently. AFAIK, in the same idea, the
> > final change has been to mark the asm volatile.
> 
> Sure, we can replace "my compiler" with "my compiler (arm-eabi-gcc (GCC)
> 4.4.0)".

Compiler version doesn't matter -- this is a simple correctness issue.

If an inline asm statement provides an output value then the compiler is 
free to cache that value in a register, unless the inline asm is marked 
so that the value may change from one invocation to another.  Also, the 
compiler is free to eliminate the inline asm statement entirely as well 
if the output value provided by that inline asm is never used... unless 
if the inline asm is marked as having side effects.  In both cases the 
volatile qualifier does indicate that the returned value may change 
(new status flag state) and 
that the asm code therein has side effects (e.g. pop a character off a 
FIFO).

Sometimes the desired effect can be indicated by clever usage of 
parameter constraints, but in this case the volatile keyword is most 
appropriate.


Nicolas
