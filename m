From: george@znau.edu.ua (George Kashperko)
Date: Sat, 07 May 2011 22:02:11 +0300
Subject: [PATCH][WAS:bcmai,axi] bcma: add Broadcom specific AMBA bus driver
In-Reply-To: <BANLkTi=6BFD4OmtU1WPxjbFJQe36=mZKEA@mail.gmail.com>
References: <1304632783-8781-1-git-send-email-zajec5@gmail.com>
	<201105061605.31625.arnd@arndb.de>
	<BANLkTikjr0ZTNOu69F+iKhwufE9KKMg4Tg@mail.gmail.com>
	<BANLkTimGBNT4FkS4mO9ToLWft0bCEYcEgg@mail.gmail.com>
	<1304790665.13983.10.camel@dev.znau.edu.ua>
	<BANLkTikLFff_86Fvg+jSty9vGLENiELF2Q@mail.gmail.com>
	<1304792795.13983.28.camel@dev.znau.edu.ua>
	<BANLkTi=6BFD4OmtU1WPxjbFJQe36=mZKEA@mail.gmail.com>
Message-ID: <1304794931.13983.44.camel@dev.znau.edu.ua>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >>
> >> The purpose is ridiculously trivial. Print user-friendly names on
> >> scanning. Why not do that?
> > Output like
> > Core 0: ChipCommon (id 0x800, rev 18, vendor 0x14e4)
> > and
> > Core 0: id 0x800, rev 18, vendor 0x14e4
> > both give to 99% of linux systems' end-users exactly the same consistent
> > information. Its more than enough for diagnostic purposes (I guess
> > scanning code does outputs this for diagnostic purposes by those less
> > than 1% of people who are aware wth is actually that ChipCommon is, not
> > to be just user friendly?).
> 
> Really, what's wrong with that? Does it kill anyone's pet we print
> this? We also do:
> pr_err("Scanning failed because of wrong CID\n");
> return -1;
> While we could drop pr_err. Why to do this? Advanced used can always
> check what -1 means.
> 
> I just like this. I find situations when it's useful, while I don't
> see real negatives. I want to keep this. Can we leave this that way?
> Unless someone finds some really bad effects of this?
Nothing wrong except it makes kernel larger while gives _absolutely_ no
benefit to end users. Regardless bus code prints core name or not it
(core name) have absolutely no impact on driver matching.

Imagine yourself an end-user who haven't got his 80211 core matched with
driver and therefore he haven't got WiFi working.
If bus driver code outputs
Core X: id 0x812, rev. 8, vendor 0x4BF
you (as end user) will look where is 0x4BF/0x812 driver supporting
rev.8.
But if bus driver code outputs
Core X: MAC 802.11 (core id 0x812, rev. 8, vendor 0x4BF)
you (as end user) empowered with MAC 802.11 name knowledge will still
look where is 0x4BF/0x812 driver supporting rev.8.

Really, there will be more and more core codes/types/name. Why hardcode
those into kernel for some e. g. memory-constraint system while you
still can (and in most cases also will) have them in dedicated drivers?

Btw, have you ever suffered hardly from PCI naming devices xxxx.xx.xx.x
but not "Network device" ?

Have nice day,
George
