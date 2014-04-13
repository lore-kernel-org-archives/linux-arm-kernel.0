From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Sat, 12 Apr 2014 18:25:57 -0700
Subject: [PATCH] Route keyboard LEDs through the generic LEDs layer.
In-Reply-To: <20140411061202.GA8321@type>
References: <20140331122323.GC6044@type.bordeaux.inria.fr>
 <20140407021015.GA8518@core.coreip.homeip.net>
 <20140407075423.GZ7179@type.wlan.youpi.perso.aquilenet.fr>
 <20140408083940.GA22855@core.coreip.homeip.net>
 <20140408233306.GJ27820@type.youpi.perso.aquilenet.fr>
 <20140411061202.GA8321@type>
Message-ID: <20140413012557.GA28990@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 11, 2014 at 08:12:02AM +0200, Samuel Thibault wrote:
> Hello,
> 
> I'm sorry this went out with a few mistakes.
> 
> Samuel Thibault, le Wed 09 Apr 2014 01:33:06 +0200, a ?crit :
> > Dmitry Torokhov, le Tue 08 Apr 2014 01:39:40 -0700, a ?crit :
> > > It is not about the VT, I am talking about pure input core. If I
> > > repurpose CapsLock LED for my WiFi indicator I do not want to go into
> > > other programs and teach them that they should stay away from trying to
> > > control this LED.
> > 
> > Err, but even without talking about repurposing Capslock LED for WiFi...
> > How is managed the conflict between the normal capslock behavior and
> > other programs' action on the underlying input device?  I don't think
> > this patch does not introduce the problem.
> 
> I of course meant "I don't think this patch introduces the problem".

The difference in my eyes is that with old interface both players knew
that they would be affecting (and potentially interfering) with the
state of CapsLock LED. With your proposed changes users of old
interfaces have no idea if they are actually toggling CapsLock LED or if
they are affecting something that is no longer a CapsLock LED.

> 
> > How to decide which one to prioritize?
> > 
> > Is it just because console-setup happens to repurpose the capslock LED
> > key that applications should suddenly not have capslock LED control
> > at all?  That's contradictory with the use case you have given.
> 
> Oops, not the use case you have given, but a typical use-case of wanting
> to use a program which does nice things with the capslock LED, and then
> having to teach console-setup not to repurpose the capslock LED.

I believe that applications should be able to control sate of CapsLock
and other LEDs and that the affected LED should not be the physical LED
but rather LED that is currently tied to CapsLock trigger (if any). This
way everything works as is by default and if I decide to have my
physical CapsLock LED to be repurposed for Wifi or HDD activity or
whatever I do not need to teach unrelated applications to stop touching
it.

> 
> > That
> > leads me into believing that we should not try to push a hard rule, and
> > just let the user manage what accesses it.  We could indeed make the VT
> > always take priority, but then that would probably break some existing
> > applications.
> 
> Such as the example above, with the capslock LED.

I am not saying that VT shoudl have priority, I am saying we need to
come up with implementation that does not result in inconsistent
behavior.

Thanks.

-- 
Dmitry
