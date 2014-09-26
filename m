From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 26 Sep 2014 14:11:17 +0100
Subject: [PATCH 1/4] serial: mxs-auart: use mctrl_gpio helpers for
 handling modem signals (v2.2c)
In-Reply-To: <54256326.3080202@elproma.com.pl>
References: <1411150399-30902-1-git-send-email-j.uzycki@elproma.com.pl>
 <54256326.3080202@elproma.com.pl>
Message-ID: <20140926131117.GR5182@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 26, 2014 at 02:59:18PM +0200, Janusz U?ycki wrote:
> But serial8250_get_mctrl() in 8250_core.c calls serial8250_modem_status()
> which calls eg. uart_handle_cts_change() even if enable_ms() wasn't called.
> This is the difference.
> The serial8250_modem_status() is also called in the interrupt
> and, what I don't understand, in serial8250_console_write().

Reading the MSR register clears the interrupts.  So, whenever MSR is read,
you have to deal with any state changes which _would_ have been passed
to the interrupt function.

Plus, it's not quite as you make out above.

If enable_ms() is not called, then UART_IER_MSI will not be set in up->ier.
Hence, uart_handle_cts_change() will not be called.

The reason for the call in the console function is to account for the
state changes during console write with CTS flow control - this again
needs the MSR register to be read, and we have to account for MSR state
changes after the console write has completed.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
