From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 24 May 2010 21:22:17 +0200
Subject: Initrd and 2.6.33 curious behaviour
In-Reply-To: <87hblz2alm.fsf@free.fr> (Robert Jarzmik's message of "Sun\,
	23 May 2010 12\:09\:25 +0200")
References: <874oi157c6.fsf@free.fr>
	<20100521204343.GA18032@n2100.arm.linux.org.uk>
	<87fx1k46qg.fsf@free.fr> <20100522094637.GA954@n2100.arm.linux.org.uk>
	<87pr0n31q2.fsf@free.fr> <20100523090139.GA950@n2100.arm.linux.org.uk>
	<87hblz2alm.fsf@free.fr>
Message-ID: <87r5l114wm.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Robert Jarzmik <robert.jarzmik@free.fr> writes:
> CONFIG_BLK_DEV_RAM is enabled. I'll add some debugging now and will try again.
>
OK, found out the culprit.
My bootloader(haret) is to be blamed : the first 6 bytes of initrd as the kernel
sees them are totally different from the actual 6 first bytes of initrd file.

The long story is that when haret stops wince MMU, it "reorders" the pages to
create a physically contiguous kernel and initrd, from the scattered pages
allocated in wince. The relocation algorithm is faulty, as it doesn't cope with
the cases where there is a double dependency (ie. a kernel page should be moved
to the page occupied by a initrd page, and the initrd page should be moved to
where resides the kernel page).

It's funny how people want to solve the hanoi towers problem without a spare
slot ...

Cheers.

--
Robert
