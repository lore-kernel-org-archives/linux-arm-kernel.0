From: andre.przywara@arm.com (Andre Przywara)
Date: Fri, 16 Jan 2015 17:53:52 +0000
Subject: [PATCH 00/10] drivers: PL011: add ARM SBSA Generic UART support
In-Reply-To: <7542669.MXdXNkVnKh@wuerfel>
References: <1421428986-11300-1-git-send-email-andre.przywara@arm.com>
 <7542669.MXdXNkVnKh@wuerfel>
Message-ID: <54B95030.1010909@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 16/01/15 17:31, Arnd Bergmann wrote:
> On Friday 16 January 2015 17:22:56 Andre Przywara wrote:
>> The ARM Server Base System Architecture[1] document describes a
>> generic UART which is a subset of the PL011 UART.
>> It lacks DMA support, baud rate control and modem status line
>> control, among other things.
>> The idea is to move the UART initialization and setup into the
>> firmware (which does this job today already) and let the kernel just
>> use the UART for sending and receiving characters.
> 
> Given that all other approaches that have been tried have failed, this
> seems like the best way forward. I don't know enough about the driver
> to do a detailed review, but all patches looked good to me as far as
> I could tell.

Thanks for looking at them!

> One question: How does the name space and minor number allocation work
> if you have both sbsa-uart and real pl011 in the same system? Do
> they share the ttyAMA name space without collisions?

Yes, that works. Both parts use the same pl011_probe_dt_alias() routine
to do the numbering.
For testing I specified the second and fourth port as SBSA in the DT,
leaving the first and third as PL011. This is what you get then:
...
Serial: AMBA PL011 UART driver
uart-pl011 1c090000.uart: ttyAMA0 at MMIO 0x1c090000 (irq = 15,
base_baud = 0) is a PL011 rev2
...
uart-pl011 1c0b0000.uart: ttyAMA2 at MMIO 0x1c0b0000 (irq = 17,
base_baud = 0) is a PL011 rev2
....
sbsa-uart 1c0a0000.uart: ttyAMA1 at MMIO 0x1c0a0000 (irq = 16, base_baud
= 0) is a SBSA
sbsa-uart 1c0c0000.uart: ttyAMA3 at MMIO 0x1c0c0000 (irq = 18, base_baud
= 0) is a SBSA

Cheers,
Andre.
