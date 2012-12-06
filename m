From: shijie8@gmail.com (Huang Shijie)
Date: Thu, 6 Dec 2012 09:58:13 -0500
Subject: [PATCH] mtd: nand: gpmi: reset BCH earlier, too, to avoid NAND
 startup problems
In-Reply-To: <20121206095213.GA2589@pengutronix.de>
References: <1354740362-20412-1-git-send-email-w.sang@pengutronix.de>
 <50BFFFE8.8040002@freescale.com>
 <20121206095213.GA2589@pengutronix.de>
Message-ID: <CAMiH66EPDKhd=pBJWhtm3P+qgGcdVbHD-hb93ZB7Ou7Sc=vByg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 6, 2012 at 4:52 AM, Wolfram Sang <w.sang@pengutronix.de> wrote:
> On Thu, Dec 06, 2012 at 10:16:08AM +0800, Huang Shijie wrote:
>> ? 2012?12?06? 04:46, Wolfram Sang ??:
>> > correctly after warm rebooting, so the kernel could not find the UBI or
>> which Soc do you meet this issue? the mx23 or mx28?
>
> MX28.
>
>> It's bad news to me. I ever thought the BCH-reset-issue is gone.
>> I ever tested many times in mx28(> 10000 times) with freescale's uboot.
>
> Did you power-cycle between each test or reboot? I still need to test if
What's the meaning of "power-cycle"?
I only tested with the soft reset, the power is never shut down.


> this really makes a difference, but I think the issue shows more often
> when only rebooting.
>
>> I guest you are not use the freescale's uboot. The uboot also will reset
>> the BCH/GPMI.
>
> I just checked its sources. It also has this flaw. GPMI and BCH need to
> be reset at the same time, i.e. before first commands are sent to the
> NAND (although they don't need ECC).
>

With your patch, we have resetted the BCH twice in the driver. Could
we only reset BCH one time?
Do you ever remove another reset-bch code, and test it?
Frankly speaking, it's strange to reset the BCH twice, and it makes no sense. :(
I am afraid that we have to add three-reset-bch in the future, if we
can not find the root cause.
If you can remove another reset-bch code, i will ack the patch.


> I use barebox, but that isn't of importance here. If I don't fix
> barebox, I see NAND issues in barebox or the kernel. If I fix barebox, I
> still see issues in the kernel, but not in barebox anymore.
>
I ever met the same case with the freescale's BSP code.
I fixed the issue in uboot, and fixed the driver too.



> The setup needs to be done properly to ensure a consistent state at the
> beginning, especially when somebody used the NAND before (ROM code,
At the beginning? it's really interesting.
I want to test it myself.

could you wait for some time?

Best Regards
Huang Shijie


> bootloader). Fixing the bootloader alone is not enough.
>
> Thanks,
>
>    Wolfram
>
> --
> Pengutronix e.K.                           | Wolfram Sang                |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.10 (GNU/Linux)
>
> iEYEARECAAYFAlDAas0ACgkQD27XaX1/VRs8iQCgrqb5nADGL5Dyi+csfSdSLWSR
> /mUAoJN91gz+1QiqVUsNdHtwX9jpAdZC
> =nMk3
> -----END PGP SIGNATURE-----
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
