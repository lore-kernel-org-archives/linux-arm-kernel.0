From: will.deacon@arm.com (Will Deacon)
Date: Wed, 8 Feb 2017 15:06:55 +0000
Subject: [BUGFIX PATCH tip/master 2/3] kprobes/arm64: Fix a possible
 deadlock case in kretprobe
In-Reply-To: <148648038381.30949.1443281264586280005.stgit@devbox>
References: <148648024215.30949.11929183640906306731.stgit@devbox>
 <148648038381.30949.1443281264586280005.stgit@devbox>
Message-ID: <20170208150654.GJ3986@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[adding linux-arm-kernel]

On Wed, Feb 08, 2017 at 12:13:14AM +0900, Masami Hiramatsu wrote:
> Similar to x86 kretprobe deadlock issue, arm64 also implements
> kretprobe-booster (trampoline code directly call handler.)
> So it has same deadlock issue if there are 2 kretprobes on
> normal function and the function called from FIQ (or anywhere
> which can be invoked when local_irq_disabled).

We don't support FIQ on arm64, so I'm not worried about that particular
case. What are the other cases? I can think of debug exceptions, but those
shouldn't be generally kprobe-able, and taking data aborts in things like
get_user/put_user. Are those affected by this bug?

Either way, could you please expand the commit message like you have
for x86? It makes it much easier to understand the change when looking
back at the log in future.

Thanks,

Will
