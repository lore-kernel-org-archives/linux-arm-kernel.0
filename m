From: will.deacon@arm.com (Will Deacon)
Date: Thu, 3 Dec 2015 15:09:26 +0000
Subject: [PATCH] arm64: ftrace: stop using kstop_machine to
 enable/disable tracing
In-Reply-To: <20151203100525.70cc40de@gandalf.local.home>
References: <1448697009-17211-1-git-send-email-huawei.libin@huawei.com>
 <20151202123654.GC4523@arm.com> <56600992.4040005@huawei.com>
 <20151203093821.GD7023@arm.com>
 <20151203100525.70cc40de@gandalf.local.home>
Message-ID: <20151203150926.GG11337@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 03, 2015 at 10:05:25AM -0500, Steven Rostedt wrote:
> On Thu, 3 Dec 2015 09:38:21 +0000
> Will Deacon <will.deacon@arm.com> wrote:
> > I think you're missing the case where the instruction changes under our
> > feet after we've read it but before we've replaced it (e.g. due to module
> > unloading). I think that's why ftrace_modify_code has the comment about
> > lack of locking thanks to stop_machine.
> 
> Note, ftrace has a module notifier that is called when a module is
> being unloaded and before the text goes away. This code grabs the
> ftrace_lock mutex and removes the module functions from the ftrace
> list, such that it will no longer do any modifications to that module's
> text.
> 
> The update to make functions be traced is done under the ftrace_lock
> mutex as well.
> 
> You do not need to worry about module text disappearing from
> underneath you while you do your modifications.

Good.

> Now, if there's comments that suggest otherwise, they need to be
> updated.

Yeah, I think the comments on x86 and arm64 are out of date. They also
mention the freeing of __init sections -- is that still a concern?

Will
