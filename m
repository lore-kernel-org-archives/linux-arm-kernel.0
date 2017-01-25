From: b-liu@ti.com (Bin Liu)
Date: Wed, 25 Jan 2017 10:58:15 -0600
Subject: [PATCH] usb: musb: constify musb_hdrc_config structures
In-Reply-To: <1485285742-6949-1-git-send-email-bhumirks@gmail.com>
References: <1485285742-6949-1-git-send-email-bhumirks@gmail.com>
Message-ID: <20170125165815.GA5318@uda0271908>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 25, 2017 at 12:52:22AM +0530, Bhumika Goyal wrote:
> Declare musb_hdrc_config structures as const as they are only stored in
> the config field of a musb_hdrc_platform_data structure. This field is of
> type const, so musb_hdrc_config structures having this property can be
> made const too.
> Done using Coccinelle:
> 
> @r disable optional_qualifier@
> identifier x;
> position p;
> @@
> static struct musb_hdrc_config x at p={...};
> 
> @ok@
> struct musb_hdrc_platform_data pdata;
> identifier r.x;
> position p;
> @@
> pdata.config=&x at p;
> 
> @bad@
> position p != {r.p,ok.p};
> identifier r.x;
> @@
> x at p
> 
> @depends on !bad disable optional_qualifier@
> identifier r.x;
> @@
> +const
> struct musb_hdrc_config x;
> 
> File size before:
>    text	   data	    bss	    dec	    hex	filename
>    1212	    338	      0	   1550	    60e	drivers/usb/musb/jz4740.o
> 
> File size after:
>    text	   data	    bss	    dec	    hex	filename
>    1268	    290	      0	   1558	    616	drivers/usb/musb/jz4740.o
> 
> File size before:
>    text	   data	    bss	    dec	    hex	filename
>    6151	    333	     16	   6500	   1964	drivers/usb/musb/sunxi.o
> 
> File size after:
>    text	   data	    bss	    dec	    hex	filename
>    6215	    269	     16	   6500	   1964	drivers/usb/musb/sunxi.o
> 
> File size before:
>    text	   data	    bss	    dec	    hex	filename
>    3668	    864	      0	   4532	   11b4	drivers/usb/musb/ux500.o
> 
> File size after:
>    text	   data	    bss	    dec	    hex	filename
>    3724	    808	      0	   4532	   11b4	drivers/usb/musb/ux500.o
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>

Hi Greg,

Why you don't want this patch go through my tree? Now it causes me tree
rebase failed. It should be easy to fix, but just wanted to learn your
rules.

Regards,
-Bin.
