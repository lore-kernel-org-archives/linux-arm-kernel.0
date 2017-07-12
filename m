From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 12 Jul 2017 10:34:29 +0100
Subject: [bug report] perf: xgene: Add APM X-Gene SoC Performance
 Monitoring Unit driver
In-Reply-To: <CACgAJHyNp25-Gf+mX0L5z3nt7atrowpooE6mUTGtY1dc_3nZXQ@mail.gmail.com>
References: <20170711114327.hezq3anev6bzxqz7@mwanda>
 <CACgAJHyNp25-Gf+mX0L5z3nt7atrowpooE6mUTGtY1dc_3nZXQ@mail.gmail.com>
Message-ID: <20170712093428.GB7472@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jul 11, 2017 at 03:48:06PM -0700, Tai Tri Nguyen wrote:
> On Tue, Jul 11, 2017 at 4:43 AM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > The patch 832c927d119b: "perf: xgene: Add APM X-Gene SoC Performance
> > Monitoring Unit driver" from Jul 15, 2016, leads to the following
> > static checker warning:
> >
> >         drivers/perf/xgene_pmu.c:1922 xgene_pmu_probe()
> >         warn: 'xgene_pmu->pcppmu_csr' is an error pointer or valid

> >   1869          if (IS_ERR(xgene_pmu->pcppmu_csr)) {
> >   1870                  dev_err(&pdev->dev, "ioremap failed for PCP PMU resource\n");
> >   1871                  rc = PTR_ERR(xgene_pmu->pcppmu_csr);
> >   1872                  goto err;
> >                         ^^^^^^^^
> > If we hit this goto then the kernel will crash.
> >
> >   1873          }
> >
> >     [ snip ]
> >
> >   1916          /* Enable interrupt */
> >   1917          xgene_pmu->ops->unmask_int(xgene_pmu);
> >   1918
> >   1919          return 0;
> >   1920
> >   1921  err:
> >   1922          if (xgene_pmu->pcppmu_csr)
> >   1923                  devm_iounmap(&pdev->dev, xgene_pmu->pcppmu_csr);
> >   1924          devm_kfree(&pdev->dev, xgene_pmu);
> >
> > Can't we remove all this cleanup since it's devm_ managed resources?
> 
> Yes, you are right.
> We can remove all this cleanup and also others because these managed
> resources are automatically freed/unmapped on driver detach.
> 
> Hi Mark,
> 
> If you agree, I can post a patch to fix the issue.

Yes please.

Mark.
