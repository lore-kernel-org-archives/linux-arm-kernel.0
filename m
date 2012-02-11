From: jic23@cam.ac.uk (Jonathan Cameron)
Date: Sat, 11 Feb 2012 19:07:15 +0000
Subject: [PATCH 02/11] Revert "ARM: pxa: add dummy clock for sa1100-rtc"
In-Reply-To: <E1Rntz6-0002pN-UE@rmk-PC.arm.linux.org.uk>
References: <20120119153149.GB1068@n2100.arm.linux.org.uk>
 <E1Rntz6-0002pN-UE@rmk-PC.arm.linux.org.uk>
Message-ID: <4F36BC63.70403@cam.ac.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/19/2012 03:33 PM, Russell King - ARM Linux wrote:
> This reverts commit 7557c175f60d8d40baf16b22caf79beadef8f081.
> 
> This revert is necessary to revert the broken "RTC: sa1100:
> support sa1100, pxa and mmp soc families" change.

Taking out the lines concerning the dummy clk for pxa-gpio is
causing stargate2's smc91x driver to fail to find the part.

So reverting the regression cause caused a different regression.

Something 'unusual' occured with the commit you reference above.
The gpio line was added in 389eda15e0f41112d7c44213b3c4f8bd1c9398bc
    ARM: pxa: add clk support in gpio driver

    Support clk in gpio driver. There's no gpio clock in PXA25x and PXA27x.
    So use dummy clk instead. And move the gpio edge initialization into
    gpio driver for arch-mmp.

    Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>

and git is telling me it was then readded in the patch you reverted.

Reapplying the above patch fixes the issue for me.

Note the regression Paul Parson's reported in

mfp/gpio regression: pxa_last_gpio used before initialized

is still there and is related to this same series of patches.
Annoyingly it took me two bisections of the merge window (via some
nasty breakage along the way) to track these down given one was
caused by the introduction of this series and the other by the reversion
of part of it.  Ah well, sometimes life is against you.

