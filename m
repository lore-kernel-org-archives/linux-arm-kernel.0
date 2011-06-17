From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Fri, 17 Jun 2011 16:49:31 +0200
Subject: [PATCH] collie: don't read GPSR
In-Reply-To: <1308319892-13057-1-git-send-email-dbaryshkov@gmail.com>
References: <1308319892-13057-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <19963.27003.636701.332500@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Dmitry Eremin-Solenikov writes:
> On StrongARM GPSR is write-only according to docs, so don't read from
> it. Just set the required GPIO.
> 
Anyway GPSR (and GPCR) is a bit oriented register that allows
asserting individual bits without the need for read-modify-write
cycles, making the access inherently multithread safe. Using
read-modify-write on this register is contrary to the HW design.

A quick grep of the kernel source shows another abuse like this in
drivers/video/sa1100fb.c:             GPSR |= SHANNON_GPIO_DISP_EN;
drivers/video/sa1100fb.c:             GPCR |= SHANNON_GPIO_DISP_EN;


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
