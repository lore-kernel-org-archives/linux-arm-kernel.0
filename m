From: T.Crueger@fh-trier.de (Till Crueger)
Date: Fri, 01 Mar 2013 15:48:06 +0100
Subject: Starting the kernel on Core1 of a Cortex-A9 system
Message-ID: <5130BFA6.5020701@fh-trier.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

For some experimentation with multicore architecture I am currently
trying to get a Linux system to run on Core1 of a OMAP44xx System
(Pandaboard) instead of on Core0.

So far I can get the system to run cleanly to run on core1 by manually
starting the core1 from the bootloader and then starting the kernel on
core1 instead of core0 (with max_cpus=1). However this only works if I
use an uncompressed Linux image.

If I try to use a compressed version of the image, the startup procedure
fails shortly after the decompression while patching the physical to
virtual translations. I had a look at the translation tables, and
noticed they contain invalid addresses, which explains why the startup
crashes at this point.

Further debugging this problem I noticed that the correct addresses are
written to memory during decompression, but are lost as soon as the MMU
is turned of in the decompression code. I.e. I can see the correct
addresses in the debugger while the MMU is active, but as soon as I it
is turned of, the old adresses re-appear, as if they never were written
back.

I had a close look at the code handling the MMU and I cannot find
anything which should be core specific there, so I am a bit puzzeled by
this behavior. I also already talked to Catalin Marinas who wrote the
code in the first place, and he suggested that the ACTLR setting might
be different (thanks for this hint). However I checked and this register
is the same on both cores (SMP and FW set, all other flags not set).

Does anybody have any other possible explanation why this behavior might
be different on Core0 and Core1? The Bootloader (U-Boot) only runs on
Core0 so there might be some initialization that is missing for Core1,
but I cannot figure out which one.


Thank you for your time,
  Till Crueger

- -- 
Dipl. Inform. Till Crueger

Department of Computer Science
Hochschule Trier ? Trier University of Applied Sciences
Postfach 1826
54208 Trier
GERMANY
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJRML+mAAoJEMyqYnfSqLbVxjgH/0SI0WGI2nMyMSanhEr0m8nQ
1YCcLooRJnDu9ltf40X1wAvPPbbHq3SZAZ9Y+/imZOqXIyuwMw/ru1fFp+gckQvX
UHi00zup7CLjL1udnmFBUfFjE9kylafg/HuwTWOvBaOdmdsGAc/fdyvmLFC/io47
ADuwD1LOhaLE1+mPQD567Z6LGpeSJQbIiI2/f32TmCc0dPL5aGN72EPVAvAMs2DD
3Gqgxu+d6lGQvaHuQ0wR93T3/7L72Na3EvKee7xtjcu3gR4amqeT7w4Gk4mnrvuI
krGCfsc1fRICaGsPv4G3x7hw56yO5MAqO2EB7nlPCll+TQ4m8Rkh3HSyeGKyxEw=
=cZ+o
-----END PGP SIGNATURE-----
