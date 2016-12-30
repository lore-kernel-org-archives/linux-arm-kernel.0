From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Fri, 30 Dec 2016 04:06:55 -0800
Subject: [PATCH] drivers: remoteproc: constify rproc_ops structures
In-Reply-To: <1481974176-19912-1-git-send-email-bhumirks@gmail.com>
References: <1481974176-19912-1-git-send-email-bhumirks@gmail.com>
Message-ID: <20161230120655.GB9118@builder>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat 17 Dec 03:29 PST 2016, Bhumika Goyal wrote:

> Declare rproc_ops structures as const as they are only passed as an
> argument to the function rproc_alloc. This argument is of type const, so
> rproc_ops structures having this property can be declared const too.
> Done using Coccinelle:
> 
> @r1 disable optional_qualifier @
> identifier i;
> position p;
> @@
> static struct rproc_ops i at p = {...};
> 
> @ok1@
> identifier r1.i;
> position p;
> @@
> rproc_alloc(...,&i at p,...)
> 
> @bad@
> position p!={r1.p,ok1.p};
> identifier r1.i;
> @@
> i at p
> 
> @depends on !bad disable optional_qualifier@
> identifier r1.i;
> @@
> +const
> struct rproc_ops i;
> 
> File sizes before:
>    text	   data	    bss	    dec	    hex	filename
>    1258	    416	      0	   1674	    68a remoteproc/omap_remoteproc.o
>    2402	    240	      0	   2642	    a52 remoteproc/st_remoteproc.o
>    2064	    272	      0	   2336	    920 remoteproc/st_slim_rproc.o
>    2160	    240	      0	   2400	    960 remoteproc/wkup_m3_rproc.o
> 
> File sizes after:
>    text	   data	    bss	    dec	    hex	filename
>    1297	    368	      0	   1665	    681 remoteproc/omap_remoteproc.o
>    2434	    192	      0	   2626	    a42 remoteproc/st_remoteproc.o
>    2112	    240	      0	   2352	    930 remoteproc/st_slim_rproc.o
>    2200	    192	      0	   2392	    958 remoteproc/wkup_m3_rproc.o
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>

Thanks Bhumika, this looks good.

But as Suman already asked. Is there any reason why da8xx_remoteproc.c
did not get updated? It looks like the same change would apply there.


Unless I'm missing something, please update the patch and I'll be happy
to apply it.

Regards,
Bjorn
