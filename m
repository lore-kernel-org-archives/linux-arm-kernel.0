From: mzoran@crowfest.net (Michael Zoran)
Date: Wed, 01 Mar 2017 17:59:38 -0800
Subject: [PATCH 1/2] staging/vc04_services: initialize cache line size
 properly
In-Reply-To: <20170301225050.1298349-1-arnd@arndb.de>
References: <20170301225050.1298349-1-arnd@arndb.de>
Message-ID: <1488419978.20502.1.camel@crowfest.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

I submitted a change which is in Linux-next now that makes the whole
CACHE_LINE_SIZE macro meaningless.  It now always reads the size from
the DT and errors out with -ENODEV if the property is missing.

I was going to submit a change to delete the macro completely, just
never got to it.

https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit
/drivers/staging/vc04_services/interface?id=6cf1bf636a067eb308cb3a8322b
9d6b1844a075d

On Wed, 2017-03-01 at 23:50 +0100, Arnd Bergmann wrote:
> While debugging another problem I noticed that g_cache_line_size gets
> set
> to sizeof(CACHE_LINE_SIZE), which is sizeof(int) or 4, while
> presumably
> CACHE_LINE_SIZE (e.g. 32) was meant.
> 
> This initializes it the way it was meant.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> ?drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c |
> 2 +-
> ?1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git
> a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
> b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
> index 3aeffcb9c87e..b0e9eb6ff73f 100644
> ---
> a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
> +++
> b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
> @@ -78,7 +78,7 @@ struct vchiq_pagelist_info {
> ?};
> ?
> ?static void __iomem *g_regs;
> -static unsigned int g_cache_line_size = sizeof(CACHE_LINE_SIZE);
> +static unsigned int g_cache_line_size = CACHE_LINE_SIZE;
> ?static unsigned int g_fragments_size;
> ?static char *g_fragments_base;
> ?static char *g_free_fragments;
