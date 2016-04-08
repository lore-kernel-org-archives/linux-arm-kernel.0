From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 7 Apr 2016 17:33:28 -0700
Subject: [PATCH v2] clk: let clk_disable() return immediately if clk is
 NULL or error
In-Reply-To: <1459821083-28116-1-git-send-email-yamada.masahiro@socionext.com>
References: <1459821083-28116-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20160408003328.GA14441@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/05, Masahiro Yamada wrote:
> The clk_disable() in the common clock framework (drivers/clk/clk.c)
> returns immediately if a given clk is NULL or an error pointer.  It
> allows clock consumers to call clk_disable() without IS_ERR_OR_NULL
> checking if drivers are only used with the common clock framework.
> 
> Unfortunately, NULL/error checking is missing from some of non-common
> clk_disable() implementations.  This prevents us from completely
> dropping NULL/error checking from callers.  Let's make it tree-wide
> consistent by adding IS_ERR_OR_NULL(clk) to all callees.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Acked-by: Greg Ungerer <gerg@uclinux.org>
> Acked-by: Wan Zongshun <mcuos.com@gmail.com>
> ---
> 
> Stephen,
> 
> This patch has been unapplied for a long time.
> 
> Please let me know if there is something wrong with this patch.
> 

I'm mostly confused why we wouldn't want to encourage people to
call clk_disable or unprepare on a clk that's an error pointer.
Typically an error pointer should be dealt with, instead of
silently ignored, so why wasn't it dealt with by passing it up
the probe() path?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
