From: masami.hiramatsu.pt@hitachi.com (Masami Hiramatsu)
Date: Fri, 20 Feb 2015 12:59:53 +0900
Subject: [RFC PATCH v3 00/26] Early kprobe: enable kprobes at very
 early booting stage.
In-Reply-To: <1423805941-61407-1-git-send-email-wangnan0@huawei.com>
References: <1423805941-61407-1-git-send-email-wangnan0@huawei.com>
Message-ID: <54E6B139.20909@hitachi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Sorry for replying late.

(2015/02/13 14:39), Wang Nan wrote:
> I fell very sorry for people who reviewed my v2 patch series yesterday
> at https://lkml.org/lkml/2015/2/12/234 because I didn't provide enough
> information in commit log. This v3 patch series add those missing
> commit messages. There are also 2 small fix based on v2:
>
>  1. Fixes ftrace_sort_mcount_area. Original patch doesn't work for module.
>  2. Wraps setting of kprobes_initialized in stop_machine() context.

>From the viewpoint of the maintenance, it seems over-engineered and
not general implementation. Please reconsider just initializing breakpoint
handler in earlier stage. Since those exceptions may happen anywhere,
those trap handlers setup very early stage. E.g. on x86, setup_arch()
setup early_trap_init() at beginning. So we just need to initialize
kprobes earlier.
I think this is almost enough for debugging, and very general because
we don't need optprobe for porting to other arch.

And for ftrace-based kprobe, we can just put breakpoint on mcount call at
beginning. ftrace will need to check and keep it when replacing mcount-call
with nop. Afterward, we can cleanly update those kprobes with ftrace-based
kprobe.

So, please start with smaller changes.

Thank you,

-- 
Masami HIRAMATSU
Software Platform Research Dept. Linux Technology Research Center
Hitachi, Ltd., Yokohama Research Laboratory
E-mail: masami.hiramatsu.pt at hitachi.com
