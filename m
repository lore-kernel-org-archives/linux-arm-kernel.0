From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 02 Sep 2016 19:50:35 +0200
Subject: [PATCH 05/33] gpio: add generic single-register fixed-direction
 GPIO driver
In-Reply-To: <20160901230248.GA1041@n2100.armlinux.org.uk> (Russell King's
 message of "Fri, 2 Sep 2016 00:02:48 +0100")
References: <87eg57e54l.fsf@belgarion.home>
 <20160830091805.GL1041@n2100.armlinux.org.uk>
 <87k2eycip0.fsf@belgarion.home>
 <20160830184612.GO1041@n2100.armlinux.org.uk>
 <87fupmc59b.fsf@belgarion.home>
 <20160831084938.GQ1041@n2100.armlinux.org.uk>
 <20160831102721.GR1041@n2100.armlinux.org.uk>
 <87twe0krym.fsf@belgarion.home>
 <20160901092754.GU1041@n2100.armlinux.org.uk>
 <87oa47l1tn.fsf@belgarion.home>
 <20160901230248.GA1041@n2100.armlinux.org.uk>
Message-ID: <87inuekx78.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@armlinux.org.uk> writes:

>> You're right, I submitted a patch for that, and I confirm it actually happens on
>> lubbock.
>
> That'll work fine for lubbock, but not the others (we can have several
> of the others enabled on sa11x0 platforms - eg, badge4 with neponset.)
Ah, I see. Let's drop the patch then, I won't be able to know what to return in
this function if 2 initialisations fail, nor if the first failure should be
fatal or not, nor if a rollback is possible after 1 success (badge4) and 1
failure (neponset).

> Ignore those for now - the old ARM IRQ stuff was silent on that, but genirq
> is more noisy.  I should probably make the sa1111 irqchip handle the both-
> edge case itself.
Ok.

>> Moreover, I have a bit of homework as I also see :
>>  - no SA1111 interrupts at all, especially nothing when I insert/remove my
>>    CompactFlash card
>>    This might be an effect of pxa_cplds_irqs.c I created, I must have a look.
>
> Do you get other SA1111 interrupts (eg, the PS/2 interrupts) delivered?
I see no other interrupts at all.
Actually I see no interrupt claimed in /proc/interrupts, where I would have
expected interrupt 305.
	cat /proc/interrupts
	           CPU0       
	 24:       1419        SC   8 Edge      gpio-0
	 25:          0        SC   9 Edge      gpio-1
	 26:          0        SC  10 Edge      gpio-mux
	 38:        118        SC  22 Edge      UART1
	 41:          0        SC  25 Edge      DMA
	 42:      40224        SC  26 Edge      ost0
	112:       1419      GPIO   0 Edge      pxa_cplds_irqs
	307:       1419  pxa_cplds   3 Edge      eth0
	387:          0  SA1111-h Edge      SA1111 PCMCIA card detect
	388:          0  SA1111-h Edge      SA1111 CF card detect
	389:          0  SA1111-h Edge      SA1111 PCMCIA BVD1
	390:          0  SA1111-h Edge      SA1111 CF BVD1
	Err:          0

Actually this leads me to think that this interrupt 305 is not "requested" nor
activated. I see in sa1111.c:506 :
  "irq_set_chained_handler_and_data(sachip->irq, sa1111_irq_handler, ..."
This puts in the handler and data, but I don't this is "enables" the interrupt,
right ?

I traced the code in the interrupt controller (pxa_cplds_irqs), the SA1111
physical line is not set (even with an AT/2 keyboard connected, and I don't
think anybody tried this AT/2 on a lubbock for a long time).

The interrupt is for sure masked, and therefore the SA1111 interrupts are not
fired. Even if they would have been enabled, the "pending interrupts register"
doesn't show any sa1111 interrupt pending, so there is something else.

As I don't know if "enable_irq()" in sa1111.c would be an option as I have no
sight on sa1111.c requirements, I would take any advice here.

> Hmm, on Neponset with a CF card inserted, I can cat that, and it reports
> the CIS.  Any error messages in the kernel log?
None.
I have an ever more suprising thing.
I tried again this morning, without changing a single line of code (excepting in
pxa_cplds_irqs.c) nor touching the CF card, and now it really rocks !!! :
hexdump -C /sys/class/pcmcia_socket/pcmcia_socket1/cis
hexdump -C /sys/class/pcmcia_socket/pcmcia_socket1/cis
00000000  01 04 df 79 01 ff 1c 04  02 db 01 ff 18 02 df 01  |...y............|
00000010  20 04 45 00 01 04 15 0b  04 01 00 43 46 43 41 52  | .E........CFCAR|
00000020  44 00 ff 21 02 04 01 22  02 01 01 22 03 02 0c 0f  |D..!..."..."....|
00000030  1a 05 01 03 00 02 0f 1b  08 c0 40 a1 01 55 08 00  |.......... at ..U..|
00000040  20 1b 06 00 01 21 b5 1e  4d 1b 0a c1 41 99 01 55  | ....!..M...A..U|
00000050  64 f0 ff ff 20 1b 06 01  01 21 b5 1e 4d 1b 0f c2  |d... ....!..M...|
00000060  41 99 01 55 ea 61 f0 01  07 f6 03 01 ee 20 1b 06  |A..U.a....... ..|
00000070  02 01 21 b5 1e 4d 1b 0f  c3 41 99 01 55 ea 61 70  |..!..M...A..U.ap|
00000080  01 07 76 03 01 ee 20 1b  06 03 01 21 b5 1e 4d 14  |..v... ....!..M.|
00000090  00                                                |.|

I think this proves that your patches related to lubbock pcmcia conversion to
max1602 is fully functional !

Only the interrupt part to fight a bit, and then I'll try to make a couple of
tests on the IRDA part.

Cheers.

-- 
Robert
