From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 27 Sep 2014 11:03:46 +0100
Subject: [PATCH 1/4] serial: mxs-auart: ctrl removed from mxs_auart_port
In-Reply-To: <1411811197-12638-2-git-send-email-j.uzycki@elproma.com.pl>
References: <1411811197-12638-1-git-send-email-j.uzycki@elproma.com.pl>
 <1411811197-12638-2-git-send-email-j.uzycki@elproma.com.pl>
Message-ID: <20140927100345.GB5182@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 27, 2014 at 11:46:34AM +0200, Janusz Uzycki wrote:
> The ctrl variable duplicated mctrl, member of uart_port structure
> in serial_core.h.
> The code duplicated uart_update_mctrl() and uart_tiocmget()
> in serial_core.c.
> mxs_auart_get_mctrl() reads back RTS line. It could be removed too
> but not sure.

The only thing which the .get_mctrl method is supposed to do is to return
the state of the /input/ lines, which are CTS, DCD, DSR, RI.  The output
line state is stored in port->mctrl, and is added to the returned value
by serial_core when it's required.  RTS output state should not be
returned from the .get_mctrl method.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
