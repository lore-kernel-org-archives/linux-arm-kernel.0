From: rene.wolf@mbda-systems.de (Wolf, Rene, HRO-GP)
Date: Tue, 22 Sep 2009 15:22:02 +0200
Subject: SPI, DMA and an i.MX31
In-Reply-To: <4AB8C1A4.4020403@warmcat.com>
References: <87077C4F48609F4392621D9F99DDE20901202DFF@tesla.star.galaxy.io>	<BLU105-W229F8F8F533B107510C600BAE10@phx.gbl>	<87077C4F48609F4392621D9F99DDE20901202E00@tesla.star.galaxy.io>	<4AB7C020.2070205@gmail.com><4AB839FF.4000803@windriver.com><87077C4F48609F4392621D9F99DDE20901202E02@tesla.star.galaxy.io>
	<4AB8C1A4.4020403@warmcat.com>
Message-ID: <87077C4F48609F4392621D9F99DDE20901202E03@tesla.star.galaxy.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Good news everyone!
[Professor Hubert J. Farnsworth]

The kernel does compile. When I tried to run it the first time, it hung
right after the start. (Just after '...booting the kernel.'). Then I
set 'CONFIG_MXC_SDMA_API' to 'n' and recompiled: worked and was booting
correct (as far as I could see). I then checked the init routine from
'sdma.c' and after some try'n'error I got that it hung on enabling the
clocks for the sdma. After a quick look in arch/arm/mach-mx3/clock.c
@ line 475 - there is the entry for sdma_clk1:
DEFINE_CLOCK(sdma_clk1, 0, MXC_CCM_CGR0, 14, NULL, &sdma_clk1, &ahb_clk)
which references its self with '&sdma_clk1', thus it hung in a loop. I
guess this is a typo an should reference 'sdma_clk2' or 'NULL' not '1'.
After changing that my system booted smoothly. If I look in '/proc' there
is a dir called 'sdma', and inside there is a file 'channels':
$ cat channels
Channel 0: MCU

It seams to be alive :-)

> Take a look at ./drivers/mmc/host/mxcmmc.c

Next will try to test the mmc driver, but I don't have an MMC/SD slot on
my board. Hopefully there is some sign of an MMC in the channels
file or so.

Thanks again :-)


Cheers
Rene 

Ps: @ Marc Titinger: I think you are using HTML-Mail.
Afaik they won't show up on the mailing list :-)
-> check http://david.woodhou.se/email.html #7


Rene Wolf
LFK-Lenkflugk?rpersysteme GmbH
Human Resources Operations & Policy, HRO
Landshuter Stra?e 26, 85716 Unterschlei?heim, GERMANY
Phone: +49 89 3179 8337
Fax: +49 8252 99 8964
E-Mail: rene.wolf at mbda-systems.de

http://www.mbda.net

Chairman of the Supervisory Board: Antoine Bouvier
Managing Director: Werner Kaltenegger
Registered Office: Schrobenhausen
Commercial Register: Amtsgericht Ingolstadt, HRB 4365
