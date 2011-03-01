From: subhasish@mistralsolutions.com (Subhasish Ghosh)
Date: Tue, 1 Mar 2011 19:07:40 +0530
Subject: [PATCH v2 13/13] tty: pruss SUART driver
In-Reply-To: <20110222111103.5d0dd0a7@lxorguk.ukuu.org.uk>
References: <1297435892-28278-1-git-send-email-subhasish@mistralsolutions.com><1297435892-28278-14-git-send-email-subhasish@mistralsolutions.com><20110211162814.6ff274f1@lxorguk.ukuu.org.uk><A6D1CF0E941748448610BE8874FC586F@subhasishg>
	<20110222111103.5d0dd0a7@lxorguk.ukuu.org.uk>
Message-ID: <99CE1730AA2F4F2F91AFA71BD75FDC41@subhasishg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I tried using the tty_prepare_flip_string as shown below, but this is 
causing some latency issues.

Problem is, we do not have any flow control, so we must copy the FIFO data 
before the next data
is available. As we are using the tty_prepare_flip_string just before the 
read API, the FIFO is getting
overwritten and we are ending up missing chunks (FIFO sized) of data.

I tried using a tasklet for the TX part, but that did not help.
Another way is to prepare the buffer for the next read and read the data 
immediately.
Something like this:

1. Call tty_prepare_flip_string while startup.
2. When the read interrupt arrives, read the data immediately.
3. Call tty_prepare_flip_string for the next read.

Again, the problem here is that we need to use global variables to store the 
pre-allocated buffers
and at the last read, we allocated the buffer but never used it. I think 
this will cause a memory leak.
Or we can de-allocate it while driver close, not sure how to.

The best way is if we can keep the current implementation, one extra copy is 
not hurting us
as we do it after the read_data API.


==================================================================================
--- a/drivers/tty/serial/da8xx_pruss/pruss_suart.c
+++ b/drivers/tty/serial/da8xx_pruss/pruss_suart.c
@@ -170,8 +170,9 @@ static void omapl_pru_rx_chars(struct omapl_pru_suart
*soft_uart, u32 uart_no)
        s8 flags = TTY_NORMAL;
        u16 rx_status, data_len = SUART_FIFO_LEN;
        u32 data_len_read;
-       u8 suart_data[SUART_FIFO_LEN + 1];
+       u8 *suart_data = NULL;
        s32 i = 0;
+       s32 alloc_len = 0;

        if (!(suart_get_duplex(soft_uart, uart_no) & ePRU_SUART_HALF_RX))
                return;
@@ -199,9 +200,10 @@ static void omapl_pru_rx_chars(struct omapl_pru_suart
*soft_uart, u32 uart_no)
                soft_uart->port[uart_no].sysrq = 0;
 #endif
        } else {
+               alloc_len = tty_prepare_flip_string(tty, &suart_data,
data_len + 1);
                pru_softuart_read_data(dev, &soft_uart->suart_hdl[uart_no],
-                                      suart_data, data_len + 1,
-                                      &data_len_read);
+                                               suart_data, alloc_len,
+                                               &data_len_read);

                for (i = 0; i <= data_len_read; i++) {
                        soft_uart->port[uart_no].icount.rx++;
@@ -210,8 +212,6 @@ static void omapl_pru_rx_chars(struct omapl_pru_suart
*soft_uart, u32 uart_no)
                            (&soft_uart->port[uart_no], suart_data))
                                continue;
                }
-               /* update the tty data structure */
-               tty_insert_flip_string(tty, suart_data, data_len_read);
        }
============================================================================================

--------------------------------------------------
From: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Sent: Tuesday, February 22, 2011 4:41 PM
To: "Subhasish" <subhasish@mistralsolutions.com>
Cc: <davinci-linux-open-source@linux.davincidsp.com>; 
<linux-arm-kernel@lists.infradead.org>; <m-watkins@ti.com>; 
<nsekhar@ti.com>; <sachi@mistralsolutions.com>; "Greg Kroah-Hartman" 
<gregkh@suse.de>; "open list" <linux-kernel@vger.kernel.org>; "Stalin 
Srinivasan" <stalin.s@mistralsolutions.com>
Subject: Re: [PATCH v2 13/13] tty: pruss SUART driver

>> we used separate files and hence we decided to keep the code in a 
>> separate
>> directory so that the related files can be identified easily.
>
> Fair enough but I would have thought you could drop the two files in the
> serial directory if they have obviously related names- trivial item/
>>
>> >
>> >
>> >
>> >> +#ifdef __SUART_DEBUG
>> >> +#define __suart_debug(fmt, args...) \
>> >> + printk(KERN_DEBUG "suart_debug: " fmt, ## args)
>> >> +#else
>> >> +#define __suart_debug(fmt, args...)
>> >> +#endif
>> >> +
>> >> +#define  __suart_err(fmt, args...) printk(KERN_ERR "suart_err: " fmt, 
>> >> ##
>> >> args)
>> >
>> > Use dev_dbg/dev_err/pr_debug/pr_err
>>
>> SG - did you mean replace the printks above with dev_dgb/err or the
>> suart_dbg/err.
>
> Ideally all the messages shopuld use dev_dbg/dev_err etc. That allows you
> to configure debug levels and the like nicely as well as producing
> clearer printk info. In some cases with tty code you may not know the
> device so have to use pr_err/pr_debug etc.
>
> Ok
>
>> > Which is never checked. Far better to use WARN_ON and the like for such
>> > cases - or if like this one they don't appear to be possible to simply
>> > delete them
>>
>> SG -- OK, does this look ok ?
>> =================================
>> if (h_uart == NULL) {
>> +WARN_ON(1);
>> - return PRU_SUART_ERR_HANDLE_INVALID;
>> +return -EINVAL;
>> }
>
> Yep - the user will now get a backtrace, and in addition kerneloops.org
> can capture it if that is set up in the distro in use.
>
> Alan 
