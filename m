From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 26 May 2015 11:51:17 +0200
Subject: [RFC PATCH 2/2] arm64: Implement vmalloc based thread_info
 allocator
In-Reply-To: <1CD6E4BA-95AF-420C-8270-6AAF783B6F60@foss.arm.com>
References: <1432483340-23157-1-git-send-email-jungseoklee85@gmail.com>
 <5601369.jDWtB6nFJC@wuerfel>
 <1CD6E4BA-95AF-420C-8270-6AAF783B6F60@foss.arm.com>
Message-ID: <3076059.95sGQMhV87@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 26 May 2015 01:36:29 Catalin Marinas wrote:
> 
> > There are a lot of workloads that would benefit from having lower
> > per-thread memory cost.
> 
> If we keep the 16KB stack, is there any advantage in a separate IRQ one (assuming 
> that we won't overflow 16KB)?

It makes possible errors more reproducible: we already know that we need over
8kb for normal stacks based on Minchan's findings, and the chance that an interrupt
happens at a time when the stack is the highest is very low, but that just makes
the bug much harder to find if you ever run into it.

If we overflow the stack (independent of its size) with a process stack by itself,
it will always happen in the same call chain, not a combination of a call chain
an a particularly bad interrupt.

	Arnd
