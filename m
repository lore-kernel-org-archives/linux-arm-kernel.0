From: rostedt@goodmis.org (Steven Rostedt)
Date: Thu, 3 Dec 2015 10:05:25 -0500
Subject: [PATCH] arm64: ftrace: stop using kstop_machine to
 enable/disable tracing
In-Reply-To: <20151203093821.GD7023@arm.com>
References: <1448697009-17211-1-git-send-email-huawei.libin@huawei.com>
 <20151202123654.GC4523@arm.com> <56600992.4040005@huawei.com>
 <20151203093821.GD7023@arm.com>
Message-ID: <20151203100525.70cc40de@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 3 Dec 2015 09:38:21 +0000
Will Deacon <will.deacon@arm.com> wrote:


> I think you're missing the case where the instruction changes under our
> feet after we've read it but before we've replaced it (e.g. due to module
> unloading). I think that's why ftrace_modify_code has the comment about
> lack of locking thanks to stop_machine.

Note, ftrace has a module notifier that is called when a module is
being unloaded and before the text goes away. This code grabs the
ftrace_lock mutex and removes the module functions from the ftrace
list, such that it will no longer do any modifications to that module's
text.

The update to make functions be traced is done under the ftrace_lock
mutex as well.

You do not need to worry about module text disappearing from
underneath you while you do your modifications.

Now, if there's comments that suggest otherwise, they need to be
updated.

-- Steve
 
