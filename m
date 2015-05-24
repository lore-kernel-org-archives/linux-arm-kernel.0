From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 24 May 2015 19:49:01 +0200
Subject: [RFC PATCH 2/2] arm64: Implement vmalloc based thread_info
 allocator
In-Reply-To: <1432483340-23157-1-git-send-email-jungseoklee85@gmail.com>
References: <1432483340-23157-1-git-send-email-jungseoklee85@gmail.com>
Message-ID: <5992243.NYDGjLH37z@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 25 May 2015 01:02:20 Jungseok Lee wrote:
> Fork-routine sometimes fails to get a physically contiguous region for
> thread_info on 4KB page system although free memory is enough. That is,
> a physically contiguous region, which is currently 16KB, is not available
> since system memory is fragmented.
> 
> This patch tries to solve the problem as allocating thread_info memory
> from vmalloc space, not 1:1 mapping one. The downside is one additional
> page allocation in case of vmalloc. However, vmalloc space is large enough,
> around 240GB, under a combination of 39-bit VA and 4KB page. Thus, it is
> not a big tradeoff for fork-routine service.

vmalloc has a rather large runtime cost. I'd argue that failing to allocate
thread_info structures means something has gone very wrong.

Can you describe the scenario that leads to fragmentation this bad?

Could the stack size be reduced to 8KB perhaps?

	Arnd
