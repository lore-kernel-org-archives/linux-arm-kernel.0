From: oleg@redhat.com (Oleg Nesterov)
Date: Tue, 15 Apr 2014 18:26:27 +0200
Subject: [RFC PATCH] uprobes: copy to user-space xol page with proper
 cache flushing
In-Reply-To: <CAA3XUr0SBczZSKui-qOivJKGtOe8_rB8HX4rSX24VYvLXm5yvw@mail.gmail.com>
References: <5347655B.3080307@linaro.org>
 <20140411.003636.272212797007496394.davem@davemloft.net>
 <20140411145625.GA27493@redhat.com> <20140411152207.GA28188@redhat.com>
 <20140411153041.GQ16119@n2100.arm.linux.org.uk>
 <20140411172456.GA20506@redhat.com>
 <CA+55aFx=1O67Wi85g_3qiUzxyxfFU0RZQMkMj4_kOB=2T09jwQ@mail.gmail.com>
 <20140414185916.GA30672@redhat.com>
 <CAA3XUr3BGA55JF_cgH=cqbo1wAK0773P1fvnG9dBjLU2KzBdKA@mail.gmail.com>
 <CAA3XUr0SBczZSKui-qOivJKGtOe8_rB8HX4rSX24VYvLXm5yvw@mail.gmail.com>
Message-ID: <20140415162627.GB3560@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/14, Victor Kamensky wrote:
>
> Oleg's fix - Oleg's fix proposed on [1]. Basically it uses
> copy_to_user_page and it does dynamic look-up of xol area vma
> every tracing

I guess I was not clear. No, I didn't really try to propose this change,
I do not like it ;)

I showed this hack in reply to multiple and persistent requests to reuse
the ptrace solution we already have.

> my arm specific fix - this one was proposed on as [2].

I didn't even try to read the changes in arm/, I can't understand them
anyway. I leave this to you and Russel.

But, once again, please do not add arch_uprobe_flush_xol_access(), add
arch_uprobe_copy_ixol().

> x) fix that I did for ARM that shares ARM code with
> copy_to_user_page but does not need vma performs best.

The patch which adds copy_to_user_page(vma => NULL) into copy_to_page() ?
Please see the comments in my previous email.

> When I looked at current uprobes single step out line code
> and compared it with code that was in the past (utrace
> times) I noticed main essential difference how xol slots
> are handled: Currently for each hit uprobes code allocate
> xol slot and needs dcache/icache flush. But in the past
> xol slot was attached/cached to uprobe entry

Can't comment, I am not familiar with the old implementation.

But yes, the current implementation is not perfect. Once again, it would
be nice to remove this vma. Even if this is not possible, we can try to
share this memory. We do not even need lru, we can make it "per cpu" and
avoid the broadcasts. On x86 this is simple, we have __switch_to_xtra()
which can re-copy ->ixol[] and do flush_icache_range() if UTASK_SSTEP.
Not sure this is possible on arm and other arch'es. But lets not discuss
this right now, this is a bit off-topic currently.

Oleg.
