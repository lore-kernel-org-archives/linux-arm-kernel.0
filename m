From: kristofer.s.martinez@gmail.com (Martinez Kristofer)
Date: Thu, 19 May 2016 18:14:54 +0800
Subject: [PATCH] arm64: cpuinfo: add AArch64 & elf platform for app
 compatibility
In-Reply-To: <1463625873-60016-1-git-send-email-saberlily.xia@hisilicon.com>
References: <1463625873-60016-1-git-send-email-saberlily.xia@hisilicon.com>
Message-ID: <CABtop_ED5ASg-0O-6QE5LXeN_t8rwYWWgExM_1GCnstP7RZ-7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 19, 2016 at 10:44 AM, x00195127 <saberlily.xia@hisilicon.com> wrote:
> we find that some apps will read cpuinfo when start up,
> they need the string  as follows:
> "Processor       : AArch64 Processor rev 0 (aarch64)"
>
> Then thay could load the corresponding libs. But now
> arm64 platform's cpuinfo don't has this now, so
> we need add this.
>
> Signed-off-by: Qing Xia <saberlily.xia@hisilicon.com>
> ---
>  arch/arm64/kernel/cpuinfo.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
> index 3808470..c3527ad 100644
> --- a/arch/arm64/kernel/cpuinfo.c
> +++ b/arch/arm64/kernel/cpuinfo.c
> @@ -114,6 +114,9 @@ static int c_show(struct seq_file *m, void *v)
>                  * online processors, looking for lines beginning with
>                  * "processor".  Give glibc what it expects.
>                  */
> +               seq_printf(m, "Processor\t: AArch64 Processor rev %d (%s)\n",
> +                               read_cpuid_id() & 15, ELF_PLATFORM);

Nit: read_cpuid_id() & 0xf, ELF_PLATFORM);
What're those apps will need this string to startup?

M.K.

> +
>                 seq_printf(m, "processor\t: %d\n", i);
>
>                 seq_printf(m, "BogoMIPS\t: %lu.%02lu\n",
> --
> 1.8.3.2
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
