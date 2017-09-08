From: bp@suse.de (Borislav Petkov)
Date: Fri, 8 Sep 2017 11:02:15 +0200
Subject: [PATCH v3 1/3] arm64/ras: support sea error recovery
In-Reply-To: <1504770316-4327-2-git-send-email-xiexiuqi@huawei.com>
References: <1504770316-4327-1-git-send-email-xiexiuqi@huawei.com>
 <1504770316-4327-2-git-send-email-xiexiuqi@huawei.com>
Message-ID: <20170908090214.vfrbqaphia46qkhs@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 07, 2017 at 03:45:14PM +0800, Xie XiuQi wrote:
> With ARM v8.2 RAS Extension, SEA are usually triggered when memory errors
> are consumed. In some cases, if the error address is in a clean page or a
> read-only page, there is a chance to recover. Such as error occurs in a
> instruction page, we can reread this page from disk instead of killing
> process.
> 
> Because memory_failure() may sleep, we can not call it directly in SEA
> exception context. So we saved faulting physical address associated with
> a process in the ghes handler and set __TIF_SEA_NOTIFY. When we return
> from SEA exception context and get into do_notify_resume() before the
> process running, we could check it and call memory_failure() to do
> recovery. It's safe, because we are in process context.
> 
> Signed-off-by: Xie XiuQi <xiexiuqi@huawei.com>
> Signed-off-by: Wang Xiongfeng <wangxiongfeng2@huawei.com>

This is not a correct SOB chain, please check:

Documentation/process/submitting-patches.rst, section 11.

> ---
>  arch/arm64/Kconfig                   |  11 +++
>  arch/arm64/include/asm/ras.h         |  36 +++++++++
>  arch/arm64/include/asm/thread_info.h |   4 +-
>  arch/arm64/kernel/Makefile           |   1 +
>  arch/arm64/kernel/ras.c              | 141 +++++++++++++++++++++++++++++++++++
>  arch/arm64/kernel/signal.c           |   8 ++
>  arch/arm64/mm/fault.c                |  27 +++++--
>  drivers/acpi/apei/ghes.c             |   4 +-
>  8 files changed, 221 insertions(+), 11 deletions(-)
>  create mode 100644 arch/arm64/include/asm/ras.h
>  create mode 100644 arch/arm64/kernel/ras.c

What tree are those patches against?

They don't apply cleanly against latest mainline:

checking file arch/arm64/Kconfig
Hunk #1 succeeded at 641 (offset 1 line).
checking file arch/arm64/include/asm/ras.h
checking file arch/arm64/include/asm/thread_info.h
Hunk #1 FAILED at 86.
Hunk #2 succeeded at 98 (offset -4 lines).
Hunk #3 FAILED at 112.
2 out of 3 hunks FAILED
checking file arch/arm64/kernel/Makefile
checking file arch/arm64/kernel/ras.c
checking file arch/arm64/kernel/signal.c
Hunk #1 succeeded at 40 with fuzz 1 (offset 2 lines).
Hunk #2 FAILED at 750.
1 out of 2 hunks FAILED
checking file arch/arm64/mm/fault.c
Hunk #1 succeeded at 631 (offset 37 lines).
checking file drivers/acpi/apei/ghes.c

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imend?rffer, Jane Smithard, Graham Norton, HRB 21284 (AG N?rnberg)
-- 
