From: Dave.Martin@arm.com (Dave Martin)
Date: Mon, 16 Jan 2017 13:32:31 +0000
Subject: [RFC PATCH 08/10] arm64/sve: ptrace: Wire up vector length
 control and reporting
In-Reply-To: <20170116122038.GG28060@E107787-LIN>
References: <1484220369-23970-1-git-send-email-Dave.Martin@arm.com>
 <1484220369-23970-9-git-send-email-Dave.Martin@arm.com>
 <20170116122038.GG28060@E107787-LIN>
Message-ID: <20170116133231.GO3699@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 16, 2017 at 12:20:38PM +0000, Yao Qi wrote:
> On 17-01-12 11:26:07, Dave Martin wrote:
> > This patch adds support for manipulating a task's vector length at
> > runtime via ptrace.
> > 
> 
> I hope kernel doesn't provide such interface to ptracer to change vector
> length.

It does, with this patch, beacuse...

> The vector length is sort of a read-only property of thread/process/
> program to debugger, unless we really have a clear requirement to modify
> vector length in debugging.  I may miss something because I haven't debug
> SVE code yet.

...the vector length is no longer read-only for the task, thanks to
the new prctls().

This does add complexity, but I figured that any programmer's model
state that the thread can modify for itself should be modifiable by the
debugger, if for no other reason than the user may want to experiment to
see what happens.  Without a ptrace interface, it would be necessary
to inject a prctl() call into the target, which is possible but awkward.

gdb must already re-detect the vector length on stop, since the target
could have called the prctl() in the meantime.

Access via ptrace also allows things like trapping on exec, fork or
clone and changing the vector length for the new process or thread
before it starts to run.  I'm guessing here, but such a scenario seems
legitimate (?)

[...]

Cheers
---Dave
