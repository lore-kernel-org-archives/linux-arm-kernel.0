From: l.stach@pengutronix.de (Lucas Stach)
Date: Wed, 14 Oct 2015 11:48:45 +0200
Subject: bcm4708-smartrg-sr400ac boot failures in next-20150918+
In-Reply-To: <CANMBJr4H1C6CHdRXa_NL9dssYGLkpRKAPXCMOV0FsUdb8JiSXg@mail.gmail.com>
References: <CANMBJr5FnRQxv01CbAiSD43dGn+Ea4tjEWSsV1FywHJZYLnG_A@mail.gmail.com>
 <560DA9B9.80404@hauke-m.de> <561AE788.6030701@hauke-m.de>
 <CANMBJr4H1C6CHdRXa_NL9dssYGLkpRKAPXCMOV0FsUdb8JiSXg@mail.gmail.com>
Message-ID: <1444816125.13276.8.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tyler,

Am Dienstag, den 13.10.2015, 11:49 -0700 schrieb Tyler Baker:
> On 11 October 2015 at 15:49, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> > Adding the arm List.
> >
> > On 10/01/2015 11:46 PM, Hauke Mehrtens wrote:
> >> On 10/01/2015 07:50 PM, Tyler Baker wrote:
> >>> Hi Hauke, Rafal,
> >>>
> >>> The kernelci.org bot has been reporting complete boot failures[1]
> >>> since next-20150918. I've bisected[2] the issue and found "ARM:
> >>> 8422/1: enable imprecise aborts during early kernel startup" is the
> >>> offending patch. Reverting this on top of -next fixes the boot issue.
> >>>
> >>> Apologies for sending this off list, but I want to make sure you can
> >>> confirm this issue before we raise it.
> >>>
> >>> Cheers,
> >>>
> >>> Tyler
> >>>
> >>> [1] http://kernelci.org/boot/bcm4708-smartrg-sr400ac/
> >>> [2] http://hastebin.com/mirunerobi.vhdl
> >>>
> >> Hi Tyler,
> >>
> >> Thanks for the info, the broken bootloader causes some problems when
> >> booting the kernel, we already had to ignore some exceptions. I will
> >> look into this at the weekend.
> >>
> >> Hauke
> >>
> > Hi,
> >
> > The commit "ARM: 8422/1: enable imprecise aborts during early kernel
> > startup" breaks bcm53xx devices with a broken boot loader, this is a
> > regression. There are probably millions of these devices shipped with
> > this boot loader called CFE.
> > For BCM53xx we install a fault handler in the init_early callback of
> > DT_MACHINE_START to ignore the faults produced by the boot loader in
> > http://lxr.free-electrons.com/source/arch/arm/mach-bcm/bcm_5301x.c#L40 ,
> > but init_early is called after local_abt_enable() gets called and this
> > causes a kernel panic because of any unhandled CPU fault. The reserve()
> > callback in DT_MACHINE_START was the only callback I could find which
> > gets called before local_abt_enable(), should I move the code which
> > installs the fault handler there?
> >
> > This is causing the problems in kernelci with linux next kernels on this
> > board: http://kernelci.org/boot/bcm4708-smartrg-sr400ac/
> 
> Adding Russell, and Lucas to CC as they may be interested in this thread.

Thanks for looping me in and sorry about the regression.

I think we really want to keep enabling the imprecise aborts as early as
possible to catch them near the spot where they did happen.

So I think the right thing to work around your broken bootloader is to
install the fault handler earlier. Russell, do you have any objections
to that?

I think there are some other SoCs that need a similar workaround, if we
agree to move the fault handler installation to an earlier stage I'll
audit other places and send patches if needed, so we can fix this up
before this commit ends up in a pull to Linus.

Regards,
Lucas

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |
