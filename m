From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 8 Apr 2017 14:45:34 -0300
Subject: Linux next-20170407 failed to build on ARM due to usage of mod in
 btrfs code
In-Reply-To: <alpine.LNX.2.20.1704090002520.35546@x220i>
References: <alpine.LNX.2.20.1704090002520.35546@x220i>
Message-ID: <CAOMZO5B9J15qvrsjOb-e5gk47gA=+2p2yLNLhswG+H3S0L7LXg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 8, 2017 at 1:02 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
> Hello everyone,
> Today I tried to build a kernel with btrfs enabled on ARM, then when linking
> I met such an error:
>
> ```
> fs/built-in.o: In function `scrub_bio_end_io_worker':
> acl.c:(.text+0x2f0450): undefined reference to `__aeabi_uldivmod'
> fs/built-in.o: In function `scrub_extent_for_parity':
> acl.c:(.text+0x2f0bcc): undefined reference to `__aeabi_uldivmod'
> fs/built-in.o: In function `scrub_raid56_parity':
> acl.c:(.text+0x2f12a8): undefined reference to `__aeabi_uldivmod'
> acl.c:(.text+0x2f15c4): undefined reference to `__aeabi_uldivmod'
> ```
>
> These functions are found at fs/btrfs/scrub.c .
>
> After disabling btrfs the kernel is successfully built.

I see the same error with ARM imx_v6_v7_defconfig + btrfs support.

Looks like it is caused by commit 7d0ef8b4dbbd220 ("Btrfs: update
scrub_parity to use u64 stripe_len").
