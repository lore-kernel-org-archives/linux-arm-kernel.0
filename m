From: akpm@linux-foundation.org (Andrew Morton)
Date: Mon, 9 Dec 2013 16:11:34 -0800
Subject: [PATCH v3 02/23] mm/memblock: debug: don't free reserved array
 if !ARCH_DISCARD_MEMBLOCK
In-Reply-To: <1386625856-12942-3-git-send-email-santosh.shilimkar@ti.com>
References: <1386625856-12942-1-git-send-email-santosh.shilimkar@ti.com>
 <1386625856-12942-3-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20131209161134.e161ddfedf284f2052cad4a5@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 9 Dec 2013 16:50:35 -0500 Santosh Shilimkar <santosh.shilimkar@ti.com> wrote:

> Now the Nobootmem allocator will always try to free memory allocated for
> reserved memory regions (free_low_memory_core_early()) without taking
> into to account current memblock debugging configuration
> (CONFIG_ARCH_DISCARD_MEMBLOCK and CONFIG_DEBUG_FS state).
> As result if:
>  - CONFIG_DEBUG_FS defined
>  - CONFIG_ARCH_DISCARD_MEMBLOCK not defined;
> -  reserved memory regions array have been resized during boot
> 
> then:
> - memory allocated for reserved memory regions array will be freed to
> buddy allocator;
> - debug_fs entry "sys/kernel/debug/memblock/reserved" will show garbage
> instead of state of memory reservations. like:
>    0: 0x98393bc0..0x9a393bbf
>    1: 0xff120000..0xff11ffff
>    2: 0x00000000..0xffffffff
> 
> Hence, do not free memory allocated for reserved memory regions if
> defined(CONFIG_DEBUG_FS) && !defined(CONFIG_ARCH_DISCARD_MEMBLOCK).

Alternatives:

- disable /proc/sys/kernel/debug/memblock/reserved in this case

- disable defined(CONFIG_DEBUG_FS) &&
  !defined(CONFIG_ARCH_DISCARD_MEMBLOCK) in Kconfig.

How much memory are we talking about here?  If it's more than "very
little" then I think either of these would be better - most users will
value the extra memory over an accurate
/proc/sys/kernel/debug/memblock/reserved?
