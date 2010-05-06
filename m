From: yauhen.kharuzhy@promwad.com (Yauhen Kharuzhy)
Date: Thu, 6 May 2010 17:49:55 +0300
Subject: S3C6410 power management support status
In-Reply-To: <20100504002420.GQ6684@trinity.fluff.org>
References: <20100429124509.GA11290@jeknote.loshitsa1.net>
	<20100504002420.GQ6684@trinity.fluff.org>
Message-ID: <20100506144955.GA24641@jeknote.loshitsa1.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 04, 2010 at 01:24:20AM +0100, Ben Dooks wrote:
> On Thu, Apr 29, 2010 at 03:45:09PM +0300, Yauhen Kharuzhy wrote:
> > Hi.
> > 
> > Can anybody explain current status of S3C6410 power management support
> > in mainline? Suspend-to-RAM looks completely broken in the current
> > Linus's git tree.
> 
> I'd prefer if you didn't make sweeping accusations about the state of
> a given piece of the kernel without having a good look first. From reading
> your second post, it seems that what is actually the problem is that the
> 64XX support only currently handles wakeup configurations from the EINT
> pins.

I am sorry for my hasty opinion about StR.

But we have checked Suspend-to-RAM at our (custom, not SMDK) board just now
and it is not works with EINT too. Kernel goes to sleep and never
return. We found that XPWRRGTON pin isn't
changed at sleep instruction execution so CPU don't go to sleep state. If anybody
can say something about reasons of this, please say.

Can anybody check suspend mode with SMDK6410 and confirm that StR works
on it? If it works, we will stop to ask stupid questions and will find
our hardware bugs :)

Below is log of sleeping procedure:
-----------------------------------------------------------------------
/sys/power # echo mem > state
s3c64xx_irq_pm_suspend: suspending IRQs
saved f4500280 value 000003ff
saved f4500900 value 00400000
saved f4500904 value 00000000
saved f4500910 value 00000000
saved f4500914 value 00000000
saved f4500918 value 00000000
saved f450091c value 00000000
saved f4500920 value 0ffff7ff
saved f4300044 value 00000210
s3c_pm_enter(3)
s3c_sleep_save_phys=0x503cac18
GPA: save 00000000,22222222,0000007a,00002955
GPB: save 00000000,02212222,0000007b,00002955
GPC: save 00000000,11331000,00000010,00005055
GPD: save 00000000,00000000,00000000,00000155
GPE: save 00000000,00000000,00000000,00000155
GPF: save 50000000,00008000,55555555,00000000
GPG: save 00000000,03222222,0000003e,00002000
GPH: save 33222222,00000033,000003fe,00000000
GPI: save aaaaaaaa,00000000,00000000,00000000
GPJ: save 00aaaaaa,00000f00,00000000,00000000
GPK: save 22222222,22222222,00000000,55555555
GPL: save 12121122,02222211,0000038c,15555555
GPM: save 00000000,00222222,0000001f,000002aa
GPN: save 55940454,0000f81a,55955555,00000000
GPO: save aaaaaaaa,0000003f,00000000,00000000
GPP: save 2aaaaaaa,000038e7,1011aaa0,00000000
GPQ: save 0002aaaa,00000018,00000000,00000000
UART[0]: ULCON=0007, UCON=0785, UFCON=0011, UBRDIV=0000
UART[1]: ULCON=002b, UCON=0385, UFCON=0011, UBRDIV=0003
UART[2]: ULCON=0003, UCON=0385, UFCON=0011, UBRDIV=001f
UART[3]: ULCON=0007, UCON=0785, UFCON=0011, UBRDIV=0000
saved f4100100 value 04000000
saved f4100104 value 00000000
saved f4100108 value 00000000
saved f45001a0 value ffcd1501
saved f45001b0 value 00000000
saved f45001b4 value 00000000
saved f45001c0 value 00000000
saved f45001c4 value 00000000
saved f45001c8 value 00000000
saved f4100000 value 0000ffff
saved f4100004 value 0000ffff
saved f4100008 value 0000ffff
saved f410001c value 00000007
saved f4100020 value 01043310
saved f4100024 value 00000000
saved f4100028 value 00000000
saved f410002c value 00000000
saved f4100030 value fffffff7
saved f4100034 value fb9e6fff
saved f4100038 value c73fffff
saved f410003c value ffffffff
saved f4100018 value 00000000
saved f4100014 value 00200203
saved f45001d0 value 10555551
saved f45001d4 value 00555555
sleep: irq wakeup masks: ffffffff,fffff7ff
------------------------------------------------------------------------------

-- 
Yauhen Kharuzhy
-----------------------------------------------------------
Promwad Innovation Company
22, Olshevskogo St.
Office 809
220073, Minsk, Belarus
Phone/Fax: +375 (17) 312-1246
E-mail: yauhen.kharuzhy at promwad.com
Skype: jekhor
Web: www.promwad.com
