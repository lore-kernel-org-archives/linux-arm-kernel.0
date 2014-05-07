From: jolsa@redhat.com (Jiri Olsa)
Date: Wed, 7 May 2014 14:05:21 +0200
Subject: [PATCH 2/3] perf tests: Add dwarf unwind test on ARM64
In-Reply-To: <1399391733-11927-3-git-send-email-jean.pihet@linaro.org>
References: <1399391733-11927-1-git-send-email-jean.pihet@linaro.org>
 <1399391733-11927-3-git-send-email-jean.pihet@linaro.org>
Message-ID: <20140507120521.GB2019@krava.brq.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 06, 2014 at 05:55:32PM +0200, Jean Pihet wrote:

SNIP

> +#include "tests/tests.h"
> +
> +#define STACK_SIZE 8192
> +
> +static int sample_ustack(struct perf_sample *sample,
> +			 struct thread *thread, u64 *regs)
> +{
> +	struct stack_dump *stack = &sample->user_stack;
> +	struct map *map;
> +	unsigned long sp;
> +	u64 stack_size, *buf;
> +
> +	buf = malloc(STACK_SIZE);
> +	if (!buf) {
> +		pr_debug("failed to allocate sample uregs data\n");
> +		return -1;
> +	}
> +
> +	sp = (unsigned long) regs[PERF_REG_ARM64_SP];
> +
> +	map = map_groups__find(&thread->mg, MAP__FUNCTION, (u64) sp);
> +	if (!map) {
> +		pr_debug("failed to get stack map\n");
> +		return -1;
> +	}

there's a memory leak of 'buf' already fixed fox x86:

  perf tests x86: Fix memory leak in sample_ustack()
  commit 763d7f5f2718f085bab5a9e63308349728f3ad12
  Author: Masanari Iida <standby24x7@gmail.com>
  Date:   Sun Apr 20 00:16:41 2014 +0900

jirka
