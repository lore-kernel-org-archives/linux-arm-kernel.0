From: benoar@dolka.fr (Benjamin Cama)
Date: Tue, 16 Jun 2015 11:20:47 +0200
Subject: Linkstation Mini and __machine_arch_type problem, not booting
 since 3.8
In-Reply-To: <97db3502cd014faf1c710b1cc0fe8848@dolka.fr>
References: <97db3502cd014faf1c710b1cc0fe8848@dolka.fr>
Message-ID: <1434446447.4785.7.camel@dolka.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Le lundi 15 juin 2015 ? 15:51 +0200, Benjamin Cama a ?crit :
> it didn't boot anymore at
> all: no message at all displayed, not even with earlyprintk

Note that I tried the earlyprintk=serial,ttyS0,115200 with a working
kernel as I do for the non-working ones, and it hangs at boot too, so
this is no indication, sorry.

> I bisected
> the faulty commit down to b8b499c86be58cb309964fcab5b62ac4a240a878 
> ?ARM:
> 7602/1: Pass real "__machine_arch_type" variable to 
> setup_machine_tags()
> procedure? which looks like a quite broad change, and makes me 1) not
> really understand what it does 2) astonished not to see someone else
> affected (judging by the time since it doesn't work).

I dug some more and found what changed: it simply passes the bootloader
-provided machine ID instead of the kernel-configured one! This is
quite a change indeed, which is not mentionned in the commit text. This
may seem good for vendor-provided support which assigns IDs early with
upstream, but for user one (like for this machine), the machine ID will
in general be some ID that has nothing to do with the one passed by the
bootloader. So this ought to be mentioned somewhere!

How I found this? Well, my bootloader passes a bad machine ID (526
instead of 1858), and thus the code doesn't recognize it. What I cannot
understand is why the decompressor doesn't even run with a wrong
machine ID (MMU initialization that depend on it maybe??). This is very
strange.

And also, I don't get why a more recent kernel with a hardcoded machine
ID (personal modification) doesn't work either. Maybe I should bisect
that too.

> Using the version
> prior to this commit works, but trying to revert it on some newer
> version (4.1-rc7) also fails, so the change must be something deeper
> that I can handle. Note that when I disable 
> CONFIG_CPU_FEROCEON_OLD_ID
> (it is such an old Feroceon), it still correctly displays at boot
> ?Error: unrecognized/unsupported processor variant (0x41069260).?, so
> the machine ID is somewhat read correctly.

Note about my confusion: this is the processor ID, not the machine ID.

Thanks for any help again,
--
benjamin
