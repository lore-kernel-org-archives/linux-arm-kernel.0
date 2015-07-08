From: mina86@mina86.com (Michal Nazarewicz)
Date: Wed, 08 Jul 2015 15:45:43 +0200
Subject: [PATCH v2 2/5] usb: gadget: midi: avoid redundant
 f_midi_set_alt() call
In-Reply-To: <1436346323-31593-3-git-send-email-r.baldyga@samsung.com>
References: <1436346323-31593-1-git-send-email-r.baldyga@samsung.com>
 <1436346323-31593-3-git-send-email-r.baldyga@samsung.com>
Message-ID: <xa1tfv4ydapk.fsf@mina86.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 08 2015, Robert Baldyga wrote:
> Function midi registers two interfaces with single set_alt() function
> which means that f_midi_set_alt() is called twice when configuration
> is set. That means that endpoint initialization and ep request allocation
> is done two times. To avoid this problem we do such things only once,
> for interface number 1 (MIDI Streaming interface).
>
> Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>

Acked-by: Michal Nazarewicz <mina86@mina86.com>

> ---
>  drivers/usb/gadget/function/f_midi.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/usb/gadget/function/f_midi.c b/drivers/usb/gadget/function/f_midi.c
> index 6316aa5..4cef222 100644
> --- a/drivers/usb/gadget/function/f_midi.c
> +++ b/drivers/usb/gadget/function/f_midi.c
> @@ -329,6 +329,10 @@ static int f_midi_set_alt(struct usb_function *f, unsigned intf, unsigned alt)
>  	unsigned i;
>  	int err;
>  
> +	/* For Control Device interface we do nothing */
> +	if (intf == 0)
> +		return 0;
> +
>  	err = f_midi_start_ep(midi, f, midi->in_ep);
>  	if (err)
>  		return err;
> -- 
> 1.9.1
>

-- 
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=./ `o
..o | Computer Science,  Micha? ?mina86? Nazarewicz    (o o)
ooo +--<mpn@google.com>--<xmpp:mina86@jabber.org>--ooO--(_)--Ooo--
