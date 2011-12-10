From: daniel@ffwll.ch (Daniel Vetter)
Date: Sat, 10 Dec 2011 05:01:59 +0100
Subject: [Linaro-mm-sig] [RFC v2 1/2] dma-buf: Introduce dma buffer
 sharing mechanism
In-Reply-To: <20111209142405.6f371be6@pyramind.ukuu.org.uk>
References: <1322816252-19955-1-git-send-email-sumit.semwal@ti.com>
 <201112071340.35267.arnd@arndb.de>
 <CAKMK7uFQiiUbkU-7c3Os0d0FJNyLbqS2HLPRLy3LGnOoCXV5Pw@mail.gmail.com>
 <201112091413.03736.arnd@arndb.de>
 <20111209142405.6f371be6@pyramind.ukuu.org.uk>
Message-ID: <CAKMK7uH+4uSYYjBLcvfhVC+iwGUZ09Z4p64fNBzh196aG+hqgg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 9, 2011 at 15:24, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>> I still don't think that's possible. Please explain how you expect
>> to change the semantics of the streaming mapping API to allow multiple
>> mappers without having explicit serialization points that are visible
>> to all users. For simplicity, let's assume a cache coherent system

I think I understand the cache flushing issues on arm (we're doing a
similar madness with manually flushing caches for i915 because the gpu
isn't coherent with the cpu and other dma devices). And I also agree
that you cannot make concurrent mappings work without adding something
on top of the current streaming api/dma-buf proposal. I just think
that it's not the kernel's business (well, at least not dma_buf's
business) to enforce that. If userspace (through some driver calls)
tries to do stupid things, it'll just get garbage. See
Message-ID: <CAKMK7uHeXYn-v_8cmpLNWsFY14KtmuRZy8YRKR5Xst2-2WdFSQ@mail.gmail.com>
for my reasons why it think this is the right way to go forward. So in
essence I'm really interested in the reasons why you want the kernel
to enforce this (or I'm completely missing what's the contentious
issue here).

> I would agree. It's not just about barriers but in many cases where you
> have multiple mappings by hardware devices the actual hardware interface
> is specific to the devices. Just take a look at the fencing in TTM and
> the graphics drivers.
>
> Its not something the low level API can deal with, it requires high level
> knowledge.

Yes, we might want to add some form of in-kernel sync objects on top
of dma_buf, but I'm not really convinced that this will buy us much
above simply synchronizing access in userspace with the existing ipc
tools. In my experience the expensive part of syncing two graphics
engines with the cpu is that we wake up the cpu and prevent it from
going into low-power states if we do this too often. Adding some more
overhead by going through userspace doesn't really make it much worse.
It's a completely different story if there's a hw facility to
synchronize engines without the cpu's involvement (like there is on
every multi-pipe gpu) and there sync objects make tons of sense. But
I'm not aware of that existing on SoCs between different IP blocks.

Cheers, Daniel
-- 
Daniel Vetter
daniel.vetter at ffwll.ch - +41 (0) 79 364 57 48 - http://blog.ffwll.ch
