From: dinguyen@altera.com (Dinh Nguyen)
Date: Sat, 2 Feb 2013 13:37:21 -0800
Subject: [PATCHv2 for soc 4/4] arm: socfpga: Add SMP support for actual
 socfpga harware
In-Reply-To: <20130202192409.GA17736@amd.pavel.ucw.cz>
References: <1359651943-21752-1-git-send-email-dinguyen@altera.com>
 <1359651943-21752-5-git-send-email-dinguyen@altera.com>
 <20130201035040.GE4838@quad.lixom.net>
 <20130201104655.GA3124@amd.pavel.ucw.cz>
 <71B37E0559AC6849A68C5BA94C509FB45A63D4E47D@SJ-ITMSG02.altera.priv.altera.com>
 <20130201153152.GS23505@n2100.arm.linux.org.uk>
 <1359736762.2932.1.camel@linux-builds1>
 <20130202192409.GA17736@amd.pavel.ucw.cz>
Message-ID: <71B37E0559AC6849A68C5BA94C509FB45A645BA4EA@SJ-ITMSG02.altera.priv.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pavel,

> -----Original Message-----
> From: ZY - pavel
> Sent: Saturday, February 02, 2013 1:24 PM
> To: Dinh Nguyen
> Cc: Russell King - ARM Linux; olof at lixom.net; linux-arm-
> kernel at lists.infradead.org; arnd at arndb.de
> Subject: Re: [PATCHv2 for soc 4/4] arm: socfpga: Add SMP support for
> actual socfpga harware
>
> Hi!
>
> > > > > I actually thought about that... but could not think of non-
> ugly way
> > > > > of doing that. I hope dts will normally be "right" for any
> production
> > > > > system...
> > > >
> > > > I think a panic is better just for the reason that if someone is
> > > > expecting SMP, but missed the warning message, and later finds
> out that
> > > > the secondary core never came up, it would save some debugging
> time.
> > > >
> > > > Since I have to send out a v3 from the 1st patch anyways, let me
> verify
> > > > that I can get the early warning.
> > >
> > > The choice is between a panic() at a point where the only way to
> find
> > > out is to throw in printascii() or a working printk, and ending up
> with
> > > an unbootable kernel, vs continuing the boot and having an almost
> > > working system which can be logged into and the messages viewed.
> > >
> > > If you have an application which relies on the second CPU coming
> up,
> > > why not have it verify that the second CPU came up (it's quite easy
> > > to do - there's POSIX standard libc calls to get the number of
> online
> > > CPUs).
> >
> > Point taken...thanks Russell.
>
> Well, I don't think we normally check dtbs for validity with
> user-helpful error messages, but it is relatively easy in this case.
>
> ---cut here---
>
> Continue booting with second core disabled if cpu1-start-addr is not
> present in .dtb.
>
> Signed-off-by: Pavel Machek <pavel@denx.de>
>
> diff --git a/arch/arm/mach-socfpga/platsmp.c b/arch/arm/mach-
> socfpga/platsmp.c
> index 81e0da0..90facdd 100644
> --- a/arch/arm/mach-socfpga/platsmp.c
> +++ b/arch/arm/mach-socfpga/platsmp.c
> @@ -82,6 +82,9 @@ static void __init socfpga_smp_init_cpus(void)
>               ncores = 1;
>       }
>  #endif
> +     if (!cpu1start_addr)
> +             ncores = 1;
> +

This will not work because of commit 5587164eea4aad88fcb79d9b21dc8f14fea598cd
I sent out a V3 series of this patch, CPU1 will simply fail to come online if
cpu1-start-addr is not defined.

Dinh

>       for (i = 0; i < ncores; i++)
>               set_cpu_possible(i, true);
>
> diff --git a/arch/arm/mach-socfpga/socfpga.c b/arch/arm/mach-
> socfpga/socfpga.c
> index 334c330..c3cd88b 100644
> --- a/arch/arm/mach-socfpga/socfpga.c
> +++ b/arch/arm/mach-socfpga/socfpga.c
> @@ -74,10 +74,9 @@ static void __init socfpga_sysmgr_init(void)
>
>       np = of_find_compatible_node(NULL, NULL, "altr,sys-mgr");
>
> -     if (of_property_read_u32(np, "cpu1-start-addr", (u32 *)
> &cpu1start_addr)) {
> -             early_printk("Need cpu1-start-addr in device tree.\n");
> -             panic("Need cpu1-start-addr in device tree.\n");
> -     }
> +     if (of_property_read_u32(np, "cpu1-start-addr", (u32 *)
> &cpu1start_addr))
> +             printk(KERN_ALERT "Need cpu1-start-addr in device tree for
> SMP operation.\n");
> +
>       sys_manager_base_addr = of_iomap(np, 0);
>
>       np = of_find_compatible_node(NULL, NULL, "altr,rst-mgr");
>
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures)
> http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html


Confidentiality Notice.
This message may contain information that is confidential or otherwise protected from disclosure. If you are not the intended recipient, you are hereby notified that any use, disclosure, dissemination, distribution,  or copying  of this message, or any attachments, is strictly prohibited.  If you have received this message in error, please advise the sender by reply e-mail, and delete the message and any attachments.  Thank you.
