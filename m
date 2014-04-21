From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Mon, 21 Apr 2014 09:41:42 -0700
Subject: [RFC PATCH v4] ARM: uprobes xol write directly to userspace
In-Reply-To: <5355446A.9080302@linaro.org>
References: <20140416191825.GA22246@redhat.com>
 <20140416.153734.675854782374654510.davem@davemloft.net>
 <534EE6F2.3050005@linaro.org>
 <20140416.172153.646525167994615191.davem@davemloft.net>
 <20140416222548.GL24070@n2100.arm.linux.org.uk>
 <5355446A.9080302@linaro.org>
Message-ID: <CA+55aFzCwtEbHjFf9E4yqqx8zZDYft5kacDZpg7KWyFWgVH5_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 21, 2014 at 9:16 AM, David Long <dave.long@linaro.org> wrote:
>
> void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
>                         const void *src, int len)
> {
>         void *kaddr = kmap_atomic(page);
>
> #ifdef CONFIG_SMP
>         preempt_disable();
> #endif

That #ifdef seems totally pointless. Make it unconditional, or remove
it entirely (the kmap_atomic() already causes us to be non-preemptible
in practice).

           Linus
