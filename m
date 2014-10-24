From: balbi@ti.com (Felipe Balbi)
Date: Fri, 24 Oct 2014 14:42:50 -0500
Subject: [PATCH] ARM: remove redundant irq disable at halt and restart
In-Reply-To: <20141024192845.GC19377@localhost>
References: <1414177592-14547-1-git-send-email-johan@kernel.org>
 <20141024191627.GA11455@saruman> <20141024192111.GC11455@saruman>
 <20141024192845.GC19377@localhost>
Message-ID: <20141024194250.GF11455@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 24, 2014 at 09:28:45PM +0200, Johan Hovold wrote:
> On Fri, Oct 24, 2014 at 02:21:11PM -0500, Felipe Balbi wrote:
> > On Fri, Oct 24, 2014 at 02:16:27PM -0500, Felipe Balbi wrote:
> > > On Fri, Oct 24, 2014 at 09:06:32PM +0200, Johan Hovold wrote:
> > > > Remove redundant local_irq_disable() at machine halt and restart.
> > > > 
> > > > Since commit 44424c34049f ("ARM: 7803/1: Fix deadlock scenario with
> > > > smp_send_stop()") interrupts are disabled before stopping secondary
> > > > CPUs.
> > > 
> > > Assuming this is correct, you should have:
> > > 
> > > Fixes: 44424c3 (ARM: 7803/1: Fix deadlock scenario with smp_send_stop())
> > > Cc: <stable@vger.kernel.org> # v3.12+
> 
> It's not a bug. Just a redundant disabling of already disabled
> interrupts, something which could possibly lead someone to believe that
> interrupts could be re-enabled by the power-off handler.

I didn't dig any of this out but I'll assume you did :-) So I withdraw
my comment ;-)

> > > > diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
> > > > index a35f6ebbd2c2..5663ab57cf07 100644
> > > > --- a/arch/arm/kernel/process.c
> > > > +++ b/arch/arm/kernel/process.c
> > > > @@ -195,7 +195,6 @@ void machine_halt(void)
> > > >  	local_irq_disable();
> > > >  	smp_send_stop();
> > > >  
> > > > -	local_irq_disable();
> > > >  	while (1);
> > > >  }
> > > >  
> > > > @@ -237,7 +236,6 @@ void machine_restart(char *cmd)
> > > >  
> > > >  	/* Whoops - the platform was unable to reboot. Tell the user! */
> > > >  	printk("Reboot failed -- System halted\n");
> > > > -	local_irq_disable();
> > > 
> > > ... but wouldn't this reintroduce the the buck which that commit fixed ?
> > 
> > s/buck/bug :-) my fingers have a mind of their own, aparently.
> 
> :)
> 
> No, the interrupts would still be disabled.

alright... so far I couldn't find where IRQs are disable before
machine_power_off() is called. Starting a do_poweroff(), couldn't find
it... Oh well, I'll keep digging.

cheers

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141024/6c01e9a1/attachment-0001.sig>
