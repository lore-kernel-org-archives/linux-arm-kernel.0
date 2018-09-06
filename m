From: MNARANI@xilinx.com (Manish Narani)
Date: Thu, 6 Sep 2018 15:53:54 +0000
Subject: [PATCH v5 1/4] edac: synps: Add platform specific structures for
 ddrc controller
In-Reply-To: <20180904165828.GM32615@zn.tnic>
References: <1535722070-10394-1-git-send-email-manish.narani@xilinx.com>
 <1535722070-10394-2-git-send-email-manish.narani@xilinx.com>
 <20180904165828.GM32615@zn.tnic>
Message-ID: <DM6PR02MB522730A32310C1CBB2971B61C1010@DM6PR02MB5227.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

Thanks a lot for the review. Please see my comments inline.

> -----Original Message-----
> From: Borislav Petkov [mailto:bp at alien8.de]
> Sent: Tuesday, September 4, 2018 10:28 PM
> To: Manish Narani <MNARANI@xilinx.com>
> Cc: robh+dt at kernel.org; mark.rutland at arm.com; Michal Simek
> <michals@xilinx.com>; mchehab at kernel.org; leoyang.li at nxp.com;
> amit.kucheria at linaro.org; olof at lixom.net; Srinivas Goud <sgoud@xilinx.com>;
> Anirudha Sarangi <anirudh@xilinx.com>; linux-kernel at vger.kernel.org;
> devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-
> edac at vger.kernel.org
> Subject: Re: [PATCH v5 1/4] edac: synps: Add platform specific structures for
> ddrc controller
> 
> On Fri, Aug 31, 2018 at 06:57:47PM +0530, Manish Narani wrote:
> > Add platform specific structures, so that we can add different IP
> > support later using quirks.
> >
> > Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> > ---
> >  drivers/edac/synopsys_edac.c | 78
> > +++++++++++++++++++++++++++++++++-----------
> >  1 file changed, 59 insertions(+), 19 deletions(-)
> >
> > diff --git a/drivers/edac/synopsys_edac.c
> > b/drivers/edac/synopsys_edac.c index 0c9c59e..2470d35 100644
> > --- a/drivers/edac/synopsys_edac.c
> > +++ b/drivers/edac/synopsys_edac.c
> >
> >  /**
> > + * struct synps_platform_data -  synps platform data structure
> > + * @edac_geterror_info:	function pointer to synps edac error info
> > + * @edac_get_mtype:	function pointer to synps edac mtype
> > + * @edac_get_dtype:	function pointer to synps edac dtype
> > + * @edac_get_eccstate:	function pointer to synps edac eccstate
> > + * @quirks:		to differentiate IPs
> 
> Kill all that "function pointer" fluff. Here's how I've changed it:
> 
> /**
>  * struct synps_platform_data -  synps platform data structure
>  * @edac_geterror_info: edac error info
>  * @edac_get_mtype:     get mtype
>  * @edac_get_dtype:     get dtype
>  * @edac_get_eccstate:  get ECC state
>  * @quirks:             to differentiate IPs
>  */
> 
> Shorter, quicker to read/scan/etc...

Okay. I will update this way throughout all the patches.

> 
> > +/**
> >   * synps_edac_geterror_info - Get the current ecc error info
> > - * @base:	Pointer to the base address of the ddr memory controller
> > - * @p:		Pointer to the synopsys ecc status structure
> > + * @priv:	Pointer to DDR memory controller private instance data
> >   *
> >   * Determines there is any ecc error or not
> 
> All sentences end with a fullstop. Check all your patches.

Okay.

> 
> Also, it is not "ecc" it is "ECC". Also go over all your patches.

Okay. I updated this in (3/4), but I will update this as a separate patch in v6.

> 
> >   *
> >   * Return: one if there is no error otherwise returns zero
> >   */
> > -static int synps_edac_geterror_info(void __iomem *base,
> > -				    struct synps_ecc_status *p)
> > +static int synps_edac_geterror_info(struct synps_edac_priv *priv)
> >  {
> > +	void __iomem *base;
> > +	struct synps_ecc_status *p;
> >  	u32 regval, clearval = 0;
> 
> Please sort function local variables declaration in a reverse christmas tree
> order:
> 
> 	<type> longest_variable_name;
> 	<type> shorter_var_name;
> 	<type> even_shorter;
> 	<type> i;
> 

Okay.

> >
> > +	if (!priv)
> > +		return 1;
> 
> Why are you even checking this here?
> 
> synps_edac_check() is merrily dereferencing it - if anything we will explode
> there already.

Okay. I will remove this in v6.

> 
> >
> > @@ -370,12 +398,12 @@ static int synps_edac_init_csrows(struct
> > mem_ctl_info *mci)
> 
> That function returns 0 unconditionally. Make it a void in a prepatch.

Sure.

> 
> > -	if (!synps_edac_get_eccstate(baseaddr)) {
> > +	p_data = of_device_get_match_data(&pdev->dev);
> > +	if (!(p_data->edac_get_eccstate(baseaddr))) {
> 
> Too many parentheses:
> 
> 	if (!p_data->...
> 
> is enough.

Okay.


Thanks,
Manish Narani
