From: rostedt@goodmis.org (Steven Rostedt)
Date: Tue, 17 Mar 2015 08:13:41 -0400
Subject: [RFC][PATCH] ring-buffer: Replace this_cpu_{read,write} with
 this_cpu_ptr()
In-Reply-To: <alpine.DEB.2.11.1503170049300.9309@gentwo.org>
References: <20150316173154.537b80ee@gandalf.local.home>
 <alpine.DEB.2.11.1503170049300.9309@gentwo.org>
Message-ID: <20150317081341.0f9a8b4c@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Mar 2015 00:56:51 -0500 (CDT)
Christoph Lameter <cl@linux.com> wrote:

> On Mon, 16 Mar 2015, Steven Rostedt wrote:
> 
> > It has come to my attention that this_cpu_read/write are horrible on
> > architectures other than x86. Worse yet, they actually disable
> > preemption or interrupts! This caused some unexpected tracing results
> > on ARM.
> 
> Well its just been 7 years or so. Took a long time it seems.

The code that I added was not 7 years old. And not all people send me
reports like this.

> 
> These would need to be implemented on the architectures to
> have comparable performance.
> 
> > I may go and remove all this_cpu_read,write() calls from my code
> > because of this.
> 
> You could do that with __this_cpo_* but not this_cpu_*(). Doing
> it to this_cpu_* would make the operations no longer per cpu atomic. If
> they do not need per cpu atomicity then you could have used __this_cpu_*
> instead. And  __this_cpu_* do not disable preemption or interrupts.

I do not need it to be atomic.

> 
> So please do not send patches based on gut reactions.

What else would you like me to do? It was an RFC, and it worked.

> 
> NAK

For this particular patch, I may override the NAK as I do not see a
downside for it. Why should x86 get an advantage at the expense of ARM?

-- Steve
