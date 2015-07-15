From: rostedt@goodmis.org (Steven Rostedt)
Date: Wed, 15 Jul 2015 10:55:36 -0400
Subject: [RFC 2/3] arm64: refactor save_stack_trace()
In-Reply-To: <55A646EE.6030402@linaro.org>
References: <1436765375-7119-1-git-send-email-takahiro.akashi@linaro.org>
 <1436765375-7119-3-git-send-email-takahiro.akashi@linaro.org>
 <DAAB1BC4-B36E-436D-8EAD-548641E58490@gmail.com>
 <20150714093154.4d73e551@gandalf.local.home>
 <55A5A75A.1060401@linaro.org>
 <20150714225105.6c1e4f15@gandalf.local.home>
 <55A646EE.6030402@linaro.org>
Message-ID: <20150715105536.42949ea9@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 15 Jul 2015 20:41:34 +0900
AKASHI Takahiro <takahiro.akashi@linaro.org> wrote:


> Thank you for the explanation. But what I don't really understand here
> is why we need to add the "current function" to the stack dump list
> returned by save_stack_trace():
> 
> In check_stack(),
>  >        /*
>  >         * Add the passed in ip from the function tracer.
>  >         * Searching for this on the stack will skip over
>  >         * most of the overhead from the stack tracer itself.
>  >         */
>  >        stack_dump_trace[0] = ip;
>  >        max_stack_trace.nr_entries++;
> 
> I think that "ip" here is the "return address for func" in your

Ah, you are correct (for fentry).

> ascii art, and it should be already in the list if a frame is made
> by mcount (or func_call).
> 
> In fact, stack tracer on arm64 works OK even without the patch[3/3]
> if the code quoted above is commented out.
> Even on x86, the code is conditional and not activated if the kernel
> is compiled without -mfentry before the following commit:
>      commit 4df297129f62 ("tracing: Remove most or all of stack tracer stack size from stack_max_size")
> 
> So what do I misunderstand here?
> 

Hmm, I haven't touched the stack trace code in a while. With the added
stack frame for fentry, the hacks there are probably not needed.

I'll take a look at it and try to clean up the code.

Thanks,

-- Steve
