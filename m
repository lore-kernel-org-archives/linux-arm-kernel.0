From: rostedt@goodmis.org (Steven Rostedt)
Date: Thu, 13 Mar 2014 14:49:26 -0400
Subject: [PATCH v6 4/7] arm64: Add ftrace support
In-Reply-To: <20140313183705.GK25472@mudshark.cambridge.arm.com>
References: <1393564724-3966-1-git-send-email-takahiro.akashi@linaro.org>
 <1394705630-12384-1-git-send-email-takahiro.akashi@linaro.org>
 <1394705630-12384-5-git-send-email-takahiro.akashi@linaro.org>
 <20140313170834.GE25472@mudshark.cambridge.arm.com>
 <1394735259.26600.14.camel@pippen.local.home>
 <20140313183705.GK25472@mudshark.cambridge.arm.com>
Message-ID: <1394736566.26600.23.camel@pippen.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2014-03-13 at 18:37 +0000, Will Deacon wrote:
>  
> > No, return_hooker is consistent with all the other archs. Hey, it's a
> > rugby position! Note, which I was when I played. ;-)
> 
> Hehe, in which case your children will be able to execute that line of
> ftrace!
> 

My kids already know I was :-)

> > > 
> > > > +       trace.func = self_addr;
> > > 
> > > in kernel/ftrace/ftrace.c there's an smb_wmb() between setting up
> > > tracing_graph_pause and setting the ret_stack with a comment saying:
> > > 
> > >     /* Make sure the tasks see the -1 first: */
> > > 
> > > Why don't we have a corresponding read-barrier here?
> > 
> > The corresponding rmb is in kernel/trace/trace_function_graph
> > ftrace_push_return_trace().
> 
> Okey doke then, I guess we don't really care about tracing_graph_pause
> getting out-of-sync with curr_ret_stack.

Yep, the tracing_graph_pause is more to prevent crazy stuff happening
when an interrupt comes in. So it is just local cpu context, and doesn't
have issues with other CPUS. If it takes a bit for the task to see it go
to zero, the worse thing is that you might miss a few tracing functions
until that gets synced. Which will probably happen by the time tracing
is fully activated anyway.

-- Steve
