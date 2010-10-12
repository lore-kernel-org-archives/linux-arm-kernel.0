From: thomas.nemeth@betatech.fr (Thomas Nemeth)
Date: Tue, 12 Oct 2010 11:59:56 +0200
Subject: mx31: external abort on non-linefetch (debugging suspend to RAM)
Message-ID: <201010121159.57222.thomas.nemeth@betatech.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


    Hi!

    I've already posted a message some time ago about handling suspend
    to RAM for iMX31 processors. I added a pm.c file I extracted from
    the old 2.6.22 freescale-provided kernel to make it up-to-date and
    also used the one Andy Green showed me.

    However, whatever I try, the CPU still does not want to wake up
    after beeing put into State Retention mode. Apart from the muxing,
    our CPU board is very much like the mx31ads board with several
    resources added.

    There is a new symptom today. A long time ago I made a little
    program usefull to quickly dump some registers. It only does a
    simple mmap on /dev/mem with adjusted pages sizes and offsets and I
    used to use it everywhere, on several processors. Using it on the
    2.6.22 and the ADS works fine to dump the CCMR register. But using
    it on our new board gives this :

# insight -D ./iMX31-regs.defs -R CCMR
Unhandled fault: external abort on non-linefetch (0x008) at 0x40000000
Bus error

    For those wanting to have a look at my program, I can send the
    tarball by mail.

    On the MX31ADS the result is the following one :
mx31# ./insight -D iMX31-regs.defs -R CCMR
CCMR: 0x074B097D
  FIELD            HEX              BIN DEC.
  FPME      :        1                1 (1)
  PRCS      :        2               10 (2)
  MPE       :        1                1 (1)
  SBYCS     :        1                1 (1)
  ROMW      :        3               11 (3)
  MDS       :        0                0 (0)
  SPE       :        1                1 (1)
  UPE       :        0                0 (0)
  WAMO      :        0                0 (0)
  FIRS      :        1                1 (1)
  reserved  :        0                0 (0)
  LPM       :        0                0 (0)
  RAMW      :        3               11 (3)
  SSI1S     :        2               10 (2)
  reserved  :        0                0 (0)
  SSI2S     :        2               10 (2)
  reserved  :        0                0 (0)
  PERCS     :        1                1 (1)
  CSCS      :        1                1 (1)
  FPMF      :        1                1 (1)
  WBEN      :        0                0 (0)
  VSTBY     :        0                0 (0)
  L2PG      :        0                0 (0)
  reserved  :        0                0 (0)


-- 
Thomas Nemeth - Ing?nieur d'?tudes en Informatique Industrielle
? ? ? ? ? ? ? ? Industrial Computing Software Designer
BETAtech - 15, rue Apollo, Z.A. de Montredon, 31240, L'Union.
05 34 30 40 00 (standard) ?/ ?05 34 30 40 09 (ligne directe)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101012/4154b591/attachment.sig>
