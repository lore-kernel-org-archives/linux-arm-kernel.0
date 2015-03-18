From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 18 Mar 2015 23:43:48 +0000
Subject: [PATCH] amba-pl011: simplify TX handling
In-Reply-To: <20150318174157.GD3549@e103592.cambridge.arm.com>
References: <20150317163200.GE3759@e103592.cambridge.arm.com>
 <20150318004255.538fd48e@north>
 <20150318174157.GD3549@e103592.cambridge.arm.com>
Message-ID: <20150318234348.GF8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 18, 2015 at 05:41:57PM +0000, Dave P Martin wrote:
>  * uart_wait_until_sent()'s timeout calculations aim to wait for
>    no longer than it takes the FIFO to drain.  However, this function
>    can get called when the serial_core xmit queue for the port is
>    very non-empty -- meaning that the FIFO continues to be topped
>    up for some time.  This can cause more data to be lost.

The code used to wait for the xmit queue to empty (up to closing_wait)
before shutting the port down, which defaulted to 30 seconds.  If the
xmit queue doesn't drain in 30 seconds, it probably never will.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
