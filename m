From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 11 Dec 2015 00:10:55 +0100
Subject: [PATCH 0/5] ARM: orion5x/dove/mv78xx0 multiplatform
In-Reply-To: <5669F5F8.5010005@vollmann.ch>
References: <1448466557-435335-1-git-send-email-arnd@arndb.de>
 <2992463.fVOGazvIkH@wuerfel> <5669F5F8.5010005@vollmann.ch>
Message-ID: <14967875.ttNXUbSTvS@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 10 December 2015 23:00:24 Detlef Vollmann wrote:
> On 12/10/15 22:29, Arnd Bergmann wrote:
> > On Thursday 10 December 2015 22:14:25 Detlef Vollmann wrote:
> >> On 12/10/15 21:59, Arnd Bergmann wrote:
> > It may also be worth investigating what has made CONFIG_OF so costly,
> Probably because too much is done at runtime and too few things can
> be fixed at build time.
> 
> > maybe we can reduce this a bit again.
> Probably not without turning the wheel backward :-(
> 
> So for the test: yes it works, but I'm unhappy with it.

I'm not too happy about adding 80kb to the uncompressed kernel 
image either. I've spent some more time now trying to find where
we added the bloat. It's mainly in drivers, not in arch specific
code, a kilobyte here and there eventually adds up, but the largest
portion with a little over 50% of the total diff is drivers/of.

I don't expect to find a lot of low-hanging fruit there. For
reference, see the diff of 'size -A' below.

	Arnd

 
-orion5x_defconfig-dt/arch/arm/kernel/built-in.o  :
+orion5x_defconfig-nodt/arch/arm/kernel/built-in.o  :
--
-Total                                    48034
+Total                                    46863
 
 
-orion5x_defconfig-dt/arch/arm/mm/built-in.o  :
+orion5x_defconfig-nodt/arch/arm/mm/built-in.o  :
--
-Total                                       43680
+Total                                       43672
 
 
-orion5x_defconfig-dt/arch/arm/plat-orion/built-in.o  :
+orion5x_defconfig-nodt/arch/arm/plat-orion/built-in.o  :
--
-Total                                     22131
+Total                                     22103
 

-orion5x_defconfig-dt/drivers/ata/built-in.o  :
+orion5x_defconfig-nodt/drivers/ata/built-in.o  :


-Total                                                  160244
+Total                                                  159524
 
 
-orion5x_defconfig-dt/drivers/base/built-in.o  :
+orion5x_defconfig-nodt/drivers/base/built-in.o  :
--
-Total                                                      111366
+Total                                                      109090
 
 
-orion5x_defconfig-dt/drivers/bus/built-in.o  :
+orion5x_defconfig-nodt/drivers/bus/built-in.o  :
-Total                                        10151
+Total                                        8120
 
 
-orion5x_defconfig-dt/drivers/clk/built-in.o  :
+orion5x_defconfig-nodt/drivers/clk/built-in.o  :
--
-Total                                                  35514
+Total                                                  29469
 
 
-orion5x_defconfig-dt/drivers/crypto/built-in.o  :
+orion5x_defconfig-nodt/drivers/crypto/built-in.o  :
--
-Total             8712
+Total             8552
 
 
-orion5x_defconfig-dt/drivers/dma/built-in.o  :
+orion5x_defconfig-nodt/drivers/dma/built-in.o  :
--
-Total                                             18939
+Total                                             16186
 
 
-orion5x_defconfig-dt/drivers/gpio/built-in.o  :
+orion5x_defconfig-nodt/drivers/gpio/built-in.o  :
--
-Total                                               26663
+Total                                               19142
 
 
-orion5x_defconfig-dt/drivers/i2c/built-in.o  :
+orion5x_defconfig-nodt/drivers/i2c/built-in.o  :
--
-Total                                                  25772
+Total                                                  23778
 
 
-orion5x_defconfig-dt/drivers/input/built-in.o  :
+orion5x_defconfig-nodt/drivers/input/built-in.o  :
--
-Total                                          39847
+Total                                          38531
 
 
-orion5x_defconfig-dt/drivers/leds/built-in.o  :
+orion5x_defconfig-nodt/drivers/leds/built-in.o  :
--
-Total                                          10436
+Total                                          10372
 
 
-orion5x_defconfig-dt/drivers/misc/built-in.o  :
+orion5x_defconfig-nodt/drivers/misc/built-in.o  :
--
-Total             3163
+Total             1939
 
 
-orion5x_defconfig-dt/drivers/mtd/built-in.o  :
+orion5x_defconfig-nodt/drivers/mtd/built-in.o  :
--
-Total                                              162074
+Total                                              157383
 
 
-orion5x_defconfig-dt/drivers/net/built-in.o  :
+orion5x_defconfig-nodt/drivers/net/built-in.o  :
--
-Total                                    50038
+Total                                    46757
 
 
-orion5x_defconfig-dt/drivers/of/built-in.o  :
+orion5x_defconfig-nodt/drivers/of/built-in.o  :
--
-Total                                             46444
+Total                                             0
 
 
-orion5x_defconfig-dt/drivers/pci/built-in.o  :
+orion5x_defconfig-nodt/drivers/pci/built-in.o  :
--
-Total                                                   115926
+Total                                                   115352
 
 
-orion5x_defconfig-dt/drivers/perf/built-in.o  :
+orion5x_defconfig-nodt/drivers/perf/built-in.o  :
--
-Total                              4796
+Total                              4202
 
 
-orion5x_defconfig-dt/drivers/phy/built-in.o  :
+orion5x_defconfig-nodt/drivers/phy/built-in.o  :
--
-Total                                            5529
+Total                                            4909
 
 
-orion5x_defconfig-dt/drivers/rtc/built-in.o  :
+orion5x_defconfig-nodt/drivers/rtc/built-in.o  :
--
-Total                                       35840
+Total                                       35024
 
 
-orion5x_defconfig-dt/drivers/tty/built-in.o  :
+orion5x_defconfig-nodt/drivers/tty/built-in.o  :
--
-Total                                              125096
+Total                                              119738
 
 
-orion5x_defconfig-dt/drivers/usb/built-in.o  :
+orion5x_defconfig-nodt/drivers/usb/built-in.o  :
--
-Total                                                251268
+Total                                                250498
 
