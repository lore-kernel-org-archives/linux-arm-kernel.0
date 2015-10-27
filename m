From: alison.wang@freescale.com (Huan Wang)
Date: Tue, 27 Oct 2015 14:40:21 +0000
Subject: [PATCH v4] ARM: configs: Add Freescale LS1021A defconfig
In-Reply-To: <5073362.oArWDzYkxD@wuerfel>
References: <1442480614-32345-1-git-send-email-b18965@freescale.com>
 <5232654.e6dagm53H4@wuerfel>
 <BN3PR0301MB0867A87B64E1206B773F05EEFE3E0@BN3PR0301MB0867.namprd03.prod.outlook.com>
 <5073362.oArWDzYkxD@wuerfel>
Message-ID: <BN3PR0301MB0867C51A52319367F981C630FE230@BN3PR0301MB0867.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Thursday 15 October 2015 02:11:57 Huan Wang wrote:
> > > On Wednesday 14 October 2015 10:18:47 Huan Wang wrote:
> > > > > On Thursday 24 September 2015 07:27:10 Huan Wang wrote:
> > > > > > > On Fri, Sep 18, 2015 at 4:38 AM, Huan Wang
> <alison.wang@freescale.com> wrote:
> > > > > > Any suggestion? Thanks.
> > > > >
> > > > > Try enabling DEBUG_LL for your platform to get some debug
> > > > > output, if you still don't get any helpful messages, try also
> > > > > inserting
> > > > >
> > > > >       printascii(__func__);
> > > > >
> > > > > statements in the early boot process to see how far you get
> before the hang.
> > > > >
> > >
> > [Alison Wang] ls1021a uses duart as the default serial port, not
> > lpuart. So
> > 8250/16550 serial driver is used. Let me explain my debug process in
> detail.
> 
> Ah, I see.
> 
> > When CONFIG_VMSPLIT_2G is used, I could boot up the whole kernel and
> > get the print message " Booting Linux on physical CPU 0xf00" after
> "Starting kernel"
> > as below.
> >
> > Starting kernel ...
> > [    0.000000] Booting Linux on physical CPU 0xf00
> > .....
> >
> > But when CONFIG_VMSPLIT_3G is used, I couldn't get print message "
> > Booting Linux on physical CPU 0xf00". It only hangs at  "Starting
> kernel ...".
> >
> > Moreover, I add some asm code in __turn_mmu_on to print some simple
> > characters, and I could get the print characters when
> > CONFIG_VMSPLIT_3G is used. So I guess there is something wrong with
> the page tables.
> 
> Ok. What I was suggesting above though was to try to pinpoint exactly
> where it goes wrong. You have verified that it does not crash before the
> page tables are enabled, but that is very early. You have also shown
> that the kernel crashes before the point at which the 'Booting Linux on
> physical CPU 0xf00' message is printed to the kernel, but that is *much*
> later: setup_arch() calls parse_early_param(), which in turn sets up
> early_console_write(). This means the 'Booting Linux on physical CPU
> 0xf00'
> is still stuck in the log buffer and you may have crashed someone
> inbetween.
> 
> If you can call printascii(), you can try to do that just after enabling
> the page tables to see if that was the problem like you suspect, or
> otherwise add more printascii() statements between __turn_mmu_on and
> parse_early_param() to pinpoint the exact code that breaks.
[Alison Wang] Thank you very much for your help. The issue is fixed.

Best Regards,
Alison Wang
