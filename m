From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Tue, 22 Dec 2015 10:48:08 -0500
Subject: [PATCH] soc: mediatek: SCPSYS: use builtin_platform_driver
In-Reply-To: <CAGS+omDrZO8PteeFZMes0QRjG2KLhMG=qacFrho+UFPVAG=YXg@mail.gmail.com>
References: <1450437573-32079-1-git-send-email-matthias.bgg@gmail.com>
 <CAGS+omA822+-srskZ08pa72xVTMFbWLkaZD0za=3MCBryS6PRg@mail.gmail.com>
 <CAGS+omDrZO8PteeFZMes0QRjG2KLhMG=qacFrho+UFPVAG=YXg@mail.gmail.com>
Message-ID: <20151222154808.GC12458@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Re: [PATCH] soc: mediatek: SCPSYS: use builtin_platform_driver] On 22/12/2015 (Tue 21:36) Daniel Kurtz wrote:

> Hi Matthias,
> 
> One thing below is missing from this version of the patch...
> 
> > On Fri, Dec 18, 2015 at 7:19 PM, Matthias Brugger
> > <matthias.bgg@gmail.com> wrote:
> >> SCPSYS can't be built as module. Use builtin_platform_driver instead.
> >> For this probe must not be __init and the data accessed can't be
> >> __initconst. Remove this macros. To make the impact as small as possible,
> >> fold scp_domain_data into scp_domain via a pointer.
> 
> [snip]
> 
> >> @@ -542,10 +533,11 @@ static const struct of_device_id of_scpsys_match_tbl[] = {
> >>  };
> >>
> >>  static struct platform_driver scpsys_drv = {
> >> +       .probe = scpsys_probe,
> >>         .driver = {
> >>                 .name = "mtk-scpsys",
> 
> This was in Sascha's version of the patch:
> 
>   .suppress_bind_attrs = true,

Unless you've got a very specific use case where an unbind makes sense
(like a quad port ethernet card, where you unbind one port and then do
PCI pass through of it to a kvm guest for example) then yes, you should
suppress unbind.  So for most drivers aimed at a single device, or where
being built in but unbinding just makes no sense for any possible use
case, then yes you should set the above.

Paul.
--

> 
> Do we still need it now that we use "builtin_platform_driver"?
> 
> >>                 .owner = THIS_MODULE,
> >>                 .of_match_table = of_match_ptr(of_scpsys_match_tbl),
> >>         },
> >>  };
> >> -builtin_platform_driver_probe(scpsys_drv, scpsys_probe);
> >> +builtin_platform_driver(scpsys_drv);
> >> --
> >> 2.6.2
> >>
