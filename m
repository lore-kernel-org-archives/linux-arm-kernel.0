From: davem@davemloft.net (David Miller)
Date: Fri, 11 Apr 2014 14:58:42 -0400 (EDT)
Subject: [RFC PATCH] uprobes: copy to user-space xol page with proper
 cache flushing
In-Reply-To: <CA+55aFwDKOs2XXVCsCi_tCSVTHt93uqzv-0qGEzRW6rCk0h9rw@mail.gmail.com>
References: <CA+55aFwPR1XLRKiYya5wwxwbdnA_qiB4fZPL0i7+L4mpmzk5qA@mail.gmail.com>
 <20140411.141911.2103972187575537634.davem@davemloft.net>
 <CA+55aFwDKOs2XXVCsCi_tCSVTHt93uqzv-0qGEzRW6rCk0h9rw@mail.gmail.com>
Message-ID: <20140411.145842.716571171033099617.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 11 Apr 2014 11:24:58 -0700

> On Fri, Apr 11, 2014 at 11:19 AM, David Miller <davem@davemloft.net> wrote:
>>
>> The vm_flags check is about "could it have gotten into the I-cache
>> via this VMA".
> 
> .. and that's obviously complete bullshit and wrong. Which is my point.
> 
> Now, it's possible that doing things right is just too much work for
> architectures that don't even matter, but dammit, it's still wrong. If
> you change a page, and it's executably mapped into some other vma, the
> icache is possibly stale there. The whole _point_ of our cache
> flushing is to make caches coherent, and anything that uses "vma" to
> do so is *wrong*.
> 
> So your argument makes no sense. You're just re-stating that "it's
> wrong", but you're re-stating it in a way that makes it sounds like it
> could be right.
> 
> The "this page has been mapped executably" approach, in contrast, is
> *correct*. It has a chance in hell of actually making caches coherent.

You're right that using VMA as a hint during ptrace accesses is bogus.
If it's writeable, shared, and executable, we won't do the right thing.

Since we do most of the cache flushing stuff during normal operations
at the PTE modification point, perhaps a piece of page state could be
used to handle this.  We already use such a thing for D-cache alias
flushing.
