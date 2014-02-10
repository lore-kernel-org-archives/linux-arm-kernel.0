From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 10 Feb 2014 15:14:06 +0000
Subject: [PATCH v3 1/2] drivers/base: permit base components to omit
 the bind/unbind ops
In-Reply-To: <20140210153551.1309f017@armhf>
References: <cover.1391792986.git.moinejf@free.fr>
 <9b3c3c2c982f31b026fd1516a2b608026d55b1e9.1391792986.git.moinejf@free.fr>
 <20140210125307.GG20143@ulmo.nvidia.com>
 <20140210131233.GT26684@n2100.arm.linux.org.uk>
 <20140210153551.1309f017@armhf>
Message-ID: <20140210151406.GX26684@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 10, 2014 at 03:35:51PM +0100, Jean-Francois Moine wrote:
> On Mon, 10 Feb 2014 13:12:33 +0000
> Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> 
> > I've NAK'd these patches already - I believe they're based on a
> > mis-understanding of how this should be used.  I believe Jean-Francois
> > has only looked at the core, rather than looking at the imx-drm example
> > it was posted with in an attempt to understand it.
> > 
> > Omitting the component bind operations is absurd because it makes the
> > component code completely pointless, since there is then no way to
> > control the sequencing of driver initialisation - something which is
> > one of the primary reasons for this code existing in the first place.
> 
> I perfectly looked at your example and I use it now in my system.
> 
> You did not see what could be done with your component code. For
> example, since november, I have not yet the clock probe_defer in the
> mainline (http://www.spinics.net/lists/arm-kernel/msg306072.html), so,
> there are 3 solutions:
> 
> - hope the patch will be some day in the mainline and, today, reboot
>   when the system does not start correctly,
> 
> - insert a delay in the tda998x and kirkwood probe sequences (delay
>   long enough to be sure the si5351 is started, or loop),
> 
> - use your component work.
> 
> In the last case, it is easy:
> 
> - the si5351 driver calls component_add (with empty ops: it has no
>   interest in the bind/unbind functions) when it is fully started (i.e.
>   registered - that was the subject of my patch),

There is only one word for this:
Ewwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww.

Definitely not.

The component stuff is there to sort out the subsystems which expect a
"card" but in DT we supply a set of components.  It's not there to sort
out dependencies between different subsystems.

I've no idea why your patch to add the deferred probing hasn't been acked
by Mike yet, but that needs to happen before I take it.  Or, split it up
in two so I can take the clkdev part and Mike can take the CCF part.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
