From: grinberg@compulab.co.il (Igor Grinberg)
Date: Tue, 14 Sep 2010 09:42:26 +0200
Subject: gadget pxa25x_udc g_serial stall problem
In-Reply-To: <4C8E5DF1.9020207@gmail.com>
References: <4C8E5DF1.9020207@gmail.com>
Message-ID: <4C8F2762.4010105@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 cc'ed LAKML

On 09/13/10 19:22, Quintin Pitts wrote:
> Hi all,
>
> I'm using linux 2.6.34.1 getting code to work with ViewSonic V210/V110
> platform - pxa255/pxa250 processor.
>
> Under 2.6.34.1 for a arm pxa255 processor, was having a problem getting
> g_serial to work with out stalling on output lines longer than 64 bytes.
>
> Problem was that any command - like free, ls -l etc... would hang from a
> connected minicom session.
>
> Able to log in OK and do small commands that would send less than 64
> bytes at a time.
>
> But anything over 64 bytes of output per line would hang/stall.  No
> output to the connected computer session. (ep1in-bulk no more output).
>
> Debugging logs with additional information (list_empty and ep->stopped
> added to message) reported on a free command - produced this for logs.
>
> [  652.983793] gs_write: ttyGS0 (c0456000) writing 2 bytes
> [  653.000699] ttyGS0: tx len=2, 0x0d 0x0a 0x73 ...
> [  653.017493] udc: ep1in-bulk queue req c04768c0, len 2 buf c0476900 list_empty 1 ep->stopped 0
> [  653.038368] udc: wrote ep1in-bulk 2 bytes/L/S 0 left c04768c0
> [  653.056191] gs_flush_chars: (0,c0456000)
> [  653.093561] gs_write_room: (0,c0456000) room=8191
> [  653.111007] gs_write: ttyGS0 (c0456000) writing 71 bytes
>
> Here is the first partial line coming over.
> [  653.128571] ttyGS0: tx len=64, 0x20 0x20 0x20 ...
> [  653.145391] udc: ep1in-bulk queue req c04768c0, len 64 buf c0476900 list_empty 1 ep->stopped 0
>
> write fifo - good 64 bytes
> [  653.166609] udc: wrote ep1in-bulk 64 bytes/L 0 left c04768c0
> [  653.184456] ttyGS0: tx len=7, 0x62 0x75 0x66 ...
> [  653.201211] udc: ep1in-bulk queue req c04768c0, len 7 buf c0476900 list_empty 1 ep->stopped 1
>
> Problem additional 7 chars and ep->stopped   - pio_irq never gets
> enabled after it has been disabled.
>
> After this point no more data output (ep1in-bulk) is sent.
>
> [  653.234600] gs_write_room: (0,c0456000) room=8191
> [  653.252453] gs_write: ttyGS0 (c0456000) writing 2 bytes
> [  653.270258] ttyGS0: tx len=2, 0x0d 0x0a 0x47 ...
> [  653.288050] udc: ep1in-bulk queue req c0476840, len 2 buf c0476880 list_empty 0 ep->stopped 0
> [  653.309317] gs_flush_chars: (0,c0456000)
> [  653.333737] gs_write_room: (0,c0456000) room=8191
> [  653.351545] gs_write: ttyGS0 (c0456000) writing 71 bytes
> [  653.369767] ttyGS0: tx len=64, 0x20 0x20 0x4d ...
> [  653.387546] udc: ep1in-bulk queue req c04767c0, len 64 buf c0476800 list_empty 0 ep->stopped 0
> [  653.409704] ttyGS0: tx len=7, 0x20 0x20 0x20 ...
> [  653.428329] udc: ep1in-bulk queue req c0476740, len 7 buf c0476780 list_empty 0 ep->stopped 0
> [  653.458930] gs_write_room: (0,c0456000) room=8191
> [  653.477806] gs_write: ttyGS0 (c0456000) writing 2 bytes
> [  653.496439] ttyGS0: tx len=2, 0x0d 0x0a 0x47 ...
> [  653.515178] udc: ep1in-bulk queue req c04766c0, len 2 buf c0476700 list_empty 0 ep->stopped 0
> [  653.538072] gs_flush_chars: (0,c0456000)
> [  653.564064] gs_write_room: (0,c0456000) room=8191
> [  653.583293] gs_write: ttyGS0 (c0456000) writing 45 bytes
> [  653.602765] ttyGS0: tx len=45, 0x20 0x53 0x77 ...
> [  653.622085] udc: ep1in-bulk queue req c0476640, len 45 buf c0476680 list_empty 0 ep->stopped 0
> ....  Etc ....
> [  653.982333] gs_write: ttyGS0 (c0456000) writing 2 bytes
> [  654.001840] ttyGS0: tx len=2, 0x23 0x20 0x47 ...
> [  654.021619] udc: ep1in-bulk queue req c0476940, len 2 buf c0476980 list_empty 0 ep->stopped 0
>
> While I don't have it recorded the /sys/kernel/debug/pxa25x_udc would
> show queues in ep1in-bulk something like below - this isn't the actual
> from the above session.
>
> ep1in-bulk max 64 pio udccs 0b irqs 18
>     req c04758c0 len 0/7 buf c0475900
>     req c0475840 len 0/2 buf c0475880
>     req c04757c0 len 0/64 buf c0475800
>     req c0475740 len 0/7 buf c0475780
>     req c04756c0 len 0/2 buf c0475700
>     req c0475640 len 0/45 buf c0475680
>     req c04755c0 len 0/2 buf c0475600
>     req c0475540 len 0/45 buf c0475580
>     req c04754c0 len 0/2 buf c0475500
>     req c0475940 len 0/2 buf c0475980
>
> In every case a manual enable of the pio_irq 0x40600050 would release
> the hang/stall and process the output and all is well again until next
> long line after queue is processed.   Also while it was hung session
> still active - can do commands and still working (maybe until queues or
> memory used up) - just no output.
>
> # devmem2 0x40600050 w
> /dev/mem opened.
> Memory mapped at address 0x40006000.
> Value at address 0x40600050 (0x40006050): 0xFA
> # devmem2 0x40600050 w 0xF8
> /dev/mem opened.
> Memory mapped at address 0x40006000.
> [ 1640.173457] udc: wrote ep1in-bulk 7 bytes/L/S 0 left c04768c0
>
> Value at address 0x40600050 (0x40006050): 0xFA
> [ 1640.191668] udc: wrote ep1in-bulk 2 bytes/L/S 0 left c0476840
> [ 1640.208856] udc: wrote ep1in-bulk 64 bytes/L 0 left c04767c0
> [ 1640.225778] udc: wrote ep1in-bulk 7 bytes/L/S 0 left c0476740
> [ 1640.242338] udc: wrote ep1in-bulk 2 bytes/L/S 0 left c04766c0
> [ 1640.258716] udc: wrote ep1in-bulk 45 bytes/L/S 0 left c0476640
> [ 1640.274840] udc: wrote ep1in-bulk 2 bytes/L/S 0 left c04765c0
> [ 1640.290379] udc: wrote ep1in-bulk 45 bytes/L/S 0 left c0476540
> [ 1640.306121] udc: wrote ep1in-bulk 2 bytes/L/S 0 left c04764c0
> [ 1640.320844] udc: wrote ep1in-bulk 2 bytes/L/S 0 left c0476940
> Written 0xF8; readback 0xF8
>
> So right or wrong after experimenting and testing the below patch in
> pxa25x_udc.c in function pxa25x_ep_queue fixed my problems.
>
> Both g_serial and g_ether under a pxa255 and pxa250 platforms - perform
> flawlessly in my testing at the moment.
>
> So... If the experts could review and look to see what really should be
> done or maybe already resolved...
>
> Here is what I did.
>
> Thanks,
>
> Quintin.
>
> This is against a 2.6.34.1 kernel source.
>
> --- a/drivers/usb/gadget/pxa25x_udc.c    2010-07-05 13:24:10.000000000 -0500
> +++ b/drivers/usb/gadget/pxa25x_udc.c    2010-09-12 16:06:34.000000000 -0500
> @@ -753,7 +753,8 @@ pxa25x_ep_queue(struct usb_ep *_ep, stru
>
>         if (likely (req && ep->desc))
>             pio_irq_enable(ep->bEndpointAddress);
> -    }
> +    } else if (!ep->stopped && req && ep->desc)
> +        pio_irq_enable(ep->bEndpointAddress);
>
>     /* pio or dma irq handler advances the queue. */
>     if (likely(req != NULL))
>
>
>
>
>
>
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

-- 
Regards,
Igor.
