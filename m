From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sun, 30 Oct 2016 14:09:01 +0000
Subject: [PATCH V2 6/6] arm64: Add uprobe support
In-Reply-To: <41cc70043792e65cbc3b4cc4ad7fbf6379afa550.1474960629.git.panand@redhat.com>
References: <cover.1474960629.git.panand@redhat.com>
 <41cc70043792e65cbc3b4cc4ad7fbf6379afa550.1474960629.git.panand@redhat.com>
Message-ID: <20161030140901.h6mdxbb4pgqpqs7j@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 27, 2016 at 01:18:00PM +0530, Pratyush Anand wrote:
> --- /dev/null
> +++ b/arch/arm64/kernel/probes/uprobes.c
> @@ -0,0 +1,221 @@
> +/*
> + * Copyright (C) 2014-2016 Pratyush Anand <panand@redhat.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#include <linux/highmem.h>
> +#include <linux/ptrace.h>
> +#include <linux/uprobes.h>
> +#include <asm/cacheflush.h>
> +
> +#include "decode-insn.h"
> +
> +#define UPROBE_INV_FAULT_CODE	UINT_MAX
> +
> +bool is_trap_insn(uprobe_opcode_t *insn)
> +{
> +	return false;
> +}

On the previous series, I had a comment left unanswered with regards to
always returning false in is_trap_insn():

Looking at handle_swbp(), if we hit a breakpoint for which we don't have
a valid uprobe, this function currently sends a SIGTRAP. But if
is_trap_insn() returns false always, is_trap_at_addr() would return 0 in
this case so the SIGTRAP is never issued.

-- 
Catalin
