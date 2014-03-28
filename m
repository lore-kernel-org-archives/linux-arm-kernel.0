From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 28 Mar 2014 10:43:49 +0000
Subject: disabling MMU of ARMv7-A
In-Reply-To: <015e01cf4a55$7f43a950$7dcafbf0$@samsung.com>
References: <015e01cf4a55$7f43a950$7dcafbf0$@samsung.com>
Message-ID: <20140328104349.GG21330@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 28, 2014 at 07:15:28AM +0000, Chanho Park wrote:
> I want to know is there anyone who tried disabling MMU of ARMv7-A likes
> cortex-a9.
> Yes. I know this is a silly question :)
> I turned off CONFIG_MMU option of my exynos4 board and specified
> CONFIG_DRAM_BASE/SIZE and REMAP_VECTORS_TO_RAM.
> The problem is occurred in here there is no way to specify the vector table
> address.
> As I know the cortex-M3/4 has VTOR(Vector table offset register) to specify
> the vector table address.
> However, ARMv7-A/R doesn't have such register. They can only control whether
> use _HIGH_ vector or not.
> In this situation, can I find a way to boot successfully with
> nommu+cortex-a9?

There is no way to set a random vectors address on A9. But even if you
want a !MMU kernel, I would not recommend disabling the MMU entirely
because your memory accesses are strongly ordered (and slow and
unaligned accesses will not work). It's better to create some flat
mapping, possibly before starting the kernel and keep the MMU enabled.
Such mapping would contain a vectors page as well (low or high).

-- 
Catalin
