From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 14 Sep 2012 19:31:46 -0300
Subject: [PATCH 05/24] ARM: imx: use __iomem pointers for MMIO
In-Reply-To: <1347658492-11608-6-git-send-email-arnd@arndb.de>
References: <1347658492-11608-1-git-send-email-arnd@arndb.de>
 <1347658492-11608-6-git-send-email-arnd@arndb.de>
Message-ID: <CAOMZO5DemdKtxORhRwyGyF46rdden5QRZh9D9f4KRki5+BfM2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 14, 2012 at 6:34 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> ARM is moving to stricter checks on readl/write functions,
> so we need to use the correct types everywhere.
>
> This found a bug in mach-armadillo5x0.c, where we attempt mmio
> on the MXC_CCM_RCSR address that is currently defined to 0xc
> and consequently causes an illegal address access.
...

>         /* set NAND page size to 2k if not configured via boot mode pins */
> -       __raw_writel(__raw_readl(MXC_CCM_RCSR) | (1 << 30), MXC_CCM_RCSR);
> +       /* FIXME __raw_writel(__raw_readl(MXC_CCM_RCSR) | (1 << 30), MXC_CCM_RCSR); */

Good catch, the correct access would be:
__raw_readl(mx3_ccm_base + MXC_CCM_RCSR) ...

I will fix this after your series reaches linux-next.

Regards,

Fabio Estevam
