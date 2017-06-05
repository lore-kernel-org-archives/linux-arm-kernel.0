From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 5 Jun 2017 11:36:52 +0200
Subject: [PATCH v2] misc: atmel-ssc: Handle return value of
 clk_prepare_enable and clk_prepare
In-Reply-To: <aa38479b-0597-17ca-ab2b-1092ece77d11@gmail.com>
References: <3a6a9ccd68fe298ab33009eaaace85c5af73e1ea.1496381884.git.arvind.yadav.cs@gmail.com>
 <20170603221753.lfiqthuc7dxy3dmc@piout.net>
 <aa38479b-0597-17ca-ab2b-1092ece77d11@gmail.com>
Message-ID: <20170605093652.4dpeb2ovjehfsxwl@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/06/2017 at 14:53:30 +0530, Arvind Yadav wrote:
> Hi,
> 
> Yes, Patch v1 was wrong that's why i have push v2.
> clk_prepare and clk_prepare_enable can fail. There

No this is not true, they will never fail for the SSC.

> is not harm to check it's return value. It'll not impact present
> functionality.
> 

It does impact boot time, this patch adds 112 bytes to a compressed
kernel for no reason.

> -arvind
> 
> On Sunday 04 June 2017 03:47 AM, Alexandre Belloni wrote:
> > Hi,
> > 
> > It is getting tiring to get patches that are nor even compile tested
> > resulting from whatever static analysis tool you used.
> > 
> > This patch has almost no value and v1 was clearly wrong.
> > 
> > Do you realize clk_prepare and clk_prepare_enable will never fail for
> > the SSC?
> > 
> > On 02/06/2017 at 11:09:02 +0530, Arvind Yadav wrote:
> > > clk_prepare_enable() and clk_prepare() can fail here and
> > > we must check its return value.
> > > 
> > > Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> > > ---
> > >   drivers/misc/atmel-ssc.c | 12 ++++++++++--
> > >   1 file changed, 10 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/misc/atmel-ssc.c b/drivers/misc/atmel-ssc.c
> > > index b2a0340..df34b81 100644
> > > --- a/drivers/misc/atmel-ssc.c
> > > +++ b/drivers/misc/atmel-ssc.c
> > > @@ -30,6 +30,7 @@ struct ssc_device *ssc_request(unsigned int ssc_num)
> > >   {
> > >   	int ssc_valid = 0;
> > >   	struct ssc_device *ssc;
> > > +	int ret;
> > >   	spin_lock(&user_lock);
> > >   	list_for_each_entry(ssc, &ssc_list, list) {
> > > @@ -60,7 +61,11 @@ struct ssc_device *ssc_request(unsigned int ssc_num)
> > >   	ssc->user++;
> > >   	spin_unlock(&user_lock);
> > > -	clk_prepare(ssc->clk);
> > > +	ret = clk_prepare(ssc->clk);
> > > +	if (ret) {
> > > +		pr_err("Failed to prepare clock\n");
> > > +		return ERR_PTR(ret);
> > > +	}
> > >   	return ssc;
> > >   }
> > > @@ -195,6 +200,7 @@ static int ssc_probe(struct platform_device *pdev)
> > >   	struct resource *regs;
> > >   	struct ssc_device *ssc;
> > >   	const struct atmel_ssc_platform_data *plat_dat;
> > > +	int ret;
> > >   	ssc = devm_kzalloc(&pdev->dev, sizeof(struct ssc_device), GFP_KERNEL);
> > >   	if (!ssc) {
> > > @@ -229,7 +235,9 @@ static int ssc_probe(struct platform_device *pdev)
> > >   	}
> > >   	/* disable all interrupts */
> > > -	clk_prepare_enable(ssc->clk);
> > > +	ret = clk_prepare_enable(ssc->clk);
> > > +	if (ret)
> > > +		return ret;
> > >   	ssc_writel(ssc->regs, IDR, -1);
> > >   	ssc_readl(ssc->regs, SR);
> > >   	clk_disable_unprepare(ssc->clk);
> > > -- 
> > > 1.9.1
> > > 
> > > 
> > > _______________________________________________
> > > linux-arm-kernel mailing list
> > > linux-arm-kernel at lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
