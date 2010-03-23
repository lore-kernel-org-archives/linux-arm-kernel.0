From: avictor.za@gmail.com (Andrew Victor)
Date: Tue, 23 Mar 2010 22:26:39 +0200
Subject: [patch v3 2/3] at91_udc HW glitch
In-Reply-To: <20100203143803.528679118@gmail.com>
References: <20100203143736.564974126@gmail.com>
	<20100203143803.528679118@gmail.com>
Message-ID: <cd73a99e1003231326r7623bbc0icba163f9b2e0e96e@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi,

> Add some delay to avoid reading CSR TXCOUNT too early after updating it.
>
> Signed-off-by: Anti Sullin <anti.sullin@artecdesign.ee>
> Signed-off-by: Harro Haan <hrhaan@gmail.com>
> Acked-by: Remy Bohmer <linux@bohmer.net>
> ---
>  drivers/usb/gadget/at91_udc.c |    7 +++++++
>  1 file changed, 7 insertions(+)
>
> Index: linux-2.6.31/drivers/usb/gadget/at91_udc.c
> ===================================================================
> --- linux-2.6.31.orig/drivers/usb/gadget/at91_udc.c
> +++ linux-2.6.31/drivers/usb/gadget/at91_udc.c
> @@ -366,6 +366,13 @@ rescan:
>        if (is_done)
>                done(ep, req, 0);
>        else if (ep->is_pingpong) {
> +               /*
> +                * One dummy read to delay the code because of a HW glitch:
> +                * CSR returns bad RXCOUNT when read too soon after updating
> +                * RX_DATA_BK flags.
> +                */
> +               csr = __raw_readl(creg);
> +
>                bufferspace -= count;
>                buf += count;
>                goto rescan;

I see in the data-sheet (SAM9261 / SAM9263), the following for the
UDP_ CSRx registers:

"WARNING: Due to synchronization between MCK and UDPCK, the software
application must wait for the end of the write
operation before executing another write by polling the bits which
must be set/cleared."

//! Clear flags of UDP UDP_CSR register and waits for synchronization
#define Udp_ep_clr_flag(pInterface, endpoint, flags) { \
    while (pInterface->UDP_CSR[endpoint] & (flags)) \
        pInterface->UDP_CSR[endpoint] &= ~(flags); \
     }
//! Set flags of UDP UDP_CSR register and waits for synchronization
#define Udp_ep_set_flag(pInterface, endpoint, flags) { \
    while ( (pInterface->UDP_CSR[endpoint] & (flags)) != (flags) ) \
       pInterface->UDP_CSR[endpoint] |= (flags); \
    }

The at91_udc driver does not seem to do that for its CSR register writes.
So I was wondering if we implement what the datasheet says, would we
still need the "fix" above.


Regards,
  Andrew Victor
