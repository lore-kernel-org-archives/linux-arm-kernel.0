From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 May 2013 18:19:51 +0100
Subject: [PATCHv3 3/3] net: velocity: Add platform device support to
 VIA velocity driver
In-Reply-To: <20130429230450.GA2620@electric-eye.fr.zoreil.com>
References: <1367264772-4557-1-git-send-email-linux@prisktech.co.nz>
 <1367264772-4557-4-git-send-email-linux@prisktech.co.nz>
 <20130429230450.GA2620@electric-eye.fr.zoreil.com>
Message-ID: <20130502171951.GV14496@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 30, 2013 at 01:04:50AM +0200, Francois Romieu wrote:
> Tony Prisk <linux@prisktech.co.nz> :
> [...]
> > +static int velocity_remove(void *pdev, enum velocity_bus_type bustype)
> > +{
> > +	struct net_device *netdev;
> > +	struct velocity_info *vptr;
> > +	int pci = (bustype == BUS_PCI) ? 1 : 0;
> > +
> > +	if (pci)
> > +		netdev = pci_get_drvdata(pdev);
> > +	else
> > +		netdev = platform_get_drvdata(pdev);
> 
> The caller knows how to retrieve the net_device pointer, whence
> the struct velocity_info pointer, whence any bustype dependent
> function pointer to alleviate the "if (pci)" and CONFIG stuff.
> 
> If you are not convinced, please consider turning the void *
> into an union *.

The other thing here is that you can just pass a struct device into
these and retrieve the same driver data via:

	netdev = dev_get_drvdata(dev);

as:

static inline void *platform_get_drvdata(const struct platform_device *pdev)
{
        return dev_get_drvdata(&pdev->dev);
}

static inline void *pci_get_drvdata(struct pci_dev *pdev)
{
        return dev_get_drvdata(&pdev->dev);
}

So there's no need for void * or union nonsense.
