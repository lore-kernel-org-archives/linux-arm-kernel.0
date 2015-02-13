From: rostedt@goodmis.org (Steven Rostedt)
Date: Fri, 13 Feb 2015 12:15:31 -0500
Subject: [RFC PATCH v3 00/26] Early kprobe: enable kprobes at very early
 booting stage.
In-Reply-To: <1423805907-61335-1-git-send-email-wangnan0@huawei.com>
References: <1423743476-11927-1-git-send-email-wangnan0@huawei.com>
 <1423805907-61335-1-git-send-email-wangnan0@huawei.com>
Message-ID: <20150213121531.6f2aa5cb@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 13 Feb 2015 13:38:27 +0800
Wang Nan <wangnan0@huawei.com> wrote:

> I fell very sorry for people who reviewed my v2 patch series yesterday
> at https://lkml.org/lkml/2015/2/12/234 because I didn't provide enough
> information in commit log. This v3 patch series add those missing
> commit messages. There are also 2 small fix based on v2:

Note the 0/26 patch should contain the summary of what the entire
series is trying to accomplish, and how it is trying to accomplish it.

> 
>  1. Fixes ftrace_sort_mcount_area. Original patch doesn't work for module.
>  2. Wraps setting of kprobes_initialized in stop_machine() context. 
> 

I'll be attending Linux Collaboration Summit next week and there's a
lot of things I need to finish before I leave, and I wont be able to
look at these while at the conference. Which means I can not take a in
depth look at the patches until I get back, and even then I'll be
catching up on other things. Feel free to ping me about this after
Feb 23rd.

>From what I can gather from skimming the patches, you attend to have a
way to pass kprobes via the kernel command line or some other way that
kprobes are pre allocated (called before memory management), and if
they happen to be at an ftrace location, you have hooks to have ftrace
notify kprobes to fix it up.

Honestly, I hate the notifiers. Get rid of them. kprobes and ftrace are
coupled, as kprobes must know about ftrace, and ftrace knows about
kprobes. This is a very specific case. Notifiers represent a "general"
use case, and I don't want something else hooking into these notifiers.
This should be hard coded, and fixed up at ftrace_init(), where after
ftrace_init() everything acts as it does today.

That is, the early kprobes add hooks to the ftrace nop locations. When
ftrace tries to convert them to nops it will notice that they do not
match the call to mcount. In this case, ftrace should call a kprobes
function asking if this is a call to kprobe, and if so, it will convert
this location into a normal call to the ftrace trampoline that calls
the early kprobe function. This will only be done during ftrace_init()
when it tries to convert the calls to mcount or __fentry__ (not
ftrace_caller) to nops. It will then convert it to ftrace_caller, if
need be, or whatever.

Perhaps that would be easier. Before doing the modifications, it could
do a special register of ftrace to have the ftrace_regs_caller point to
the early kprobe function and when its doing the modifications, it will
be aware that there might be some locations that call the early kprobe
function.

Basically what I'm saying is that this is a very special case. Don't
try to over engineer this into something that can be expanded by other
use cases. I rather not make this easy for other use cases to connect
to the ftrace locations at early boot up. That's just opening a can of
worms that are spoiled, and taste like bad sushi from a restaurant with
lots of neon lights.

I'm not against the idea of having early kprobes, but I'm not thrilled
with the current implementation.

-- Steve
