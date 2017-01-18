From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 18 Jan 2017 11:49:36 +0100
Subject: [PATCH] pwm: constify pwm_ops structures
In-Reply-To: <1484071926-21582-1-git-send-email-bhumirks@gmail.com>
References: <1484071926-21582-1-git-send-email-bhumirks@gmail.com>
Message-ID: <20170118104936.GJ18989@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 10, 2017 at 11:42:06PM +0530, Bhumika Goyal wrote:
> Declare pwm_ops structures as const as they are only stored in the ops
> field of a pwm_chip structure. This field is of type const struct pwm_ops
> *, so pwm_ops structures having this property can be declared as const.
> Done using Coccinelle:
> 
> @r1 disable optional_qualifier@
> identifier i;
> position p;
> @@
> static struct pwm_ops i at p={...};
> 
> @ok1@
> identifier r1.i;
> position p;
> struct pxa_pwm_chip pwm;
> struct bfin_pwm_chip bwm;
> struct vt8500_chip vp;
> struct imx_chip icp;
> @@
> (
> pwm.chip.ops=&i at p
> |
> bwm.chip.ops=&i at p
> |
> vp.chip.ops=&i at p
> |
> icp.chip.ops=&i at p
> )
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
> struct pwm_ops i;
> 
> File size details:
> 
>    text	   data	    bss	    dec	    hex	filename
>    1646	    328	      0	   1974	    7b6	drivers/pwm/pwm-imx.o
>    1742	    224	      0	   1966	    7ae	drivers/pwm/pwm-imx.o
> 
>    1941	    296	      0	   2237	    8bd	drivers/pwm/pwm-pxa.o
>    2037	    192	      0	   2229	    8b5	drivers/pwm/pwm-pxa.o
> 
>    1946	    296	      0	   2242	    8c2	drivers/pwm/pwm-vt8500.o
>    2050	    192	      0	   2242	    8c2	drivers/pwm/pwm-vt8500.o
> 
> The drivers/pwm/pwm-bfin.o file did not compile.
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
> ---
> File: drivers/pwm/pwm-bfin.c is not tested
> 
>  drivers/pwm/pwm-bfin.c   | 2 +-
>  drivers/pwm/pwm-imx.c    | 2 +-
>  drivers/pwm/pwm-pxa.c    | 2 +-
>  drivers/pwm/pwm-vt8500.c | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170118/34466a59/attachment-0001.sig>
