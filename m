From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 9 Dec 2012 09:30:46 +0100
Subject: [PATCH] ARM: Orion: Hoist bridge interrupt handling out of the
 timer
In-Reply-To: <20121209025748.GA10405@obsidianresearch.com>
References: <20121207225507.GB29262@obsidianresearch.com>
 <20121208112624.GD25315@lunn.ch>
 <20121209025748.GA10405@obsidianresearch.com>
Message-ID: <20121209083046.GA25466@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 08, 2012 at 07:57:48PM -0700, Jason Gunthorpe wrote:
> On Sat, Dec 08, 2012 at 12:26:24PM +0100, Andrew Lunn wrote:
>  
> > 1) It should have an IRQ domain, like the other IRQ chips we have.
> > 2) It should have a DT binding, like the other IRQ chips we have.
> 
> I was going to look at a DT binding for this as a follow on, since
> I'll want to bind to these interrupts. 
> 
> Are you OK with keeping this patch as is and seeing DT in a follow up,
> or as a series? It is already pretty big.

Hi Jason

A patch series is great. However, its not so good practice to add
something on the first patch, and then move it somewhere else in the
next. So i would suggest initializing the controller in
kirkwood_irq_init(), etc as its added.

> > 4) We than pass the watchdog interrupt via DT.
> 
> Right now the watchdog driver is coded to cause a board reset, so it
> doesn't use interrupts at all. Adding interrupt support to watchdog
> seems orthogonal to this?

Yes, its orthogonal, but a logical extension which could be part of a
patchset.
 
> What would it look like? For my boards I want the watchdog to panic(),
> because I have another watchdog that takes care of reset, but that
> won't be universal.

There are examples of watchdogs that allow this. However, none yet
have DT bindings. I would suggest adding an optional property,
"panic", which indicates the driver should panic rather than
reboot. Make sure to run this by the device tree mailing list.
 
> > 3) We then pass the timer interrupt via DT to the timer driver.
> > 3) is not so simple, because we currently don't have a timer binding
> > for Orion SoC. However, with this cleanup, we are much closer to being
> > able to use the 370/XP timer code.
> 
> Interesting.. The 370/XP is a more advanced version of the same timer
> IP, there are several registers that driver is touching that are not
> HW supported, at least on kirkwood.

Yes, the 25MHz and the divider for example. I'm not 100% sure it will
actually work, it will need a different compatibility string, and a
bit of configuration based on that string, but i think it goes. If you
compare the two different drivers, they are very similar.

> The two DT bindings are straightforward, and my testing on Kirkwood
> should cover alot - but it would be great if non-kirkwood boards could
> review/test with this patch..
> 
> Do you expect a DT conversion for all orion_time_init users, or just
> the one I can test or ..?

Please take a stab at converting them all. We have an active set of
testers. I can test kirkwood and orion5x, Sebastian tests Dove, Thomas
and Gregory test 370/XP if needed. Nobody seems to care about mv78xx0
so its slowly bit-rotting in a corner.

Thanks
	Andrew
