From: rostedt@goodmis.org (Steven Rostedt)
Date: Tue, 17 Mar 2015 11:07:50 -0400
Subject: [PATCH v2] ring-buffer: Replace this_cpu_*() with __this_cpu_*()
In-Reply-To: <20150317144701.GJ10068@pengutronix.de>
References: <20150316173154.537b80ee@gandalf.local.home>
 <alpine.DEB.2.11.1503170049300.9309@gentwo.org>
 <20150317081341.0f9a8b4c@gandalf.local.home>
 <20150317101113.32f5618a@gandalf.local.home>
 <20150317104038.312e73d1@gandalf.local.home>
 <20150317144701.GJ10068@pengutronix.de>
Message-ID: <20150317110750.2a0e2b73@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Mar 2015 15:47:01 +0100
Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> wrote:

> Guten Morgen Steven,
> 
> On Tue, Mar 17, 2015 at 10:40:38AM -0400, Steven Rostedt wrote:
> >  static __always_inline void trace_recursive_unlock(void)
> >  {
> > -	unsigned int val = this_cpu_read(current_context);
> > +	unsigned int val = __this_cpu_read(current_context);
> > +	unsigned int val2;
> >  
> > -	val--;
> > -	val &= this_cpu_read(current_context);
> > -	this_cpu_write(current_context, val);
> > +	val2 = val - 1;
> > +	val &= val2;
> > +	__this_cpu_write(current_context, val);
> You could use:
> 
> 	unsigned int val = __this_cpu_read(current_context);
> 
> 	val = val & (val - 1);
> 
> 	__this_cpu_write(current_context, val);
> 
> and save a few lines and still make it more readable (IMHO).

Me too. My version came from looking at too much assembly, and val2
just happened to be another register in my mind.

> 
> BTW, this patch makes the additional lines in the trace disappear, so if
> you think that makes a Tested-by applicable, feel free to add it.

OK, will do. Thanks.

Christoph, you happy with this version?

-- Steve
