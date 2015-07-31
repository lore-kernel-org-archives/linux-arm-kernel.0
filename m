From: balbi@ti.com (Felipe Balbi)
Date: Fri, 31 Jul 2015 10:58:10 -0500
Subject: [PATCH v5 02/46] usb: gadget: add endpoint capabilities flags
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D1CB71091@AcuExch.aculab.com>
References: <1438351258-31578-1-git-send-email-r.baldyga@samsung.com>
 <1438351258-31578-3-git-send-email-r.baldyga@samsung.com>
 <063D6719AE5E284EB5DD2968C1650D6D1CB71091@AcuExch.aculab.com>
Message-ID: <20150731155810.GI31041@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jul 31, 2015 at 03:51:52PM +0000, David Laight wrote:
> From: Robert Baldyga
> > Sent: 31 July 2015 15:00
> > Introduce struct usb_ep_caps which contains information about capabilities
> > of usb endpoints - supported transfer types and directions. This structure
> > should be filled by UDC driver for each of its endpoints, and will be
> > used in epautoconf in new ep matching mechanism which will replace ugly
> > guessing of endpoint capabilities basing on its name.
> > 
> > Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
> > ---
> >  include/linux/usb/gadget.h | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> > 
> > diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
> > index 68fb5e8..a9a4959 100644
> > --- a/include/linux/usb/gadget.h
> > +++ b/include/linux/usb/gadget.h
> > @@ -141,10 +141,29 @@ struct usb_ep_ops {
> >  };
> ...
> > +struct usb_ep_caps {
> > +	unsigned type_control:1;
> > +	unsigned type_iso:1;
> > +	unsigned type_bulk:1;
> > +	unsigned type_int:1;
> > +	unsigned dir_in:1;
> > +	unsigned dir_out:1;
> > +};
> 
> With the way this is used (eg below from 13/46)
> 
> +
> +		if (i == 0) {
> +			ep->ep.caps.type_control = true;
> +		} else {
> +			ep->ep.caps.type_iso = true;
> +			ep->ep.caps.type_bulk = true;
> +			ep->ep.caps.type_int = true;
> +		}
> +
> +		ep->ep.caps.dir_in = true;
> +		ep->ep.caps.dir_out = true;
> 
> I think it would be more obvious if you used a u8 and explicit bitmasks.
> The initialisation (as above) would the be explicitly assigning 'not supported'
> to the other fields.
> The compiler will also generate much better code...

compiler should convert single bit flags into u32 just fine. It's all
static data anyway. Besides, single bit flags allow us to have as many
as we need without ending up with stuff like:

u32 flags;
u32 flags1;
u32 flags2;

etc. Just let the compiler do those conversions for us.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150731/9f5df1e1/attachment.sig>
