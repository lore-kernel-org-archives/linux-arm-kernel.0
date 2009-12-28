From: stevenm86@gmail.com (Steve Moskovchenko)
Date: Mon, 28 Dec 2009 17:27:06 -0500
Subject: 21285 serial driver deadlock(?) fix
Message-ID: <1262039226.28196.125.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello

I've got a board with a StrongARM SA-110 and a 21285 "footbrtidge" on
it. The kernel's 21285 serial driver works for kernel messages but not
for I/O from userspace.

My kernel experience is pretty limited, but I believe the problem lies
in drivers/serial/21285.c.

As I understand it:
serial21285_tx_chars looks like an ISR, which likes to call
serial21285_stop_tx every once in a while. 
serial21285_stop_tx, in turn, calls disable_irq(), which waits for the
current instance of the ISR to finish before disabling that interrupt.
But, calling this from within an ISR results in deadlock and makes the
puppy very sad. 

I've modified the ISR to call a different version of stop_tx, which uses
disable_irq_nosync() instead. This gave me a working console.

Another issue with the driver is the baud rate calculation, which seems
broken for me. I had to comment out the lines that write to the BRG
register (not in this patch), but this may be a result of my board using
a different clock rate than a real EBSA285. Maybe I will look into that
later.

I have attached the relevant patch. I am also using this with my
previous CONFIG_MMU patch and a minor modification to ignore the machine
detection, or else my kernel wouldn't boot at all.

What do you guys think?

Thanks
Steve

-------------- next part --------------
A non-text attachment was scrubbed...
Name: footbridge-serial-deadlock.patch
Type: text/x-patch
Size: 777 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091228/2b57160b/attachment.bin>
