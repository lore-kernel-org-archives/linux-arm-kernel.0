From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Sun, 15 May 2016 00:44:35 +0200
Subject: Unclear BSD licensing (headers, MODULE_LICENSE, versions)
Message-ID: <CACna6ryZS1Q8=kBMMePAE_A377OReaYJdx8azZBrqG2jG+eMJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I recently received a hint that it would be nice/expected to have DTS
files licensed under BSD. I had no experience with BSD, so I started
looking at this and the way kernel parts use it.

Obviously Linux kernel is licensed under GPLv2, so all its code has to
use GPLv2 compatible license. I found 3 BSD licenses in use by kernel
code:
1) BSD 3-clause license
2) BSD 2-clause license
3) Clear BSD license

Unfortunately in many cases (of source files) I wasn't able to clearly
determine used BSD license.

First of all, an accepted ident "Dual BSD/GPL" doesn't specify BSD
version. All I can read in include/linux/module.h is "[GNU Public
License v2 or BSD license choice]". It could mean any (of GPLv2
compatible) BSD versions.


I guess ideally (in current situation) every file using "Dual BSD/GPL"
should specify BSD license version in a header. However this isn't the
case.

1) Some "Dual BSD/GPL" sources mention GPL in a header forgetting about BSD.
Can we treat such files as BSD-licensed at all? Few examples:
arch/arm/mach-pxa/am300epd.c
drivers/fmc/fmc-trivial.c
drivers/net/ppp/ppp_deflate.c
drivers/scsi/a100u2w.c
drivers/xen/xen-scsiback.c

2) Some "Dual BSD/GPL" sources don't specify BSD version in a header.
E.g. all you can find in a header is "All rights reserved. Licensed
under dual BSD/GPL license.". Two examples:
drivers/char/pcmcia/cm4000_cs.c
drivers/char/pcmcia/cm4040_cs.c


Another problem is text of BSD license

1) Some BSD 2-clause licensed sources don't link to its content.

In case of GPLv2 some sources simply mention this license and refer to
COPYING. Few examples:
a) drivers/bcma/main.c
"Licensed under the GNU/GPL. See COPYING for details."
b) drivers/block/umem.c
"This driver is released to the public under the terms of the GNU
GENERAL PUBLIC LICENSE version 2
c) drivers/mfd/tps6507x.c
"For licencing details see kernel-base/COPYING"

I believe the same could be done for BSD 2-clause license, however
there is no file that can be pointed. It results in some sources
specifying 2-clause license in a header without really providing the
content. Example:
arch/arm/boot/dts/lpc4350.dtsi

2) Some BSD 3-clause or Clear BSD licensed sources don't provide needed text

Many templates of BSD 3-clause license I found contain <organization>
that should be replaced by a proper organization/company. That makes
me suspect we can't have a generic text of BSD 3-clause or Clear BSD
in any shared file like COPYING. However there are sources that
specify one of above licenses without providing or linking its text.
Few examples:
arch/blackfin/mach-bf609/include/mach/anomaly.h
drivers/block/zram/zram_drv.c


I'm wondering how we could improve this situation. I got 2 main ideas:

1) Extend MODULE_LICENSE
We could add new acceptable entries specifying BSD version. We could
try to improve checkpatch.pl to look for a full license in a header
(it seems to be required as it has to provide <organization>). Maybe
we could figure out (with some lawyers?) how to treat sources using
"Dual BSD/GPL" mentioning GPL only (without BSD) in their header.

2) Get clear rules on how to write a header
If you find extending MODULE_LICENSE a bad idea, maybe we can simply
help people write proper headers. Explain the problem, provide
examples, maybe add some check in checkpatch.pl.

What do you think about this?

-- 
Rafa?
