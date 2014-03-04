From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Tue, 04 Mar 2014 13:23:20 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAyLzVdIGRyaXZlcnM6IGJ1czogb21hcF9sMzogQ29udmVy?=
 =?UTF-8?B?dCB0byB1c2UgZGV2bV9yZXF1ZXN0X2FuZF9pb3JlbWFwKCk=?=
In-Reply-To: <1393924359.866301359@f148.i.mail.ru>
References: <1393923710-10377-1-git-send-email-peter.ujfalusi@ti.com>
 <1393923710-10377-3-git-send-email-peter.ujfalusi@ti.com>
 <1393924359.866301359@f148.i.mail.ru>
Message-ID: <1393925000.716948505@f148.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

???????,  4 ????? 2014, 13:12 +04:00 ?? Alexander Shiyan <shc_work@mail.ru>:
> ???????,  4 ????? 2014, 11:01 +02:00 ?? Peter Ujfalusi <peter.ujfalusi@ti.com>:
> > We can then remove the iounmap() calls from probe and remove.
> > Since the driver requests the resources via index we can do the mem resource
> > request within a for loop.
> > 
> > Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti>
> > ---
> 
> > +	/* Get mem resources */
> > +	for (i = 0; i < 3; i++) {
> > +		struct resource	*res = platform_get_resource(pdev,
> > +							     IORESOURCE_MEM, i);
> > +		if (!res) {
> > +			dev_err(&pdev->dev, "couldn't find resource %d\n", i);
> > +			return -ENODEV;
> > +		}
> 
> No need to check "res". devm_request_and_ioremap() do all for us.
> 
> > -	l3->l3_base[2] = ioremap(res->start, resource_size(res));
> > -	if (!l3->l3_base[2]) {
> > -		dev_err(&pdev->dev, "ioremap failed\n");
> > -		ret = -ENOMEM;
> > -		goto err2;
> > +		l3->l3_base[i] = devm_request_and_ioremap(&pdev->dev, res);
> > +		if (!l3->l3_base[i]) {
> 
> if (IS_ERR(l3->l3_base[i]))

Ahh, I messed up this with devm_ioremap_resource().
However, if there is reason to use devm_request_and_ioremap() here?

---
