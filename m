From: l.stach@pengutronix.de (Lucas Stach)
Date: Tue, 18 Aug 2015 10:28:20 +0200
Subject: [PATCH] ARM: keystone: add a work around to handle asynchronous
 external abort
In-Reply-To: <20150818081334.GK7557@n2100.arm.linux.org.uk>
References: <1439320409-20084-1-git-send-email-m-karicheri2@ti.com>
 <55CDF579.4050408@ti.com> <20150814140934.GX7557@n2100.arm.linux.org.uk>
 <55CE05EC.4040909@oracle.com> <55CE633C.10402@ti.com>
 <20150814215617.GA7557@n2100.arm.linux.org.uk> <55D25C64.3090107@ti.com>
 <55D2A1DD.9000007@oracle.com>
 <20150818081334.GK7557@n2100.arm.linux.org.uk>
Message-ID: <1439886500.31432.4.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, den 18.08.2015, 09:13 +0100 schrieb Russell King - ARM
Linux:
> On Mon, Aug 17, 2015 at 08:09:17PM -0700, santosh.shilimkar at oracle.com wrote:
> > From the logs this seems to be mostly clock related issue for some
> > peripheral. If the bootloader clock enable all hack still exists,
> > may be you can try that out.
> > 
> > Another way to debug this is to start disabling peripheral drivers
> > from the kernel 1 by 1 and see if the issue goes away.
> 
> Highly unlikely to make any difference.  As the failure happens soo early
> with the patch applied, the kernel hasn't had much of a chance to touch
> the hardware - about the only things are the decompressor and the kernel
> touching the early console.  As they seem to be working, it suggests
> that's not the cause.
> 
> It seems to be pointing towards something in the boot loader...
> 
> Normally, uboot will hook itself into the vectors to report errors, but
> I wonder whether uboot enables asynchronous aborts while it's running.
> Don't forget to make sure that the aborts are disabled again prior to
> calling the kernel.
> 
At least one of the Marvell platforms has the same issue with the
bootloader (I think it is some downstream U-Boot) leaving an imprecise
abort hanging around as a nice present for Linux to crash on.

If it turns out to be the same issue the only kernel level workaround
would be to ignore exactly 1 abort after bootup.

Then we still need a solution for the platform and the PCIe driver abort
handler both hooking into the same abort vector, which won't work
currently.

Regards,
Lucas
-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |
