From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Fri, 11 Apr 2014 11:13:43 -0700
Subject: [RFC PATCH] uprobes: copy to user-space xol page with proper
 cache flushing
In-Reply-To: <20140411.140213.521479030434404328.davem@davemloft.net>
References: <20140411153041.GQ16119@n2100.arm.linux.org.uk>
 <20140411172456.GA20506@redhat.com>
 <CA+55aFx=1O67Wi85g_3qiUzxyxfFU0RZQMkMj4_kOB=2T09jwQ@mail.gmail.com>
 <20140411.140213.521479030434404328.davem@davemloft.net>
Message-ID: <CAA3XUr0e71yOX0NurYBog8SxcDVPZ00Xr4SGqNOS4GKMFoYGiQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 April 2014 11:02, David Miller <davem@davemloft.net> wrote:
> From: Linus Torvalds <torvalds@linux-foundation.org>
> Date: Fri, 11 Apr 2014 10:50:31 -0700
>
>> So I really think we should just have a fixed
>> "flush_icache_page(page,vaddr)" function. Maybe add a "len" argument,
>> to allow architectures that have to loop over cachelines to do just a
>> minimal loop.
>
> It's not enough, we need to have the 'mm' so we can know what cpu's this
> address space has executed upon, and therefore what cpus need the broadcast
> flush.

But in uprobes case xol slot where instruction write happened will be
used only by current CPU. The way I read uprobes code other core
when it hit the same uprobe address will use different xol slot. Xol slot
size is cache line so it will not be moved around. So as long as we
know for sure that while tasks performs single step on uprobe xol
area instruction it won't be migrated to another core we don't need to
do broadcast to any other cores.

Thanks,
Victor

> See my other reply, we can just make a __copy_to_user_page() that takes 'mm'
> and a boolean 'executable' which uprobes can unconditionally pass as true.
