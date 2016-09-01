From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 2 Sep 2016 00:02:48 +0100
Subject: [PATCH 05/33] gpio: add generic single-register fixed-direction
 GPIO driver
In-Reply-To: <87oa47l1tn.fsf@belgarion.home>
References: <87eg57e54l.fsf@belgarion.home>
 <20160830091805.GL1041@n2100.armlinux.org.uk>
 <87k2eycip0.fsf@belgarion.home>
 <20160830184612.GO1041@n2100.armlinux.org.uk>
 <87fupmc59b.fsf@belgarion.home>
 <20160831084938.GQ1041@n2100.armlinux.org.uk>
 <20160831102721.GR1041@n2100.armlinux.org.uk>
 <87twe0krym.fsf@belgarion.home>
 <20160901092754.GU1041@n2100.armlinux.org.uk>
 <87oa47l1tn.fsf@belgarion.home>
Message-ID: <20160901230248.GA1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 01, 2016 at 11:58:28PM +0200, Robert Jarzmik wrote:
> Russell King - ARM Linux <linux@armlinux.org.uk> writes:
> > On Thu, Sep 01, 2016 at 09:19:13AM +0200, Robert Jarzmik wrote:
> > It looks like:
> >
> > (a) pcmcia_probe() in drivers/pcmcia/sa1111_generic.c doesn't check the
> >     return value from the platform specific init functions, meaning if
> >     they fail, the driver still binds.  (note: they return -ENODEV to
> >     indicate that they should skip to the next platform.)
> You're right, I submitted a patch for that, and I confirm it actually happens on
> lubbock.

That'll work fine for lubbock, but not the others (we can have several
of the others enabled on sa11x0 platforms - eg, badge4 with neponset.)

> > (b) there is no clock provided for the sa1111 pcmcia device (aka "1800").
> >     This should be the same clock as pxa2xx-pcmcia.
> Again right in the spot.
> I added temporarily a clock until I have a more complete understanding in
> lubbock.c :
> +	clk_add_alias(NULL, "1800", "SA1111_CLK", NULL);
> 
> With this, things look way better :
> [    1.507480] pcmcia_socket pcmcia_socket1: pccard: PCMCIA card inserted into slot 1

Yay!

> I'm still investigating the new message errors:
> [    0.479157] genirq: Setting trigger mode 3 for irq 387 failed (sa1111_type_highirq+0x0/0x6c)
> [    0.488213] genirq: Setting trigger mode 3 for irq 389 failed (sa1111_type_highirq+0x0/0x6c)
> [    0.507449] genirq: Setting trigger mode 3 for irq 388 failed (sa1111_type_highirq+0x0/0x6c)
> [    0.516492] genirq: Setting trigger mode 3 for irq 390 failed (sa1111_type_highirq+0x0/0x6c)

Ignore those for now - the old ARM IRQ stuff was silent on that, but genirq
is more noisy.  I should probably make the sa1111 irqchip handle the both-
edge case itself.

> Moreover, I have a bit of homework as I also see :
>  - no SA1111 interrupts at all, especially nothing when I insert/remove my
>    CompactFlash card
>    This might be an effect of pxa_cplds_irqs.c I created, I must have a look.

Do you get other SA1111 interrupts (eg, the PS/2 interrupts) delivered?

>  - cat /sys/class/pcmcia_socket/pcmcia_socket1/cis 
>    cat: read error: Input/output error
>    That will cost me a review of the memory timings registers MCIO1/MECR/xxx,
>    the power lines, etc ...

Hmm, on Neponset with a CF card inserted, I can cat that, and it reports
the CIS.  Any error messages in the kernel log?

>  - cat /sys/class/pcmcia_socket/pcmcia_socket1/status 
> slot     : 1
> status   : SS_READY SS_DETECT SS_POWERON SS_3VCARD
> csc_mask : SS_DETECT
> cs_flags : SS_OUTPUT_ENA
> Vcc      : 33
> Vpp      : 33
> IRQ      : 0 (386)

That looks hopeful, but the IRQ hasn't been properly assigned (probably
because no driver has bound to the card.)

> >> As your gpios are contiguous (0 .. 31), why an array instead of a simple offset
> >> so that your translation is only a linear irq = gpio + offset ?
> >
> > There isn't a linear translation here:
> ...zip...
> > MST_PCMCIA_nCD		=> MAINSTONE_S0_CD_IRQ or MAINSTONE_S1_CD_IRQ
> > MST_PCMCIA_nSTSCHG_BVD1 => MAINSTONE_S0_STSCHG_IRQ or MAINSTONE_S1_STSCHG_IRQ
> > MST_PCMCIA_nIRQ		=> MAINSTONE_S0_IRQ or MAINSTONE_S1_IRQ
> >
> > So they aren't linear, and every "gpio" doesn't have a corresponding
> > interrupt.
> Ah yes, too bad, it would have been so much simpler.

Indeed, but a tabular approach isn't that painful, especially if we
also insist on knowing an irqdomain as well, which relieves us of
having to know absolute interrupt numbers, which may end up being
dynamically allocated eventually.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
