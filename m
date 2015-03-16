From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 16 Mar 2015 08:13:06 +0000
Subject: [PATCH v4 02/10] mtd: st_spi_fsm: Fetch boot device locations
 from DT match tables
In-Reply-To: <20150313160601.GI12966@brian-ubuntu>
References: <1421853868-8262-1-git-send-email-lee.jones@linaro.org>
 <1421853868-8262-3-git-send-email-lee.jones@linaro.org>
 <20150206042744.GK18140@ld-irv-0074> <20150210074634.GD8020@x1>
 <20150224050452.GG18140@ld-irv-0074> <20150224094110.GA20969@x1>
 <20150313160601.GI12966@brian-ubuntu>
Message-ID: <20150316081306.GD3383@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 13 Mar 2015, Brian Norris wrote:
> On Tue, Feb 24, 2015 at 09:41:10AM +0000, Lee Jones wrote:
> > On Mon, 23 Feb 2015, Brian Norris wrote:
> > > On Tue, Feb 10, 2015 at 03:46:34PM +0800, Lee Jones wrote:
> > > > On Thu, 05 Feb 2015, Brian Norris wrote:
> 
> [snip other discussion]

[...]

> > > Now, unless you were able to provide an additional enlightening
> > > viewpoint, then the following paragraph likely all holds true:
> > > 
> > > > > Also, I realized that all this boot device / syscfg gymnastics is just
> > > > > for one simple fact; your driver is trying to hide the fact that your
> > > > > system can't reliably handle 4-byte addressing for the boot device. Even
> > > > > if you try your best at toggling 4-byte addressing before/after each
> > > > > read/write/erase, you still are vulnerable to power cuts during the
> > > > > operation. This is a bad design, and we have consistently agreed that we
> > > > > aren't going to work around that in Linux.
> > > > > 
> > > > > Better solutions: hook up a reset line to your flash; improve your boot
> > > > > ROM / bootloader to handle 4-byte addressing for large flash.
> > 
> > Okay, I'm re-read the code and have a new understanding about the
> > boot-from-spi 'gymnastics'. 

[snipping lecture]

> I'm
> happy to return to technical points and avoid the other unpleasantness.

Yes, let's start again.

> > There is a separate controller on the platform which acts as a boot
> > device and makes the NOR chip appear as though it is memory mapped.
> > This expects the NOR Controller to be in its default state [24-bit
> > addressing] on boot.  The issue arises if a warm-reset occurs and the
> > device is still in 32-bit addressing mode.
> 
> OK, this is all familiar. This is common to many other systems.
> 
> > To minimise the risk, the
> > controller attempts to stay in 24-bit addressing mode for as long as
> > possible.
> 
> This is the part where we differ, I suppose. The "as long as possible"
> statement is still not sufficient; I believe this still leaves holes
> that simply cannot be fixed in Linux.

Linux supports lots of devices which are not perfect.  Minimising risk
to error prone hardware is one of software's key roles.  Being a
software guy, I don't like it any more than you do, but it is a fact
of life that hardware isn't perfect.  That's why the Linux kernel
supports a truck-load of 'errata' and 'quirks'.  Saying "we're not
going to support that in Linux" doesn't sound like the right attitude
to me.

So when you said "we have consistently agreed that we aren't going to
work around that in Linux", who has agreed this.  Would you be kind
enough to point me in the direction of that conversation please?

> > You mentioned power-cuts.  I do not believe this to be an issue, as
> > when the power is completely removed the controller will reset back
> > into default state.  Only warm-resets are an issue.
> 
> You're right: power cuts shouldn't be a problem. But what about other
> unexpected warm resets? (Watchdogs?) Do you have any solution for them?

They are possible and are the point of the patch.  If they happen
while we're in 24bit mode, we risk corruption.  The best solution
provided by out estrange colleague is provided in this set.  The risk
of a soft reset happening during the small amount of time that we're
in 32bit mode is considered acceptable.  Without this patch, the risk
is significantly more substantial.

> > > > > What's the possibility of dropping all this 4-byte address toggling
> > > > > shenanigans? This will be a blocker to merging with spi-nor.c.
> > 
> > We wouldn't be able to remove this code without significantly
> > weakening resilience to warm-reset mishaps, and changing the hardware
> > design for devices which have already been released is obviously out
> > of the question.
> 
> Then maybe we can't solve this. That doesn't mean that upstream will
> support you, though.
> 
> Problems like this are why "release early, release often" makes sense.
> If your employer didn't take the "fire the engineers and dump software
> support to the community" approach, but rather honestly engaged on
> driver support earlier, then perhaps your employer could have fixed the
> SoCs/boot ROMs/board designs earlier, rather than later, and you
> wouldn't be stuck trying to wedge in upstream workarounds for bad
> designs in the wild.

These lessons have now been learnt.  The attitude to upstreaming in
the present day is vastly different to how it was when this driver was
initially authored.

As for the business decisions you allude to, I'm afraid I have no
influence in those and am not qualified to comment. ;)

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
