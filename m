From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 28 Jan 2016 16:27:40 +0300
Subject: [PATCH 7/9] net: macb: avoid uninitialized variables
In-Reply-To: <1453903507-3427225-8-git-send-email-arnd@arndb.de>
References: <1453903507-3427225-1-git-send-email-arnd@arndb.de>
 <1453903507-3427225-8-git-send-email-arnd@arndb.de>
Message-ID: <56AA174C.5010408@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 1/27/2016 5:04 PM, Arnd Bergmann wrote:

> The macb_clk_init function returns three clock pointers, unless
> the it fails to get the first ones. We correctly handle the

    s/the//.

> failure case by propagating the error from macb_probe, but
> gcc does not realize this and incorrectly warns about a later
> use of those:
>
> In file included from /git/arm-soc/drivers/net/ethernet/cadence/macb.c:12:0:
> drivers/net/ethernet/cadence/macb.c: In function 'macb_probe':

    Hm, didn't these 2 lines get swapped by chance?

> include/linux/clk.h:484:2: error: 'tx_clk' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>    clk_disable(clk);
>    ^
> drivers/net/ethernet/cadence/macb.c:2822:28: note: 'tx_clk' was declared here
>    struct clk *pclk, *hclk, *tx_clk;
>                              ^
> In file included from /git/arm-soc/drivers/net/ethernet/cadence/macb.c:12:0:
> include/linux/clk.h:484:2: error: 'hclk' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>    clk_disable(clk);
>    ^
> drivers/net/ethernet/cadence/macb.c:2822:21: note: 'hclk' was declared here
>    struct clk *pclk, *hclk, *tx_clk;
>                       ^
>
> This shuts up the misleading warnings by ensuring that the
> macb_clk_init() always stores something into all three pointers.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

[...]

MBR, Sergei
