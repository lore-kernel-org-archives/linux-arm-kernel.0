From: robherring2@gmail.com (Rob Herring)
Date: Thu, 7 Aug 2014 08:30:35 -0500
Subject: [PATCH v17 9/9] of: fdt: fix memory address be truncated
In-Reply-To: <1407408695-19626-10-git-send-email-haojian.zhuang@linaro.org>
References: <1407408695-19626-1-git-send-email-haojian.zhuang@linaro.org>
 <1407408695-19626-10-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <CAL_Jsq+zDsRAwZxSkKfdkSkQqpmQOuxMHdyzRGzdhaUsTkpvkA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 7, 2014 at 5:51 AM, Haojian Zhuang
<haojian.zhuang@linaro.org> wrote:
> early_init_dt_add_memory_arch() accepts base & size parameters as u64
> type. memblock_add() accepts base & size parameters as phys_addr_t type.
> But phys_addr_t isn't equal to u64. In 32-bit system, phys_addr_t is
> 32-bit long. If 64-bit memory address is specified in DTS file, it'll be
> truncated into 32-bit address.
>
> So create two values to store base & size first as phys_addr_t type.
> Then compare them with u64 base & u64 size. If they don't match, discard
> them.

This is fixed already in v3.16:

commit a67a6ed15513541579d38bcbd127e7be170710e5
Author: Laura Abbott <lauraa@codeaurora.org>
Date:   Thu Jun 19 20:13:38 2014 -0700

    of: Check for phys_addr_t overflows in early_init_dt_add_memory_arch

    The common early_init_dt_add_memory_arch takes the base and size
    of a memory region as u64 types. The function never checks if
    the base and size can actually fit in a phys_addr_t which may
    be smaller than 64-bits. This may result in incorrect memory
    being passed to memblock_add if the memory falls outside the
    range of phys_addr_t. Add range checks for the base and size if
    phys_addr_t is smaller than u64.

    Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
    Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>
    Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
    Acked-by: Nicolas Pitre <nico@linaro.org>
    Signed-off-by: Grant Likely <grant.likely@linaro.org>


In the future, please use get_maintainers.pl to cc the correct people.

Rob
