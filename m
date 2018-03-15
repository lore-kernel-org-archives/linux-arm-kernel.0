From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 15 Mar 2018 11:08:06 +0800
Subject: [PATCH v2 1/2] soc: imx: gpcv2: Do not pass static memory as
 platform data
In-Reply-To: <20180208064709.GB31910@dragon>
References: <20180122150748.1742-1-andrew.smirnov@gmail.com>
 <20180208064709.GB31910@dragon>
Message-ID: <20180315030804.GI26859@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 08, 2018 at 02:47:10PM +0800, Shawn Guo wrote:
> On Mon, Jan 22, 2018 at 07:07:47AM -0800, Andrey Smirnov wrote:
> > Platform device core assumes the ownership of dev.platform_data as
> > well as that it is dynamically allocated and it will try to kfree it
> > as a part of platform_device_release(). Change the code to pass
> > kzalloc'ed chunk of memory instead of a pointer to a static memory to
> > avoid causing a BUG() when calling platform_device_put().
> > 
> > The problem can be reproduced by artificially enabling the error path
> > of platform_device_add() call (around line 357).
> > 
> > Note that this change also allows us to constify imx7_pgc_domains,
> > since we no longer need to be able to modify it.
> > 
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Cc: Stefan Agner <stefan@agner.ch>
> > Cc: Lucas Stach <l.stach@pengutronix.de>
> > Cc: linux-arm-kernel at lists.infradead.org
> > Cc: linux-kernel at vger.kernel.org
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> 
> Applied both, thanks.

I decided to drop these two patches.  Triggered by Fabio's patch on top
of you changes, I just took another look at them, and found that
platform_device_add_data() can help us do the same thing in a nicer way.

Shawn

[1] https://patchwork.kernel.org/patch/10274969/
