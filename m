From: gianlucarenzi@eurek.it (gianluca)
Date: Tue, 07 Jul 2015 15:50:25 +0200
Subject: Passing arguments to cmdline or changing the devicetree node??
Message-ID: <559BD921.3080000@eurek.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello list,
I was thinking which is the best method to ensure a fallback 
compatibility to old boards when a single board has changed something in 
hardware.

I will explain better:

I designed a board running linux (on iMX28) which had 128MB and the 
first stage bootstrap is programming the DDR2 controller to match the 
memory timings.
The bootloader had the memory size hardcoded, but it is not a problem 
because nothing on the bootloader is using it (maybe some atag for old 
compatibility, I need to check this out)
The bootloader now loads linux and the devicetree flattened blob and 
pass it to the kernel.
In the .dts I have a node called:

> 	memory {
> 		reg = <0x40000000 0x08000000>;
> 	};

and it is fixed.

Now we need to update the memory onboard up to 256Mb or 512Mb, and if I 
can test easily on the fist stage bootstrap (programming the DDR2 
controller for 256Mb and writing on memory above 128Mb and if it works I 
have could have 256Mb or more, for example) I need a procedure to change 
the memory node on the dts.

I was thinking of two ways:

1- The bootloader can check the DDR2 registers and find out how much 
memory is installed on board, and pass mem=128M, mem=256M or higher to 
the kernel. But what about the node on the device tree?

2- The bootloader can select the right .dts file from file-system 
choosing one of the following: dts-128M, dts-256M or dts-512M.
All those dts are EQUAL apart the memory descriptor values.

Are there any other way to have this beahviour???

Best regards,
-- 
Eurek s.r.l.                          |
Electronic Engineering                | http://www.eurek.it
via Celletta 8/B, 40026 Imola, Italy  | Phone: +39-(0)542-609120
p.iva 00690621206 - c.f. 04020030377  | Fax:   +39-(0)542-609212