> ---
>  arch/arm/mach-pxa/pxa25x.c |    2 --
>  arch/arm/mach-pxa/pxa27x.c |    2 --
>  arch/arm/mach-pxa/pxa300.c |    1 -
>  arch/arm/mach-pxa/pxa320.c |    1 -
>  arch/arm/mach-pxa/pxa3xx.c |    1 -
>  arch/arm/mach-pxa/pxa95x.c |    1 -
>  6 files changed, 0 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/mach-pxa/pxa25x.c b/arch/arm/mach-pxa/pxa25x.c
> index adf058f..91e4f6c 100644
> --- a/arch/arm/mach-pxa/pxa25x.c
> +++ b/arch/arm/mach-pxa/pxa25x.c
> @@ -209,8 +209,6 @@ static struct clk_lookup pxa25x_clkregs[] = {
>  	INIT_CLKREG(&clk_pxa25x_gpio11, NULL, "GPIO11_CLK"),
>  	INIT_CLKREG(&clk_pxa25x_gpio12, NULL, "GPIO12_CLK"),
>  	INIT_CLKREG(&clk_pxa25x_mem, "pxa2xx-pcmcia", NULL),
> -	INIT_CLKREG(&clk_dummy, "pxa-gpio", NULL),
> -	INIT_CLKREG(&clk_dummy, "sa1100-rtc", NULL),
>  };
>  
>  static struct clk_lookup pxa25x_hwuart_clkreg =
> diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
> index 180bd86..aed6cbc 100644
> --- a/arch/arm/mach-pxa/pxa27x.c
> +++ b/arch/arm/mach-pxa/pxa27x.c
> @@ -230,8 +230,6 @@ static struct clk_lookup pxa27x_clkregs[] = {
>  	INIT_CLKREG(&clk_pxa27x_im, NULL, "IMCLK"),
>  	INIT_CLKREG(&clk_pxa27x_memc, NULL, "MEMCLK"),
>  	INIT_CLKREG(&clk_pxa27x_mem, "pxa2xx-pcmcia", NULL),
> -	INIT_CLKREG(&clk_dummy, "pxa-gpio", NULL),
> -	INIT_CLKREG(&clk_dummy, "sa1100-rtc", NULL),
>  };
>  
>  #ifdef CONFIG_PM
> diff --git a/arch/arm/mach-pxa/pxa300.c b/arch/arm/mach-pxa/pxa300.c
> index 0388eda..40bb165 100644
> --- a/arch/arm/mach-pxa/pxa300.c
> +++ b/arch/arm/mach-pxa/pxa300.c
> @@ -89,7 +89,6 @@ static DEFINE_PXA3_CKEN(gcu, PXA300_GCU, 0, 0);
>  static struct clk_lookup common_clkregs[] = {
>  	INIT_CLKREG(&clk_common_nand, "pxa3xx-nand", NULL),
>  	INIT_CLKREG(&clk_gcu, "pxa3xx-gcu", NULL),
> -	INIT_CLKREG(&clk_dummy, "sa1100-rtc", NULL),
>  };
>  
>  static DEFINE_PXA3_CKEN(pxa310_mmc3, MMC3, 19500000, 0);
> diff --git a/arch/arm/mach-pxa/pxa320.c b/arch/arm/mach-pxa/pxa320.c
> index d487e1f..8d614ec 100644
> --- a/arch/arm/mach-pxa/pxa320.c
> +++ b/arch/arm/mach-pxa/pxa320.c
> @@ -83,7 +83,6 @@ static DEFINE_PXA3_CKEN(gcu, PXA320_GCU, 0, 0);
>  static struct clk_lookup pxa320_clkregs[] = {
>  	INIT_CLKREG(&clk_pxa320_nand, "pxa3xx-nand", NULL),
>  	INIT_CLKREG(&clk_gcu, "pxa3xx-gcu", NULL),
> -	INIT_CLKREG(&clk_dummy, "sa1100-rtc", NULL),
>  };
>  
>  static int __init pxa320_init(void)
> diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
> index f107c71..4f402af 100644
> --- a/arch/arm/mach-pxa/pxa3xx.c
> +++ b/arch/arm/mach-pxa/pxa3xx.c
> Path: news.gmane.org!not-for-mail
> From: Russell King - ARM Linux <linux@arm.linux.org.uk>
> Newsgroups: gmane.linux.ports.arm.kernel
> Subject: [PATCH 02/11] Revert "ARM: pxa: add dummy clock for sa1100-rtc"
> Date: Thu, 19 Jan 2012 15:33:04 +0000
> Lines: 89
> Approved: news at gmane.org
> Message-ID: <E1Rntz6-0002pN-UE@rmk-PC.arm.linux.org.uk>
> References: <20120119153149.GB1068@n2100.arm.linux.org.uk>
> NNTP-Posting-Host: lo.gmane.org
> Mime-Version: 1.0
> Content-Type: text/plain; charset="us-ascii"
> Content-Transfer-Encoding: 7bit
> X-Trace: dough.gmane.org 1326987256 17293 80.91.229.12 (19 Jan 2012 15:34:16 GMT)
> X-Complaints-To: usenet at dough.gmane.org
> NNTP-Posting-Date: Thu, 19 Jan 2012 15:34:16 +0000 (UTC)
> Cc: linux-arm-kernel at lists.infradead.org
> To: Alessandro Zummo <a.zummo@towertech.it>, Eric Miao <eric.y.miao@gmail.com>,
>  Haojian Zhuang <haojian.zhuang@marvell.com>
> Original-X-From: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org at lists.infradead.org Thu Jan 19 16:34:12 2012
> Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
> Envelope-to: linux-arm-kernel at m.gmane.org
> Original-Received: from merlin.infradead.org ([205.233.59.134])
> 	by lo.gmane.org with esmtp (Exim 4.69)
> 	(envelope-from <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>)
> 	id 1Rnu0B-0003BT-Rl
> 	for linux-arm-kernel at m.gmane.org; Thu, 19 Jan 2012 16:34:12 +0100
> Original-Received: from localhost ([::1] helo=merlin.infradead.org)
> 	by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
> 	id 1Rntzr-0004U8-1D; Thu, 19 Jan 2012 15:33:51 +0000
> Original-Received: from [2002:4e20:1eda::1] (helo=caramon.arm.linux.org.uk)
>  by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
>  id 1Rntzn-0004TB-NX
>  for linux-arm-kernel at lists.infradead.org; Thu, 19 Jan 2012 15:33:48 +0000
> DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
>  d=arm.linux.org.uk; s=caramon; 
>  h=Date:Sender:Message-Id:Content-Type:MIME-Version:Subject:Cc:To:From:References:In-Reply-To;
>  bh=CRJy9I8VrueLAFVV1dQT8z59MD8ZXLM7qL7ZxqDZXb8=; 
>  b=oA0dWgc3PfX8EdGWIz4FtN+Jrhf83oMzzKwJ8OHC+ak8c43bY7lP3XneWB+0YoVhhb9dpKyM//+CWYbaxtXDPVPeR5DaXUCwhsMvrioz8CFqUQUa/tPhiDEa9uMhVhXNhxrIOCDZgUPhcT3Hua0QgoarAIAGOYlHhFXlg6Zh2Nc=;
> Original-Received: from e0022681537dd.dyn.arm.linux.org.uk
>  ([2002:4e20:1eda:1:222:68ff:fe15:37dd]:47744 helo=rmk-PC.arm.linux.org.uk)
>  by caramon.arm.linux.org.uk with esmtpsa (TLSv1:AES256-SHA:256)
>  (Exim 4.76) (envelope-from <rmk@arm.linux.org.uk>)
>  id 1RntzA-0003vg-I1; Thu, 19 Jan 2012 15:33:08 +0000
> Original-Received: from rmk by rmk-PC.arm.linux.org.uk with local (Exim 4.76)
>  (envelope-from <rmk@arm.linux.org.uk>)
>  id 1Rntz6-0002pN-UE; Thu, 19 Jan 2012 15:33:05 +0000
> In-Reply-To: <20120119153149.GB1068@n2100.arm.linux.org.uk>
> Content-Disposition: inline
> X-Spam-Note: CRM114 invocation failed
> X-Spam-Score: -1.2 (-)
> X-Spam-Report: SpamAssassin version 3.3.2 on merlin.infradead.org summary:
>  Content analysis details:   (-1.2 points)
>  pts rule name              description
>  ---- ---------------------- --------------------------------------------------
>  -1.9 BAYES_00               BODY: Bayes spam probability is 0 to 1%
>  [score: 0.0000]
>  -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from author's
>  domain
>  0.1 DKIM_SIGNED            Message has a DKIM or DK signature,
>  not necessarily valid
>  -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
>  0.8 RDNS_NONE Delivered to internal network by a host with no rDNS
> X-BeenThere: linux-arm-kernel at lists.infradead.org
> X-Mailman-Version: 2.1.14
> Precedence: list
> List-Id: <linux-arm-kernel.lists.infradead.org>
> List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
>  <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
> List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
> List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
> List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
> List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
>  <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
> Original-Sender: linux-arm-kernel-bounces at lists.infradead.org
> Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org at lists.infradead.org
> Xref: news.gmane.org gmane.linux.ports.arm.kernel:148605
> Archived-At: <http://permalink.gmane.org/gmane.linux.ports.arm.kernel/148605>
> 
> This reverts commit 7557c175f60d8d40baf16b22caf79beadef8f081.
> 
> This revert is necessary to revert the broken "RTC: sa1100:
> support sa1100, pxa and mmp soc families" change.
> ---
>  arch/arm/mach-pxa/pxa25x.c |    2 --
>  arch/arm/mach-pxa/pxa27x.c |    2 --
>  arch/arm/mach-pxa/pxa300.c |    1 -
>  arch/arm/mach-pxa/pxa320.c |    1 -
>  arch/arm/mach-pxa/pxa3xx.c |    1 -
>  arch/arm/mach-pxa/pxa95x.c |    1 -
>  6 files changed, 0 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/mach-pxa/pxa25x.c b/arch/arm/mach-pxa/pxa25x.c
> index adf058f..91e4f6c 100644
> --- a/arch/arm/mach-pxa/pxa25x.c
> +++ b/arch/arm/mach-pxa/pxa25x.c
> @@ -209,8 +209,6 @@ static struct clk_lookup pxa25x_clkregs[] = {
>  	INIT_CLKREG(&clk_pxa25x_gpio11, NULL, "GPIO11_CLK"),
>  	INIT_CLKREG(&clk_pxa25x_gpio12, NULL, "GPIO12_CLK"),
>  	INIT_CLKREG(&clk_pxa25x_mem, "pxa2xx-pcmcia", NULL),
> -	INIT_CLKREG(&clk_dummy, "pxa-gpio", NULL),
> -	INIT_CLKREG(&clk_dummy, "sa1100-rtc", NULL),
>  };
>  
>  static struct clk_lookup pxa25x_hwuart_clkreg =
> diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
> index 180bd86..aed6cbc 100644
> --- a/arch/arm/mach-pxa/pxa27x.c
> +++ b/arch/arm/mach-pxa/pxa27x.c
> @@ -230,8 +230,6 @@ static struct clk_lookup pxa27x_clkregs[] = {
>  	INIT_CLKREG(&clk_pxa27x_im, NULL, "IMCLK"),
>  	INIT_CLKREG(&clk_pxa27x_memc, NULL, "MEMCLK"),
>  	INIT_CLKREG(&clk_pxa27x_mem, "pxa2xx-pcmcia", NULL),
> -	INIT_CLKREG(&clk_dummy, "pxa-gpio", NULL),
> -	INIT_CLKREG(&clk_dummy, "sa1100-rtc", NULL),
>  };
>  
>  #ifdef CONFIG_PM
> diff --git a/arch/arm/mach-pxa/pxa300.c b/arch/arm/mach-pxa/pxa300.c
> index 0388eda..40bb165 100644
> --- a/arch/arm/mach-pxa/pxa300.c
> +++ b/arch/arm/mach-pxa/pxa300.c
> @@ -89,7 +89,6 @@ static DEFINE_PXA3_CKEN(gcu, PXA300_GCU, 0, 0);
>  static struct clk_lookup common_clkregs[] = {
>  	INIT_CLKREG(&clk_common_nand, "pxa3xx-nand", NULL),
>  	INIT_CLKREG(&clk_gcu, "pxa3xx-gcu", NULL),
> -	INIT_CLKREG(&clk_dummy, "sa1100-rtc", NULL),
>  };
>  
>  static DEFINE_PXA3_CKEN(pxa310_mmc3, MMC3, 19500000, 0);
> diff --git a/arch/arm/mach-pxa/pxa320.c b/arch/arm/mach-pxa/pxa320.c
> index d487e1f..8d614ec 100644
> --- a/arch/arm/mach-pxa/pxa320.c
> +++ b/arch/arm/mach-pxa/pxa320.c
> @@ -83,7 +83,6 @@ static DEFINE_PXA3_CKEN(gcu, PXA320_GCU, 0, 0);
>  static struct clk_lookup pxa320_clkregs[] = {
>  	INIT_CLKREG(&clk_pxa320_nand, "pxa3xx-nand", NULL),
>  	INIT_CLKREG(&clk_gcu, "pxa3xx-gcu", NULL),
> -	INIT_CLKREG(&clk_dummy, "sa1100-rtc", NULL),
>  };
>  
>  static int __init pxa320_init(void)
> diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
> index f107c71..4f402af 100644
> --- a/arch/arm/mach-pxa/pxa3xx.c
> +++ b/arch/arm/mach-pxa/pxa3xx.c
> @@ -67,7 +67,6 @@ static struct clk_lookup pxa3xx_clkregs[] = {
>  	INIT_CLKREG(&clk_pxa3xx_pout, NULL, "CLK_POUT"),
>  	/* Power I2C clock is always on */
>  	INIT_CLKREG(&clk_dummy, "pxa3xx-pwri2c.1", NULL),
> -	INIT_CLKREG(&clk_dummy, "sa1100-rtc", NULL),
>  	INIT_CLKREG(&clk_pxa3xx_lcd, "pxa2xx-fb", NULL),
>  	INIT_CLKREG(&clk_pxa3xx_camera, NULL, "CAMCLK"),
>  	INIT_CLKREG(&clk_pxa3xx_ac97, NULL, "AC97CLK"),
> diff --git a/arch/arm/mach-pxa/pxa95x.c b/arch/arm/mach-pxa/pxa95x.c
> index fccc644..d082a58 100644
> --- a/arch/arm/mach-pxa/pxa95x.c
> +++ b/arch/arm/mach-pxa/pxa95x.c
> @@ -217,7 +217,6 @@ static struct clk_lookup pxa95x_clkregs[] = {
>  	INIT_CLKREG(&clk_pxa95x_pout, NULL, "CLK_POUT"),
>  	/* Power I2C clock is always on */
>  	INIT_CLKREG(&clk_dummy, "pxa3xx-pwri2c.1", NULL),
> -	INIT_CLKREG(&clk_dummy, "sa1100-rtc", NULL),
>  	INIT_CLKREG(&clk_pxa95x_lcd, "pxa2xx-fb", NULL),
>  	INIT_CLKREG(&clk_pxa95x_ffuart, "pxa2xx-uart.0", NULL),
>  	INIT_CLKREG(&clk_pxa95x_btuart, "pxa2xx-uart.1", NULL),
