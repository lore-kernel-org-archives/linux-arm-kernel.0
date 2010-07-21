From: david.jander@protonic.nl (David Jander)
Date: Wed, 21 Jul 2010 10:29:29 +0200
Subject: ARM Machine SoC I/O setup and PAD initialization code
Message-ID: <201007211029.29529.david.jander@protonic.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi all,

Having some experience with powerpc linux and being fairly new to ARM, I 
wonder about the following I have observed on ARM-linux so far:

General machine initialization like I/O-multiplexing and I/O-pad setup seems 
to be done twice most of the time: Once in the bootloader (i.e. u-boot), and 
once in the machine support file in the linux kernel. This seems awfully 
redundant and error-prone to me. Why is it like this?

Shouldn't I/O-pad setup and such stuff be duty of the bootloader alone? Why do 
I see so much platform setup code in the linux kernel that repeats this?

For example:
arch/arm/plat-mxc/include/mach/iomux-mx51.h

#define MX51_UART1_PAD_CTRL     (PAD_CTL_HYS | PAD_CTL_PKE | PAD_CTL_PUE | \
                                 PAD_CTL_DSE_HIGH)
...

IMHO this shouldn't be in the kernel, much less in this place. This define 
assumes somehow that on every i.MX51 based board I should configure any UART1 
pad as having high drive-strength and a pull-up. What drive strength the pad 
should have is a decision that the board hardware-designer must make 
individually for each board and pin of the UART. It cannot be something as 
generic as to put it into such a header-file. The kernel definitely shouldn't 
mess with those things.

So, why is it done like this?
Is it historically grown like this, and has noone yet had the time to fix 
this?
Or is it that boot-loaders on ARM in general don't do hardware setup correctly 
so that it has to be re-done in the kernel? What about fixing bootloaders 
then?

Best regards,

-- 
David Jander
Protonic Holland.
