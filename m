From: pratyush.anand@st.com (Pratyush Anand)
Date: Mon, 23 Jun 2014 10:43:46 +0530
Subject: [PATCH v2 0/8] Add Keystone PCIe controller driver
In-Reply-To: <53A4A4D3.1000908@ti.com>
References: <1402426287-31157-1-git-send-email-m-karicheri2@ti.com>
 <2CC2A0A4A178534D93D5159BF3BCB6619C5F8169D1@EAPEX1MAIL1.st.com>
 <53A4A4D3.1000908@ti.com>
Message-ID: <20140623051346.GC2666@pratyush-vbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 21, 2014 at 05:17:07AM +0800, Murali Karicheri wrote:
> 
> Sorry, my previous response was in html and not sure it has made to the 
> list. I did
> get an error as well. So resending my response.
> 
> On 6/18/2014 6:14 AM, Mohit KUMAR DCG wrote:
> > Hello Murali,
> >
> 

[...]

> *pos = pos0;
> 
> @@ -349,7 +353,10 @@ static int dw_msi_setup_irq(struct msi_chip *chip, 
> struct pci_dev *pdev,
> 
> */
> 
> desc->msi_attrib.multiple = msgvec;
> 
> -msg.address_lo = virt_to_phys((void *)pp->msi_data);
> 
> +if (pp->ops->get_msi_data)
> 
> +msg.address_lo = pp->ops->get_msi_data(pp);
> 
> +else
> 
> +msg.address_lo = virt_to_phys((void *)pp->msi_data);
> 
> msg.address_hi = 0x0;
> 
> msg.data = pos;
> 
> 
> What about this code? This requires get_msi_data() as well

pp->msi_data is set in dw_pcie_msi_init, which is a global function
called from vendor specific code. You can have your own
keystone_pcie_msi_init and then you do not need above changes.

> 
> > -- 3rd to use pp->ops->msi_set/clear if defined.
> Why not API enhancement and refactor the code in a single patch?

Yes, can be. You can send changes in 2 or 3 patches as you wish, but I
believe that should be able to solve problem in best way.

Regards
Pratyush
> 
> Murali
> > Pls let us know for any issue or have different opinion.
> >
> > Regards
> > Mohit
> >
> >
> >
> >   
> >> --
> >> 1.7.9.5
> 
