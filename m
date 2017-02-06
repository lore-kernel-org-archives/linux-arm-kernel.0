From: ludovic.desroches@microchip.com (Ludovic Desroches)
Date: Mon, 6 Feb 2017 17:12:32 +0100
Subject: [PATCH] i2c: busses: constify i2c_algorithm structures
In-Reply-To: <1485540377-13686-1-git-send-email-bhumirks@gmail.com>
References: <1485540377-13686-1-git-send-email-bhumirks@gmail.com>
Message-ID: <20170206161232.clrcuw5nsgompwdn@rfolt0960.corp.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 27, 2017 at 11:36:17PM +0530, Bhumika Goyal wrote:
> Declare i2c_algorithm structures as const as they are only stored in the
> algo field of an i2c_adapter structure. This field is of type const, so
> i2c_algorithm structures having this property can be made const too.
> Done using Coccinelle:
> 
> @r disable optional_qualifier@
> identifier i;
> position p;
> @@
> static struct i2c_algorithm i at p={...};
> 
> @ok@
> identifier r.i,x;
> position p;
> struct i2c_adapter adapter;
> struct xlr_i2c_private  priv;
> @@
> (
> adapter.algo=&i at p;
> |
> priv.adap.algo=&i at p;
> )
> 
> @bad@
> position p!={r.p,ok.p};
> identifier r.i;
> @@
> i at p
> 
> @depends on !bad disable optional_qualifier@
> identifier r.i;
> @@
> +const
> struct i2c_algorithm i;
> 
> File size details before and after patching.
> First line of every .o file shows the file size before patching
> and second line shows the size after patching.
> 
>    text	   data	    bss	    dec	    hex	filename
> 
>    9138	   1328	      8	  10474	   28ea	drivers/i2c/busses/i2c-at91.o
>    9178	   1280	      8	  10466	   28e2	drivers/i2c/busses/i2c-at91.o
> 
>    7555	    657	      8	   8220	   201c i2c/busses/i2c-designware-core.o
>    7619	    617	      8	   8244	   2034 i2c/busses/i2c-designware-core.o
> 
>    7240	   2240	    120	   9600	   2580	drivers/i2c/busses/i2c-eg20t.o
>    7304	   2176	    120	   9600	   2580	drivers/i2c/busses/i2c-eg20t.o
> 
>    2399	    248	      8	   2655	    a5f	drivers/i2c/busses/i2c-emev2.o
>    2455	    192	      8	   2655	    a5f	drivers/i2c/busses/i2c-emev2.o
> 
>    3766	    688	      8	   4462	   116e i2c/busses/i2c-imx-lpi2c.o
>    3814	    632	      8	   4454	   1166 i2c/busses/i2c-imx-lpi2c.o
> 
>   11793	   4280	     16	  16089	   3ed9	drivers/i2c/busses/i2c-imx.o
>   11857	   4216	     16	  16089	   3ed9	drivers/i2c/busses/i2c-imx.o
> 
>    4046	    656	      8	   4710	   1266	drivers/i2c/busses/i2c-nforce2.o
>    4110	    592	      8	   4710	   1266	drivers/i2c/busses/i2c-nforce2.o
> 
>    1397	    464	      0	   1861	    745 i2c/busses/i2c-robotfuzz-osif.o
>    1437	    408	      0	   1845	    735 i2c/busses/i2c-robotfuzz-osif.o
> 
>    9622	   1216	     16	  10854	   2a66 i2c/busses/i2c-sh_mobile.o
>    9662	   1160	     16	  10838	   2a56 i2c/busses/i2c-sh_mobile.o
> 
>    4936	    576	      8	   5520	   1590	drivers/i2c/busses/i2c-st.o
>    5000	    512	      8	   5520	   1590	drivers/i2c/busses/i2c-st.o
> 
>    3404	    248	      8	   3660	    e4c i2c/busses/i2c-xgene-slimpro.o
>    3460	    192	      8	   3660	    e4c i2c/busses/i2c-xgene-slimpro.o
> 
>    2741	    600	      8	   3349	    d15	drivers/i2c/busses/i2c-xlp9xx.o
>    2797	    544	      8	   3349	    d15	drivers/i2c/busses/i2c-xlp9xx.o
> 
>    2643	    248	      8	   2899	    b53	drivers/i2c/busses/i2c-xlr.o
>    2707	    192	      8	   2907	    b5b	drivers/i2c/busses/i2c-xlr.o
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
> ---
>  drivers/i2c/busses/i2c-at91.c            | 2 +-

Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>

Regards

Ludovic
