From: socketcan@hartkopp.net (Oliver Hartkopp)
Date: Mon, 23 May 2011 08:21:48 +0200
Subject: [PATCH v4 1/1] can: add pruss CAN driver.
In-Reply-To: <201105221230.56243.arnd@arndb.de>
References: <1303474267-6344-1-git-send-email-subhasish@mistralsolutions.com>
	<4DCB88A4.2010901@grandegger.com> <4DCBF1B6.6000104@hartkopp.net>
	<201105221230.56243.arnd@arndb.de>
Message-ID: <4DD9FCFC.10803@hartkopp.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22.05.2011 12:30, Arnd Bergmann wrote:
> On Thursday 12 May 2011 16:41:58 Oliver Hartkopp wrote:
>> E.g. assume you need the CAN-IDs 0x100, 0x200 and 0x300 in your application
>> and for that reason you configure these IDs in the pruss CAN driver.
>>
>> What if someone generates a 100% CAN busload exactly on CAN-ID 0x100 then?
>>
>> Worst case (1MBit/s, DLC=0) you would need to handle about 21.000 irqs/s for
>> the correctly received CAN frames with the filtered CAN-ID 0x100 ...
> 
> Then I guess the main thing that a "smart" CAN implementation like pruss
> should do is interrupt mitigation. When you have a constant flow of
> packets coming in, the hardware should be able to DMA a lot of
> them into kernel memory before the driver is required to pick them up,
> and only get into interrupt driven mode when the kernel has managed
> to process all outstanding packets.
> 
>> This all depends heavily on Linux networking (skb handling, caching, etc) and
>> is pretty fast and optimized!! That was also the reason why it ran on the old
>> PowerPC that smoothly. The mostly seen effect if anything drops is when the
>> application (holding the socket) was not fast enough to handle the incoming
>> data. NB: For that reason we implemented a CAN content filter (CAN_BCM) that
>> is able to do content filtering and timeout monitoring in Kernelspace - all
>> performed in the SoftIRQ.
> 
> Right, dropping packets that no process is waiting for should be done as
> early as possible. In pruss-can, the idea was to do it in hardware, which
> doesn't really work all that well for the reasons discussed before.
> Dropping the frames in the NAPI poll function (softirq time) seems like a
> logical choice.

In 'real world' CAN setups you'll never see 21.000 CAN frames per second (and
therefore 21.000 irqs/s) - you are usually designing CAN network traffic with
less than 60% busload. So interrupt rates somewhere below 1000 irqs/s can be
assumed.


>From bogus@does.not.exist.com  Fri May 20 08:44:36 2011
From: bogus@does.not.exist.com ()
Date: Fri, 20 May 2011 12:44:36 -0000
Subject: No subject
Message-ID: <mailman.1.1306131711.23796.linux-arm-kernel@lists.infradead.org>

@Marc/Wolfgang: Would this be also your recommendation for a CAN controller
design that supports SocketCAN in the best way?

As the Linux network stack supports hardware timestamps too, this could be an
additional (optional!) feature.

Regards,
Oliver

>> Having 'Mailboxes' bound to CAN-IDs is something that's useful for 8/16 bit
>> CPUs where an application is tightly bound to the embedded ECUs functionality.
> 
> Makes sense.
> 
> 	Arnd
