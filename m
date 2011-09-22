From: skannan@codeaurora.org (Saravana Kannan)
Date: Thu, 22 Sep 2011 10:39:14 -0700
Subject: [PATCH] clk: provide prepare/unprepare functions
In-Reply-To: <20110922101024.GK17169@n2100.arm.linux.org.uk>
References: <20110922101024.GK17169@n2100.arm.linux.org.uk>
Message-ID: <4E7B72C2.3060402@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/22/2011 03:10 AM, Russell King - ARM Linux wrote:
> As discussed previously, there's the need on some platforms to run some
> parts of clk_enable() in contexts which can schedule.  The solution
> which was agreed upon was to provide clk_prepare() and clk_unprepare()
> to contain this parts, while clk_enable() and clk_disable() perform
> the atomic part.
>
> This patch provides a common definition for clk_prepare() and
> clk_unprepare() in linux/clk.h, and provides an upgrade path for
> existing implementation and drivers: drivers can start using
> clk_prepare() and clk_unprepare() once this patch is merged without
> having to wait for platform support.  Platforms can then start to
> provide these additional functions.
>
> Eventually, HAVE_CLK_PREPARE will be removed from the kernel, and
> everyone will have to provide these new APIs.

Glad to see this. Now the drivers and individual arch's can start moving 
to these new APIs before we settle on the common infrastructure. Once 
the common infrastructure is in, it should hopefully be trivial to move 
each arch to it.

> Signed-off-by: Russell King<rmk+kernel@arm.linux.org.uk>
> ---
>   include/linux/clk.h |   38 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 38 insertions(+)
>
> diff --git a/include/linux/clk.h b/include/linux/clk.h
> index 1d37f42..c7eb17d 100644
> --- a/include/linux/clk.h
> +++ b/include/linux/clk.h
> @@ -11,6 +11,8 @@
>   #ifndef __LINUX_CLK_H
>   #define __LINUX_CLK_H
>
> +#include<linux/kernel.h>
> +
>   struct device;
>
>   /*
> @@ -41,11 +43,29 @@ struct clk;
>   struct clk *clk_get(struct device *dev, const char *id);
>
>   /**
> + * clk_prepare - prepare a clock source
> + * @clk: clock source
> + *
> + * This prepares the clock source for use.

Do you want to add a "May NOT be called from atomic context"? Yeah, the 
stub makes it obvious, but I think it would be consistent to add the 
comment in. No strong opinion though.

Not sure if you care, but LGTM/Ack.

Thanks,
Saravana
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
