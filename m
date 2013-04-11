From: andrew.murray@arm.com (Andrew Murray)
Date: Thu, 11 Apr 2013 13:12:42 +0100
Subject: [PATCH v5 1/3] of/pci: Unify pci_process_bridge_OF_ranges from
 Microblaze and PowerPC
In-Reply-To: <20130410233330.4e9479b0@skate>
References: <1365578969-30966-1-git-send-email-Andrew.Murray@arm.com>
 <1365578969-30966-2-git-send-email-Andrew.Murray@arm.com>
 <20130410233330.4e9479b0@skate>
Message-ID: <20130411121242.GB28981@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 10, 2013 at 10:33:30PM +0100, Thomas Petazzoni wrote:
> Dear Andrew Murray,
> 
> On Wed, 10 Apr 2013 08:29:26 +0100, Andrew Murray wrote:
> 
> > diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
> > index bb115de..6852481 100644
> > --- a/include/linux/of_pci.h
> > +++ b/include/linux/of_pci.h
> > @@ -11,4 +11,7 @@ struct device_node;
> >  struct device_node *of_pci_find_child_device(struct device_node *parent,
> >  					     unsigned int devfn);
> >  
> > +void pci_process_bridge_OF_ranges(struct pci_controller *hose,
> > +			struct device_node *dev, int primary);
> > +
> >  #endif
> 
> In this file, 'struct pci_controller' is not defined anywhere, and not
> in any header file that is included. So I get a warning at compile time
> when <linux/of_pci.h> is included, but nothing has defined 'struct
> pci_controller' beforehand. So I think this file should carry a change
> like:
> 
> +struct pci_controller;
> 
> In my version of the patch I added it, see:
> 
> diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
> index bb115de..e56182f 100644
> --- a/include/linux/of_pci.h
> +++ b/include/linux/of_pci.h
> @@ -4,6 +4,7 @@
>  #include <linux/pci.h>
>  
>  struct pci_dev;
> +struct pci_controller;
>  struct of_irq;
>  int of_irq_map_pci(const struct pci_dev *pdev, struct of_irq *out_irq);
>  
> @@ -11,4 +12,7 @@ struct device_node;
>  struct device_node *of_pci_find_child_device(struct device_node *parent,
>  					     unsigned int devfn);
>  
> +void pci_process_bridge_OF_ranges(struct pci_controller *hose,
> +			struct device_node *dev, int primary);
> +
>  #endif
> 
> But otherwise, for PATCH 1/3 and 2/3,

Thanks - I somehow missed this.

I've included this change in my next respin - but I've put
'struct pci_controller' immediately before 'pci_process_bridge_OF_ranges'
rather than above of_irq_map_pci to be consistent with the rest of the file.

Andrew Murray


> 
> Tested-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> 
> Thomas
> -- 
> Thomas Petazzoni, Free Electrons
> Kernel, drivers, real-time and embedded Linux
> development, consulting, training and support.
> http://free-electrons.com
> 
