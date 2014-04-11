From: davem@davemloft.net (David Miller)
Date: Fri, 11 Apr 2014 14:02:13 -0400 (EDT)
Subject: [RFC PATCH] uprobes: copy to user-space xol page with proper
 cache flushing
In-Reply-To: <CA+55aFx=1O67Wi85g_3qiUzxyxfFU0RZQMkMj4_kOB=2T09jwQ@mail.gmail.com>
References: <20140411153041.GQ16119@n2100.arm.linux.org.uk>
 <20140411172456.GA20506@redhat.com>
 <CA+55aFx=1O67Wi85g_3qiUzxyxfFU0RZQMkMj4_kOB=2T09jwQ@mail.gmail.com>
Message-ID: <20140411.140213.521479030434404328.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 11 Apr 2014 10:50:31 -0700

> So I really think we should just have a fixed
> "flush_icache_page(page,vaddr)" function. Maybe add a "len" argument,
> to allow architectures that have to loop over cachelines to do just a
> minimal loop.

It's not enough, we need to have the 'mm' so we can know what cpu's this
address space has executed upon, and therefore what cpus need the broadcast
flush.

See my other reply, we can just make a __copy_to_user_page() that takes 'mm'
and a boolean 'executable' which uprobes can unconditionally pass as true.
