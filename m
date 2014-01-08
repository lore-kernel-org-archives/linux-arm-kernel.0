From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 08 Jan 2014 16:17:19 +0000
Subject: [RFC 18/18] mfd: vexpress: Split sysreg functions into MFD cells
In-Reply-To: <20140106104030.GI23772@lee--X1>
References: <1387815830-8794-1-git-send-email-pawel.moll@arm.com>
 <1387815830-8794-19-git-send-email-pawel.moll@arm.com>
 <20140106104030.GI23772@lee--X1>
Message-ID: <1389197839.23721.31.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2014-01-06 at 10:40 +0000, Lee Jones wrote:
> > +static struct mfd_cell vexpress_sysreg_cells[] = {
> > +	{
> > +		.name = "syscon",
> > +		.of_compatible = "arm,vexpress-sysreg,sys_id",
> > +		.num_resources = 1,
> > +		.resources = (struct resource []) {
> > +			DEFINE_RES_MEM(SYS_ID, 0x4),
> > +		},
> > +		.platform_data = &vexpress_sysreg_sys_id_pdata,
> > +		.pdata_size = sizeof(vexpress_sysreg_sys_id_pdata),
> 
> Not sure how comfortable I am with using Device Tree and populating
> platform_data with information which by the looks of it you're
> planning to make persistent. What's stopping you from using a DT
> property to name the block, or better yet, just use the compatible
> string? Also, won't naming these blocks in DT also aid other OSes?

Right. This particular of_compatible string in the *_cells is a leftover
from previous versions of the patch. Only the gpio-related ones, as
mentioned in the example:

>  Example:
>         v2m_sysreg: sysreg at 10000000 {
>                 compatible = "arm,vexpress-sysreg";
>                 reg = <0x10000000 0x1000>;
> -               gpio-controller;
> -               #gpio-cells = <2>;
> +
> +               v2m_led_gpios: sys_led at 08 {
> +                       compatible = "arm,vexpress-sysreg,sys_led";
> +                       gpio-controller;
> +                       #gpio-cells = <2>;
> +               };
> +
> +               v2m_mmc_gpios: sys_mci at 48 {
> +                       compatible = "arm,vexpress-sysreg,sys_mci";
> +                       gpio-controller;
> +                       #gpio-cells = <2>;
> +               };
> +
> +               v2m_flash_gpios: sys_flash at 4c {
> +                       compatible = "arm,vexpress-sysreg,sys_flash";
> +                       gpio-controller;
> +                       #gpio-cells = <2>;
> +               };
>         };

are supposed for the sake the gpio users (and some of them don't exist
in some version of the sysregs).

> > +	return mfd_add_devices(&pdev->dev, PLATFORM_DEVID_AUTO,
> > +			vexpress_sysreg_cells,
> > +			ARRAY_SIZE(vexpress_sysreg_cells), mem, 0, 0);
> 
> Don't use 0 as NULL, you will cause a sparse error.

... and rightly so! ;-) Well spotted, thanks!

Pawe?
