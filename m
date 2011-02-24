From: subhasish@mistralsolutions.com (Subhasish Ghosh)
Date: Thu, 24 Feb 2011 16:01:06 +0530
Subject: [PATCH v2 13/13] tty: pruss SUART driver
In-Reply-To: <201102221734.15582.arnd@arndb.de>
References: <1297435892-28278-1-git-send-email-subhasish@mistralsolutions.com>
	<201102181951.32631.arnd@arndb.de>
	<DADE3366197E4479A57F3B967A881C33@subhasishg>
	<201102221734.15582.arnd@arndb.de>
Message-ID: <E56D2F3DE46B46C1B03302394F463B19@subhasishg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Ok, have implemented the test_and_clear_bit.


> On Tuesday 22 February 2011, Subhasish Ghosh wrote:
>
>> @@ -122,13 +122,10 @@ static void omapl_pru_tx_chars(struct 
>> omapl_pru_suart
>> *soft_uart, u32 uart_no)
>>         if (!(suart_get_duplex(soft_uart, uart_no) & ePRU_SUART_HALF_TX))
>>                 return;
>>
>> -       if (down_trylock(&soft_uart->port_sem[uart_no]))
>> -               return;
>> -
>>         if (uart_circ_empty(xmit) ||
>>                         uart_tx_stopped(&soft_uart->port[uart_no])) {
>>                 pruss_suart_stop_tx(&soft_uart->port[uart_no]);
>> -               up(&soft_uart->port_sem[uart_no]);
>> +               soft_uart->tx_empty[uart_no] = true;
>>                 return;
>>         }
>>
>> @@ -259,7 +256,6 @@ static irqreturn_t pruss_suart_interrupt(s32 irq, 
>> void
>> *dev_id)
>>                         pru_intr_clr_isrstatus(dev, uart_num, 
>> PRU_TX_INTR);
>>                         pru_softuart_clr_tx_status(dev, 
>> &soft_uart->suart_hdl
>>                                                  [port->line]);
>> -                       up(&soft_uart->port_sem[port->line]);
>>                         omapl_pru_tx_chars(soft_uart, port->line);
>>                 }
>>         } while (txrx_flag & (PRU_RX_INTR | PRU_TX_INTR));
>> @@ -294,7 +290,10 @@ static void pruss_suart_start_tx(struct uart_port
>> *port)
>>
>>         suart_intr_setmask(dev, 
>> soft_uart->suart_hdl[port->line].uart_num,
>>                            PRU_TX_INTR, CHN_TXRX_IE_MASK_CMPLT);
>> -       omapl_pru_tx_chars(soft_uart, port->line);
>> +       if (soft_uart->tx_empty[port->line] == true) {
>> +               soft_uart->tx_empty[port->line] = false;
>> +               omapl_pru_tx_chars(soft_uart, port->line);
>> +       }
>>  }
>
> This looks racy, and I think you at least need to take the spinlock in
> pruss_suart_start_tx(), but I don't fully understand the intention of the
> code.
>
> I guess you could also use a bitmask for tx_empty and use 
> test_and_clear_bit()
> on that to guarantee atomicity.
>
> Arnd 
