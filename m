From: nschichan@freebox.fr (Nicolas Schichan)
Date: Mon, 02 Dec 2013 16:15:54 +0100
Subject: Spurious timeouts in mvmdio
Message-ID: <529CA42A.3040504@freebox.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

During 3.13-rc1 testing, I have found out that the mvmdio driver would report 
timeouts on the kernel console:

[   11.011334] orion-mdio orion-mdio: Timeout: SMI busy for too long

The hardware is a MV88F6281 Kirkwood CPU. The mvmdio driver is using the irq 
line 46 (ge00_err).

I am inclined to believe that it is due to the fact that wait_event_timeout() 
is called with a timeout parameter of 1 jiffy in orion_mdio_wait_ready(). If 
the timer interrupt ticks right after calling wait_event_timeout(), we may end 
up spending much less time than MVMDIO_SMI_TIMEOUT (1 msec) in 
wait_event_timeout(), and as a result report a timeout as the MDIO access did 
not complete in such a short time.

As to how to fix this, I see two options (I don't know which one would be 
prefered):

- Option 1: always pass a timeout of at least 2 jiffy to wait_event_timeout().
- Option 2: switch to wait_event_hrtimeout().

I can provide patches for both options.

Regards,

-- 
Nicolas Schichan
