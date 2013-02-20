From: balbi@ti.com (Felipe Balbi)
Date: Wed, 20 Feb 2013 21:16:38 +0200
Subject: [RFC/NOT FOR MERGING 2/3] serial: omap: remove hwmod dependency
In-Reply-To: <alpine.DEB.2.00.1302191530190.32069@utopia.booyaka.com>
References: <1360840554-26901-1-git-send-email-balbi@ti.com>
 <1360840554-26901-2-git-send-email-balbi@ti.com>
 <20130214171253.GC7144@atomide.com>
 <20130214175650.GA25891@arwen.pp.htv.fi>
 <20130214181217.GA11806@atomide.com>
 <20130214192719.GB26679@arwen.pp.htv.fi>
 <20130214193911.GD11806@atomide.com>
 <alpine.DEB.2.00.1302141946110.11016@utopia.booyaka.com>
 <20130215064429.GA30038@arwen.pp.htv.fi>
 <alpine.DEB.2.00.1302191530190.32069@utopia.booyaka.com>
Message-ID: <20130220191638.GA25609@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Feb 20, 2013 at 05:38:49PM +0000, Paul Walmsley wrote:
> > > Drivers shouldn't touch their IP block's SYSCONFIG registers.  They don't 

just now I noticed this fun fact:

"driver's should touch *their* SYSCONFIG registers"

You're stating yourself that SYSCONFIG belongs to the IP and the IP is
fully controlled by its driver. ;-)

> > why not ? It's part of the driver's address space anyway. It's not part
> > of the IP in question (usb, ethernet, etc) but it's part of the TI
> > wrapper which usually involves a bridge (ocp2scp, ocp2axi, etc) plus the
> > TI-specific integration registers (revision, sysc, syss...).
> > 
> > So they're not part of the licensed IP, but they're part of the TI
> > wrapper around those.
> 
> Ideally Linux drivers would be as independent as possible from their SoC- 
> or board-specific integration.  This includes bus integration, etc.  That 
> way, an IP block like UART, where most or all of the registers are shared 
> with the common 8250 code, might be able to use a shared driver.

right, then why did we even bother adding omap-serial ? If the whole
idea was to hide integration, what was the point in introducing
omap-serial ?

> Also, it should be noted that the TI wrapper isn't necessarily common to 
> all TI SoCs :-)  The wrapper bits and functions can change from TI SoC to 
> SoC.

yeah, that's because of the chassis architecture definition and has
little value to current discussion ;-)

> > > have anything specifically to do with the underlying device IP block, but 
> > 
> > of course they do, soft reset touches the underlying IP, so does force
> > idle, no idle, etc. 
> 
> Force idle, no idle, etc. only affects what's reported to the PRCM via 
> the SIdleAck/MStandbyReq lines.  It shouldn't affect anything in the IP 
> block itself.

It does touch the IP block. After the asynchronous PM handshake
(Ack-Req) is successful the IP block isn't in a usable state.

> As far as reset goes, the chip-wide reset bits affect the IP block too, 
> but we wouldn't put that code into the drivers :-)

why not ? What happens when drivers need to reset the IP ? For cases
where we need "reset in runtime", drivers are the best entities to know
exactly where the IP must be reset.

Also, IMHO reset should always be done during probe() so driver can be
dead sure that we're starting from a known state. This is even more
important for the complex IPs which are licensed from RTL vendors and
are used in different SoCs. While arch/arm/mach-abc/ resets every IP
pior to probe() being called, we can't be sure that arch/arm/mach-xyz/
will do the same thing and imposing such requirement is too difficult.

Problem just gets worse when you consider SoCs from completely different
architectures (say ARM and Blackfin) using the same IP licensed from
a particular RTL vendor.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130220/8a737f8f/attachment.sig>
