From: rostedt@goodmis.org (Steven Rostedt)
Date: Thu, 3 Dec 2015 10:31:39 -0500
Subject: [PATCH] arm64: ftrace: stop using kstop_machine to
 enable/disable tracing
In-Reply-To: <20151203150926.GG11337@arm.com>
References: <1448697009-17211-1-git-send-email-huawei.libin@huawei.com>
 <20151202123654.GC4523@arm.com> <56600992.4040005@huawei.com>
 <20151203093821.GD7023@arm.com>
 <20151203100525.70cc40de@gandalf.local.home>
 <20151203150926.GG11337@arm.com>
Message-ID: <20151203103139.35648cc2@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 3 Dec 2015 15:09:26 +0000
Will Deacon <will.deacon@arm.com> wrote:

> Yeah, I think the comments on x86 and arm64 are out of date. They also
> mention the freeing of __init sections -- is that still a concern?

No we black list them, any section that we are not sure will be there
when we expect it to has recordmcount.c nop out the calls to mcount and
they are ignored. Remember the e1000e bug? This was the reproducer.

Anyway, on my todo list is to allow init sections to be traced. To do
so would mean that I need to add generic code that lets ftrace know to
remove init sections at boot up. Right now (or at least the last time I
checked, which was back in 2009), every arch had its own way of freeing
init memory. If that has changed, or I can just place a hook where it
happens (which is probably the easy part), I can allow init code to be
traced too.

-- Steve
