From: mw@semihalf.com (Marcin Wojtas)
Date: Tue, 23 Jan 2018 07:12:49 +0100
Subject: [net-next: PATCH v4 1/7] device property: Introduce
 fwnode_get_mac_address()
In-Reply-To: <CAJZ5v0j=4Lvaf49oeDqVmYP5nyAs-E9E8xdgyfL7=J_46X5TMA@mail.gmail.com>
References: <1516278704-17141-1-git-send-email-mw@semihalf.com>
 <1516278704-17141-2-git-send-email-mw@semihalf.com>
 <CAJZ5v0j=4Lvaf49oeDqVmYP5nyAs-E9E8xdgyfL7=J_46X5TMA@mail.gmail.com>
Message-ID: <CAPv3WKf0GUE508P8k1nExBA+h6pQr4UcaFPk+mps3xRepESQmw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rafael,

> >         if (res)
> >                 return res;
> >
> > -       return device_get_mac_addr(dev, "address", addr, alen);
> > +       return fwnode_get_mac_addr(fwnode, "address", addr, alen);
> > +}
> > +EXPORT_SYMBOL(fwnode_get_mac_address);
>
> That should be EXPORT_SYMBOL_GPL().
>
> I have overlooked that previously, sorry about that.

The series landed yesterday in net-next, so I need to send a fix on
top. Would you be ok with single patch fixing all EXPORT_SYMBOL()
occurences? Those would be 2 new routines:
- fwnode_get_mac_address
- fwnode_irq_get
and  2 already existing in the file:
- device_get_mac_address
- fwnode_graph_parse_endpoint

Please let know, how you prefer to handle it?

Best regards,
Marcin

>
> > +
> > +/**
> > + * device_get_mac_address - Get the MAC for a given device
> > + * @dev:       Pointer to the device
> > + * @addr:      Address of buffer to store the MAC in
> > + * @alen:      Length of the buffer pointed to by addr, should be ETH_ALEN
> > + */
> > +void *device_get_mac_address(struct device *dev, char *addr, int alen)
> > +{
> > +       return fwnode_get_mac_address(dev_fwnode(dev), addr, alen);
> >  }
> >  EXPORT_SYMBOL(device_get_mac_address);
>
> Same here.
>
> Generally speaking, you should use EXPORT_SYMBOL_GPL() everywhere
> unless there's a specific reason for not doing that in which cases
> that specific reason has to be clearly spelled out at least in the
> changelog of the patch, but really better in a code comment.
>
> >
> > diff --git a/include/linux/property.h b/include/linux/property.h
> > index f6189a3..35620e0 100644
> > --- a/include/linux/property.h
> > +++ b/include/linux/property.h
> > @@ -279,6 +279,8 @@ int device_get_phy_mode(struct device *dev);
> >
> >  void *device_get_mac_address(struct device *dev, char *addr, int alen);
> >
> > +void *fwnode_get_mac_address(struct fwnode_handle *fwnode,
> > +                            char *addr, int alen);
> >  struct fwnode_handle *fwnode_graph_get_next_endpoint(
> >         const struct fwnode_handle *fwnode, struct fwnode_handle *prev);
> >  struct fwnode_handle *
> > --
