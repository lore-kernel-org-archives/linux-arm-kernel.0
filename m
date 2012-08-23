From: b29396@freescale.com (Dong Aisheng)
Date: Thu, 23 Aug 2012 15:06:58 +0800
Subject: [PATCH 1/7] mfd: add imx syscon driver based on regmap
In-Reply-To: <5035BCB1.8000801@wwwdotorg.org>
References: <1345619928-15446-1-git-send-email-b29396@freescale.com>
 <1345619928-15446-2-git-send-email-b29396@freescale.com>
 <20120822082940.GJ4011@b20223-02.ap.freescale.net>
 <20120822105729.GB10057@shlinux2.ap.freescale.net>
 <5035BCB1.8000801@wwwdotorg.org>
Message-ID: <20120823070657.GE10057@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 23, 2012 at 01:16:33PM +0800, Stephen Warren wrote:
> On 08/22/2012 04:57 AM, Dong Aisheng wrote:
> > On Wed, Aug 22, 2012 at 04:29:41PM +0800, Zhao Richard-B20223 wrote:
> >> On Wed, Aug 22, 2012 at 03:18:42PM +0800, Dong Aisheng wrote:
> >>> Add regmap based imx syscon driver.
> >>> This is usually used for access misc bits in registers which does not belong
> >>> to a specific module, for example, IOMUXC GPR and ANATOP.
> >>> With this driver, we provide a standard API for client driver to call to
> >>> access registers which are registered into syscon.
> 
> >>> +static int imx_syscon_match(struct device *dev, void *data)
> >>> +{
> >>> +	struct imx_syscon *syscon = dev_get_drvdata(dev);
> >>> +	struct device_node *dn = data;
> >>> +
> >>> +	return (syscon->dev->of_node == dn) ? 1 : 0;
> >>> +}
> >>> +
> >>> +int imx_syscon_write(struct device_node *np, u32 reg, u32 val)
> >>
> >> For API function, is it better to use struct device rather not np?
> >>  - it won't need to search dev in below code every time it access
> >>    registers.
> >
> > The purpose is not require client driver to know the implementation details
> > of imx_syscon_{read/write} API, it's more easy to use since client only
> > needs pass the device node to which it wants to read/write.
> > 
> > For search dev, it doesn't look like a big issue since it only search devices
> > attached on the driver which is very quick.
> > And hide it in common API does not require every client driver to write
> > duplicated codes.
> 
> You could still implement a function:
> 
> struct device *imx_syscon_lookup(struct device_node *np)
> 
> ... and require all clients to call that, and pass the dev to the other
> functions. That'd still keep all the lookup code in one place, but
> prevent it having to run every time, no matter how small it is.
> 
> I think such an API is required anyway, since client drivers need some
> way to determine whether the imx_syscon driver is available yet, and if
> not defer their probe until it is.
> 
> So, clients would do:
> 
> foo->syscon_dev = imx_syscon_lookup(np);
> if (!foo->syscon_dev)
>     return -EPROBE_DEFER;
> 
> rather than:
> 
> foo->syscon_np = np;
> 
> Not too much overhead/boiler-plate in each client driver.
> 
Looks like a good idea.

Regards
Dong Aisheng
