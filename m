From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 27 Sep 2014 11:54:08 +0100
Subject: [PATCH 2/4] serial: mxs-auart: use mctrl_gpio helpers for
 handling modem signals
In-Reply-To: <5426926C.60402@elproma.com.pl>
References: <1411811197-12638-1-git-send-email-j.uzycki@elproma.com.pl>
 <1411811197-12638-3-git-send-email-j.uzycki@elproma.com.pl>
 <5426926C.60402@elproma.com.pl>
Message-ID: <20140927105408.GD5182@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 27, 2014 at 12:33:16PM +0200, Janusz U?ycki wrote:
> Could somebody comment if DMA could be enabled also
> if CTS/RTS is supported by GPIOs? Is it safe?
> It would allow me to avoid ugly code in mxs_auart_settermios(),
> as commented Russel King.

Russel*L* please, otherwise you are giving me implicit permission to
mis-spell your name.

> Otherwise I have to keep backward compatibility on DMA
> and HW flow control, and fix the ugly code.
>
> Marek Vasut:
> "Why do you think DMA would do any good on long transfers without  
> flowcontrol."

The problem with DMA without hardware flow control is that the UART
transmission will run at full speed, with characters back to back.

You will have a variable amount of latency when dealing with the CTS
signal - interrupt handling latency in Linux can be quite variable.
(I'm not sure whether this has improved recently, USB used to be
particularly bad, causing 3+ ms latencies.)

When CTS is deasserted, you have to pause the transmission as soon as
possible to avoid overflowing the remote end.  At 115200 baud, each
character takes around 90us to be transmitted.  If you are delayed in
handling the CTS interrupt for 3ms, then you will have transmitted
around 35 characters in that time, which could be enough to cause an
overflow at the remote end.

Since the idea of flow control is to prevent overruns/overflow at the
receiver, this is far from ideal.

If Linux had a way to handle flow control interrupts as a higher
priority than other interrupts (especially interrupting an already
in-progress interrupt handler) then having GPIOs as flow control
signals would be a much saner proposition.

Unfortunately, lockdep completely gets in the way of that.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
