From: patrice.chotard@st.com (Patrice CHOTARD)
Date: Mon, 30 Jan 2017 09:41:11 +0000
Subject: [PATCH] i2c: busses: constify i2c_algorithm structures
In-Reply-To: <1485540377-13686-1-git-send-email-bhumirks@gmail.com>
References: <1485540377-13686-1-git-send-email-bhumirks@gmail.com>
Message-ID: <df6a8792-cf84-7738-4a11-9b07d34fc3d7@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01/27/2017 07:06 PM, Bhumika Goyal wrote:
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
>  drivers/i2c/busses/i2c-bfin-twi.c        | 2 +-
>  drivers/i2c/busses/i2c-designware-core.c | 2 +-
>  drivers/i2c/busses/i2c-eg20t.c           | 2 +-
>  drivers/i2c/busses/i2c-emev2.c           | 2 +-
>  drivers/i2c/busses/i2c-imx-lpi2c.c       | 2 +-
>  drivers/i2c/busses/i2c-imx.c             | 2 +-
>  drivers/i2c/busses/i2c-nforce2.c         | 2 +-
>  drivers/i2c/busses/i2c-robotfuzz-osif.c  | 2 +-
>  drivers/i2c/busses/i2c-sh_mobile.c       | 2 +-
>  drivers/i2c/busses/i2c-st.c              | 2 +-
>  drivers/i2c/busses/i2c-xgene-slimpro.c   | 2 +-
>  drivers/i2c/busses/i2c-xlp9xx.c          | 2 +-
>  drivers/i2c/busses/i2c-xlr.c             | 2 +-
>  14 files changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
> index 0b86c61..e4fcb0c 100644
> --- a/drivers/i2c/busses/i2c-at91.c
> +++ b/drivers/i2c/busses/i2c-at91.c
> @@ -820,7 +820,7 @@ static u32 at91_twi_func(struct i2c_adapter *adapter)
>  		| I2C_FUNC_SMBUS_READ_BLOCK_DATA;
>  }
>
> -static struct i2c_algorithm at91_twi_algorithm = {
> +static const struct i2c_algorithm at91_twi_algorithm = {
>  	.master_xfer	= at91_twi_xfer,
>  	.functionality	= at91_twi_func,
>  };
> diff --git a/drivers/i2c/busses/i2c-bfin-twi.c b/drivers/i2c/busses/i2c-bfin-twi.c
> index 29d00c4..9fe942b 100644
> --- a/drivers/i2c/busses/i2c-bfin-twi.c
> +++ b/drivers/i2c/busses/i2c-bfin-twi.c
> @@ -563,7 +563,7 @@ static u32 bfin_twi_functionality(struct i2c_adapter *adap)
>  	       I2C_FUNC_I2C | I2C_FUNC_SMBUS_I2C_BLOCK;
>  }
>
> -static struct i2c_algorithm bfin_twi_algorithm = {
> +static const struct i2c_algorithm bfin_twi_algorithm = {
>  	.master_xfer   = bfin_twi_master_xfer,
>  	.smbus_xfer    = bfin_twi_smbus_xfer,
>  	.functionality = bfin_twi_functionality,
> diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
> index 6d81c56..a62c14c 100644
> --- a/drivers/i2c/busses/i2c-designware-core.c
> +++ b/drivers/i2c/busses/i2c-designware-core.c
> @@ -822,7 +822,7 @@ static u32 i2c_dw_func(struct i2c_adapter *adap)
>  	return dev->functionality;
>  }
>
> -static struct i2c_algorithm i2c_dw_algo = {
> +static const struct i2c_algorithm i2c_dw_algo = {
>  	.master_xfer	= i2c_dw_xfer,
>  	.functionality	= i2c_dw_func,
>  };
> diff --git a/drivers/i2c/busses/i2c-eg20t.c b/drivers/i2c/busses/i2c-eg20t.c
> index 5ce71ce..bdeab01 100644
> --- a/drivers/i2c/busses/i2c-eg20t.c
> +++ b/drivers/i2c/busses/i2c-eg20t.c
> @@ -715,7 +715,7 @@ static u32 pch_i2c_func(struct i2c_adapter *adap)
>  	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL | I2C_FUNC_10BIT_ADDR;
>  }
>
> -static struct i2c_algorithm pch_algorithm = {
> +static const struct i2c_algorithm pch_algorithm = {
>  	.master_xfer = pch_i2c_xfer,
>  	.functionality = pch_i2c_func
>  };
> diff --git a/drivers/i2c/busses/i2c-emev2.c b/drivers/i2c/busses/i2c-emev2.c
> index 96bb4e7..3129127 100644
> --- a/drivers/i2c/busses/i2c-emev2.c
> +++ b/drivers/i2c/busses/i2c-emev2.c
> @@ -347,7 +347,7 @@ static int em_i2c_unreg_slave(struct i2c_client *slave)
>  	return 0;
>  }
>
> -static struct i2c_algorithm em_i2c_algo = {
> +static const struct i2c_algorithm em_i2c_algo = {
>  	.master_xfer = em_i2c_xfer,
>  	.functionality = em_i2c_func,
>  	.reg_slave      = em_i2c_reg_slave,
> diff --git a/drivers/i2c/busses/i2c-imx-lpi2c.c b/drivers/i2c/busses/i2c-imx-lpi2c.c
> index c62b7cd..934f548 100644
> --- a/drivers/i2c/busses/i2c-imx-lpi2c.c
> +++ b/drivers/i2c/busses/i2c-imx-lpi2c.c
> @@ -537,7 +537,7 @@ static u32 lpi2c_imx_func(struct i2c_adapter *adapter)
>  		I2C_FUNC_SMBUS_READ_BLOCK_DATA;
>  }
>
> -static struct i2c_algorithm lpi2c_imx_algo = {
> +static const struct i2c_algorithm lpi2c_imx_algo = {
>  	.master_xfer	= lpi2c_imx_xfer,
>  	.functionality	= lpi2c_imx_func,
>  };
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index 47fc1f1..95ed171 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -1037,7 +1037,7 @@ static u32 i2c_imx_func(struct i2c_adapter *adapter)
>  		| I2C_FUNC_SMBUS_READ_BLOCK_DATA;
>  }
>
> -static struct i2c_algorithm i2c_imx_algo = {
> +static const struct i2c_algorithm i2c_imx_algo = {
>  	.master_xfer	= i2c_imx_xfer,
>  	.functionality	= i2c_imx_func,
>  };
> diff --git a/drivers/i2c/busses/i2c-nforce2.c b/drivers/i2c/busses/i2c-nforce2.c
> index 374b35e..3241bb9 100644
> --- a/drivers/i2c/busses/i2c-nforce2.c
> +++ b/drivers/i2c/busses/i2c-nforce2.c
> @@ -296,7 +296,7 @@ static u32 nforce2_func(struct i2c_adapter *adapter)
>  		I2C_FUNC_SMBUS_BLOCK_DATA : 0);
>  }
>
> -static struct i2c_algorithm smbus_algorithm = {
> +static const struct i2c_algorithm smbus_algorithm = {
>  	.smbus_xfer	= nforce2_access,
>  	.functionality	= nforce2_func,
>  };
> diff --git a/drivers/i2c/busses/i2c-robotfuzz-osif.c b/drivers/i2c/busses/i2c-robotfuzz-osif.c
> index 89d8b41..9c0f52b 100644
> --- a/drivers/i2c/busses/i2c-robotfuzz-osif.c
> +++ b/drivers/i2c/busses/i2c-robotfuzz-osif.c
> @@ -117,7 +117,7 @@ static u32 osif_func(struct i2c_adapter *adapter)
>  	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
>  }
>
> -static struct i2c_algorithm osif_algorithm = {
> +static const struct i2c_algorithm osif_algorithm = {
>  	.master_xfer	= osif_xfer,
>  	.functionality	= osif_func,
>  };
> diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
> index 3d9ebe6..3d75593 100644
> --- a/drivers/i2c/busses/i2c-sh_mobile.c
> +++ b/drivers/i2c/busses/i2c-sh_mobile.c
> @@ -781,7 +781,7 @@ static u32 sh_mobile_i2c_func(struct i2c_adapter *adapter)
>  	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL | I2C_FUNC_PROTOCOL_MANGLING;
>  }
>
> -static struct i2c_algorithm sh_mobile_i2c_algorithm = {
> +static const struct i2c_algorithm sh_mobile_i2c_algorithm = {
>  	.functionality	= sh_mobile_i2c_func,
>  	.master_xfer	= sh_mobile_i2c_xfer,
>  };
> diff --git a/drivers/i2c/busses/i2c-st.c b/drivers/i2c/busses/i2c-st.c
> index 1371547..1eb9fa8 100644
> --- a/drivers/i2c/busses/i2c-st.c
> +++ b/drivers/i2c/busses/i2c-st.c
> @@ -776,7 +776,7 @@ static u32 st_i2c_func(struct i2c_adapter *adap)
>  	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
>  }
>
> -static struct i2c_algorithm st_i2c_algo = {
> +static const struct i2c_algorithm st_i2c_algo = {
>  	.master_xfer = st_i2c_xfer,
>  	.functionality = st_i2c_func,
>  };
> diff --git a/drivers/i2c/busses/i2c-xgene-slimpro.c b/drivers/i2c/busses/i2c-xgene-slimpro.c
> index 0ab1e55..dbe7e44 100644
> --- a/drivers/i2c/busses/i2c-xgene-slimpro.c
> +++ b/drivers/i2c/busses/i2c-xgene-slimpro.c
> @@ -372,7 +372,7 @@ static u32 xgene_slimpro_i2c_func(struct i2c_adapter *adapter)
>  		I2C_FUNC_SMBUS_I2C_BLOCK;
>  }
>
> -static struct i2c_algorithm xgene_slimpro_i2c_algorithm = {
> +static const struct i2c_algorithm xgene_slimpro_i2c_algorithm = {
>  	.smbus_xfer = xgene_slimpro_i2c_xfer,
>  	.functionality = xgene_slimpro_i2c_func,
>  };
> diff --git a/drivers/i2c/busses/i2c-xlp9xx.c b/drivers/i2c/busses/i2c-xlp9xx.c
> index 84a8b2e..66b464d 100644
> --- a/drivers/i2c/busses/i2c-xlp9xx.c
> +++ b/drivers/i2c/busses/i2c-xlp9xx.c
> @@ -334,7 +334,7 @@ static u32 xlp9xx_i2c_functionality(struct i2c_adapter *adapter)
>  		I2C_FUNC_10BIT_ADDR;
>  }
>
> -static struct i2c_algorithm xlp9xx_i2c_algo = {
> +static const struct i2c_algorithm xlp9xx_i2c_algo = {
>  	.master_xfer = xlp9xx_i2c_xfer,
>  	.functionality = xlp9xx_i2c_functionality,
>  };
> diff --git a/drivers/i2c/busses/i2c-xlr.c b/drivers/i2c/busses/i2c-xlr.c
> index ad17d88..484bfa1 100644
> --- a/drivers/i2c/busses/i2c-xlr.c
> +++ b/drivers/i2c/busses/i2c-xlr.c
> @@ -335,7 +335,7 @@ static u32 xlr_func(struct i2c_adapter *adap)
>  	return (I2C_FUNC_SMBUS_EMUL & ~I2C_FUNC_SMBUS_QUICK) | I2C_FUNC_I2C;
>  }
>
> -static struct i2c_algorithm xlr_i2c_algo = {
> +static const struct i2c_algorithm xlr_i2c_algo = {
>  	.master_xfer	= xlr_i2c_xfer,
>  	.functionality	= xlr_func,
>  };
>

Hi

for i2c-st:

Acked-by: Patrice Chotard <patrice.chotard@st.com>

Thanks
