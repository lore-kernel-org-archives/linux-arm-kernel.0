From: will.deacon@arm.com (Will Deacon)
Date: Tue, 25 Feb 2014 10:57:56 +0000
Subject: [BISECTED] ssh - Received disconnect from x.x.x.x: 2: Bad packet
 length 3149594624
In-Reply-To: <530C4C9B.7050104@gmail.com>
References: <52FD08D1.3030405@gmail.com>
 <20140213182105.GN13576@mudshark.cambridge.arm.com>
 <52FD1243.9040706@gmail.com>
 <20140213192909.GO13576@mudshark.cambridge.arm.com>
 <52FE407C.3080002@gmail.com>
 <20140214162458.GF21986@mudshark.cambridge.arm.com>
 <530C4C9B.7050104@gmail.com>
Message-ID: <20140225105756.GB22279@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ivaylo,

On Tue, Feb 25, 2014 at 07:56:11AM +0000, Ivaylo Dimitrov wrote:
> On 14.02.2014 18:24, Will Deacon wrote:
> > You could try putting back the UNALIGNED_ACCESS in net/mac80211/rx.c and
> > commenting out the skb->len = desc->length  - PLCP_HEADER_LENGTH;  line
> > above.
> >
> 
> the following patch
> 
> diff --git a/drivers/net/wireless/ti/wl1251/rx.c 
> b/drivers/net/wireless/ti/wl1251/rx.c
> index 123c4bb..cde0eaf 100644
> --- a/drivers/net/wireless/ti/wl1251/rx.c
> +++ b/drivers/net/wireless/ti/wl1251/rx.c
> @@ -180,7 +180,7 @@ static void wl1251_rx_body(struct wl1251 *wl,
>          wl1251_mem_read(wl, rx_packet_ring_addr, rx_buffer, length);
> 
>          /* The actual length doesn't include the target's alignment */
> -       skb->len = desc->length  - PLCP_HEADER_LENGTH;
> +       skb_trim(skb, desc->length - PLCP_HEADER_LENGTH);
> 
>          fc = (u16 *)skb->data;
> 
> seems to fix the issue, including those "corrupt probe response" 
> messages in dmesg log (I took that 'skb_trim' from the original Nokia 
> kernel). Will send a properly formatted patch shortly.

Good idea -- don't forget to CC linux-wireless, as suggested by Kalle.

Will
