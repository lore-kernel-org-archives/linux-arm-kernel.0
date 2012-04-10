From: balbi@ti.com (Felipe Balbi)
Date: Tue, 10 Apr 2012 13:16:11 +0300
Subject: [PATCH RESEND] Input: omap-keypad: dynamically handle register
 offsets
In-Reply-To: <CAKdam56-Pu+WJKLUpodTzOzGuGbAHuqZ3F-zVmrAtFM7EDhxpg@mail.gmail.com>
References: <1333430546-23454-1-git-send-email-sourav.poddar@ti.com>
 <20120410092441.GB20616@arwen.pp.htv.fi>
 <CAKdam56-Pu+WJKLUpodTzOzGuGbAHuqZ3F-zVmrAtFM7EDhxpg@mail.gmail.com>
Message-ID: <20120410101609.GJ20616@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 10, 2012 at 03:37:28PM +0530, Poddar, Sourav wrote:
> Hi Felipe,
> 
> On Tue, Apr 10, 2012 at 2:54 PM, Felipe Balbi <balbi@ti.com> wrote:
> 
>     On Tue, Apr 03, 2012 at 10:52:26AM +0530, Sourav Poddar wrote:
>     > +static int kbd_write_irqstatus(struct omap4_keypad *keypad_data,
>     > +                                             u32 offset, u32 value)
>     > +{
>     > +     return __raw_writel(value, keypad_data->base + offset);
>     > +}
>     > +
>     > +static int kbd_write_irqenable(struct omap4_keypad *keypad_data,
>     > +                                             u32 offset, u32 value)
>     > +{
>     > +     return __raw_writel(value, keypad_data->base + offset);
>     > +}
> 
>     if this only writes to irqenable, why do you pass offset as an argument?
>     likewise for irqstatus.
>    
> 
> Actually, here the offset is the "irqenable" register addresss offset and
> "irqstatus" register
> address offset from the base address.
> Since, the above two address are different in case of Omap4 and omap5, we are
> passing an offset
> depending on the particular revision of the keyboard selected during probe. 

but you already have those in keypad_data->irqenable/irqstatus right ?
Meaning you can access them directly here and save on the arguments:

static int kbd_write_irqenable(struct omap4_keypad *keypad_data, u32 value)
{
     return __raw_writel(value, keypad_data->base + keypad_data->irqenable);
}


-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120410/02f5a088/attachment.sig>
