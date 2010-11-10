From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Wed, 10 Nov 2010 14:19:05 +0300
Subject: Patch IMX audmux debugfs.
In-Reply-To: <BLU0-SMTP14C9A6CEFEB68711495B30B8300@phx.gbl>
References: <BLU0-SMTP14C9A6CEFEB68711495B30B8300@phx.gbl>
Message-ID: <4CDA7FA9.3020100@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 10-11-2010 2:11, Bill Pringlemeir wrote:

> $ mount -t debugfs debugfs /sys/kernel/debug
> $ cd /sys/kernel/debug/audmux
> $ cat *
> [crashes when accessing ssi7]

> The index is one based, but the register map is zero based.  So the
> ssi1 is actually sending info for ssi2.  Also, the ssi7 touches
> non-existent data and can cause an exception (only registers sets 1-6
> exist).

> Alternatively, the MX31_AUDMUX_PORT6_SSI_PINS_6 and
> MX27_AUDMUX_PPCR3_SSI_PINS_3 constants could be used for the loop
> termination, but maybe that means conditionalization (and there are no
> MX25 constants).

> diff --git a/arch/arm/plat-mxc/audmux-v2.c b/arch/arm/plat-mxc/audmux-v2.c
> index f9e7cdb..0547145 100644
> --- a/arch/arm/plat-mxc/audmux-v2.c
> +++ b/arch/arm/plat-mxc/audmux-v2.c
> @@ -66,7 +66,7 @@ static ssize_t audmux_read_file(struct file *file, char __user *user_buf,
>   {
>          ssize_t ret;
>          char *buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
> -       int port = (int)file->private_data;
> +       int port = ((int)file->private_data) - 1;

    Parens around typecast not necessary.

WBR, Sergei
