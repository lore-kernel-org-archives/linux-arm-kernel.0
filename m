From: salyzyn@android.com (Mark Salyzyn)
Date: Wed, 6 Sep 2017 09:04:03 -0700
Subject: [PATCH v2 1/3] arm64: compat: Split the sigreturn trampolines and
 kuser helpers (C sources)
In-Reply-To: <20170816222723.118839-1-salyzyn@android.com>
References: <20170816222723.118839-1-salyzyn@android.com>
Message-ID: <898f1068-e99c-2f0e-8950-59dfd972bc89@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ping?

On 08/16/2017 03:26 PM, Mark Salyzyn wrote:
> From: Kevin Brodsky <kevin.brodsky@arm.com>
>
> AArch32 processes are currently installed a special [vectors] page that
> contains the sigreturn trampolines and the kuser helpers, at the fixed
> address mandated by the kuser helpers ABI.
>
> Having both functionalities in the same page has become problematic,
> because:
>
> * It makes it impossible to disable the kuser helpers (the sigreturn
>    trampolines cannot be removed), which is possible on arm.
>
> * A future 32-bit vDSO would provide the sigreturn trampolines itself,
>    making those in [vectors] redundant.
>
> This patch addresses the problem by moving the sigreturn trampolines to
> a separate [sigpage] page, mirroring [sigpage] on arm.
>
> Even though [vectors] has always been a misnomer on arm64/compat, as
> there is no AArch32 vector there (and now only the kuser helpers),
> its name has been left unchanged, for compatibility with arm (there
> are reports of software relying on [vectors] being there as the last
> mapping in /proc/maps).
>
> mm->context.vdso used to point to the [vectors] page, which is
> unnecessary (as its address is fixed). It now points to the [sigpage]
> page (whose address is randomized like a vDSO).
>
> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
> Signed-off-by: Mark Salyzyn <salyzyn@android.com>
>
> v2:
> - reduce churniness (and defer later to vDSO patches)
> - vctors_page and compat_vdso_spec as array of 2
> - free sigpage if vectors allocation failed
> ---
>   arch/arm64/include/asm/processor.h |  4 +-
>   arch/arm64/include/asm/signal32.h  |  2 -
>   arch/arm64/kernel/signal32.c       |  5 +--
>   arch/arm64/kernel/vdso.c           | 82 ++++++++++++++++++++++++++------------
>   4 files changed, 60 insertions(+), 33 deletions(-)
. . .
