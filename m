From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 13 Oct 2015 13:28:18 +0200
Subject: [RFC] arm: add __initbss section attribute
In-Reply-To: <8004E8C3-F1EC-45C3-A995-88726B257563@gmail.com>
References: <1444622356-8263-1-git-send-email-yalin.wang2010@gmail.com>
 <5369261.8uuGVmeUFP@wuerfel> <8004E8C3-F1EC-45C3-A995-88726B257563@gmail.com>
Message-ID: <5171473.bOz59Zi81c@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 13 October 2015 17:51:32 yalin wang wrote:

> > 32	__earlycon_table_sentinel
> > 200	__earlycon_of_table_sentinel
> > 6	__irf_end
> > 
> > 
> > 26398 total
> i am curious about your scripts ,
> could you show me ?

I was using some ad-hoc command line tricks, including

objcopy  -j .init.data  build/multi_v7_defconfig/vmlinux   /tmp/initdata
nm initdata  | sort -n | { read start b sym ; while read a b c ; do objdump -Dr --start-address=0x$start --stop-address=0x$a initdata > initdata.d/$sym  ; start=$a ; sym=$c  ; done }
(some manual sorting to delete the files that have pre-initialized symbols)
sum=0 ; nm /tmp/initdata  | sort -n | { read start b sym ; while read a b c ; do test -e ../$sym  && { echo $[0x$a - 0x$start]\      $sym  ; sum=$[$sum + $[0x$a - 0x$start]] ; } ; start=$a ; sym=$c ; done ; echo $sum;}

I'm sure there are better ways to do this, and the manual step I used at
first was faulty.

	Arnd
