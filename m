From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Fri, 11 Apr 2014 11:11:33 -0700
Subject: [RFC PATCH] uprobes: copy to user-space xol page with proper
 cache flushing
In-Reply-To: <20140411.140213.521479030434404328.davem@davemloft.net>
References: <20140411153041.GQ16119@n2100.arm.linux.org.uk>
 <20140411172456.GA20506@redhat.com>
 <CA+55aFx=1O67Wi85g_3qiUzxyxfFU0RZQMkMj4_kOB=2T09jwQ@mail.gmail.com>
 <20140411.140213.521479030434404328.davem@davemloft.net>
Message-ID: <CA+55aFwPR1XLRKiYya5wwxwbdnA_qiB4fZPL0i7+L4mpmzk5qA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 11, 2014 at 11:02 AM, David Miller <davem@davemloft.net> wrote:
>
> It's not enough, we need to have the 'mm' so we can know what cpu's this
> address space has executed upon, and therefore what cpus need the broadcast
> flush.

Ok. But still, it shouldn't need "vma".

> See my other reply, we can just make a __copy_to_user_page() that takes 'mm'
> and a boolean 'executable' which uprobes can unconditionally pass as true.

Sure, that doesn't look disgusting. That said, I thought at least one
architecture (powerpc) did more than just check the executable bit: I
think somebody actually does a page-per-page "has this been mapped
executably" thing because their icache flush is *so* expensive. So
that boolean "executable" bit is potentially architecture-specific.

And quite frankly, using the "vma->vm_flags" sounds potentially
*incorrect* to me, since it really isn't about the vma. If you change
a page through a non-executable vma, you'd want to flush the icache
entry for that page mapped in a totally different vma. So I really get
the feeling that passing in "vma" is actively *wrong*. The vma
interface really makes little to no sense.

Hmm?

            Linus
