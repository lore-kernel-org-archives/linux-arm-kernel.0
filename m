From: rostedt@goodmis.org (Steven Rostedt)
Date: Thu, 16 Jul 2015 23:21:28 -0400
Subject: [RFC 2/3] arm64: refactor save_stack_trace()
In-Reply-To: <55A86D50.9060407@linaro.org>
References: <1436765375-7119-1-git-send-email-takahiro.akashi@linaro.org>
 <1436765375-7119-3-git-send-email-takahiro.akashi@linaro.org>
 <DAAB1BC4-B36E-436D-8EAD-548641E58490@gmail.com>
 <20150714093154.4d73e551@gandalf.local.home>
 <55A5A75A.1060401@linaro.org>
 <20150714225105.6c1e4f15@gandalf.local.home>
 <55A646EE.6030402@linaro.org>
 <20150715105536.42949ea9@gandalf.local.home>
 <20150715121337.3b31aa84@gandalf.local.home>
 <55A6FA82.9000901@linaro.org> <55A703F3.8050203@linaro.org>
 <A601CC3C-4B09-4D8B-8564-558349D45815@gmail.com>
 <20150716102405.2cc8c406@gandalf.local.home>
 <12F47692-3010-4886-B87D-3D7820609177@gmail.com>
 <20150716113115.45a17f17@gandalf.local.home>
 <5176E676-1AAA-4F2B-827B-BEF3A2620D86@gmail.com>
 <20150716162255.0beedc76@gandalf.local.home>
 <55A86D50.9060407@linaro.org>
Message-ID: <20150716232128.1a887a9f@grimm.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 17 Jul 2015 11:49:52 +0900
AKASHI Takahiro <takahiro.akashi@linaro.org> wrote:

> > -
> > -	if (using_ftrace_ops_list_func())
> > -		max_stack_trace.skip = 4;
> > -	else
> > -		max_stack_trace.skip = 3;
> > +	max_stack_trace.skip = 3;
> 
> I don't think this last line is necessary because we will skip all
> the functions anyway below:

I put this back more as an optimization as it is already known that it
takes at least three calls to get to this point. Unless of course gcc
decides to inline them. But currently I don't see that.

> 
> >   	save_stack_trace(&max_stack_trace);
> >
> > -	/*
> > -	 * Add the passed in ip from the function tracer.
> > -	 * Searching for this on the stack will skip over
> > -	 * most of the overhead from the stack tracer itself.
> > -	 */
> > -	stack_dump_trace[0] = ip;
> > -	max_stack_trace.nr_entries++;
> > +	/* Skip over the overhead of the stack tracer itself */
> > +	for (i = 0; i < max_stack_trace.nr_entries; i++) {
> > +		if (stack_dump_trace[i] == ip)
> > +			break;
> > +	}
> 
> here. Now "i" indicates the start point, excepting tracer functions,
> and "x" will eventually represent the exact number of functions
> that we are interested in after searching the stack.
> 
> To calc "stack_max_size" correctly, we should change the line:
>      if (unlikely(tracer_frame) && i == 1) {
> to
>      if (unlikely(tracer_frame)) {

Good catch, I'll fix that!

-- Steve

> 
> With these two changes applied, the issues Jungseok mentioned will be
> fixed.
> 
