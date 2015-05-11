From: balbi@ti.com (Felipe Balbi)
Date: Mon, 11 May 2015 10:58:46 -0500
Subject: [PATCH v2 04/13] musb: Do not use musb_read[b|w] / _write[b|w]
 wrappers in generic fifo functions
In-Reply-To: <1426878682-14521-5-git-send-email-hdegoede@redhat.com>
References: <1426878682-14521-1-git-send-email-hdegoede@redhat.com>
 <1426878682-14521-5-git-send-email-hdegoede@redhat.com>
Message-ID: <20150511155846.GH19476@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 20, 2015 at 08:11:13PM +0100, Hans de Goede wrote:
> The generic fifo functions already use non wrapped accesses in various
> cases through the iowrite#_rep functions, and all platforms which override
> the default musb_read[b|w] / _write[b|w] functions also provide their own
> fifo access functions, so we can safely drop the unnecessary indirection
> from the fifo access functions.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/usb/musb/musb_core.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> index 01ed3a6..016b5b9 100644
> --- a/drivers/usb/musb/musb_core.c
> +++ b/drivers/usb/musb/musb_core.c
> @@ -313,7 +313,7 @@ static void musb_default_write_fifo(struct musb_hw_ep *hw_ep, u16 len,
>  				index += len & ~0x03;
>  			}
>  			if (len & 0x02) {
> -				musb_writew(fifo, 0, *(u16 *)&src[index]);
> +				__raw_writew(*(u16 *)&src[index], fifo);

not all architectures provide __raw_* accessors, right ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150511/f1c8d3bc/attachment.sig>
