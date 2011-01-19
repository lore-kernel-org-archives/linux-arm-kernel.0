From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 19 Jan 2011 20:48:50 +0000
Subject: [PATCH v2 0/8] Switch ARM platforms from integrator-flash to
	physmap
In-Reply-To: <1295462700.5742.76.camel@e102391-lin.cambridge.arm.com>
References: <1294409399-19245-1-git-send-email-marc.zyngier@arm.com>
	<20110119145425.GF31652@n2100.arm.linux.org.uk>
	<1295462700.5742.76.camel@e102391-lin.cambridge.arm.com>
Message-ID: <20110119204850.GB6335@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 19, 2011 at 06:45:00PM +0000, Marc Zyngier wrote:
> On Wed, 2011-01-19 at 14:54 +0000, Russell King - ARM Linux wrote:
> > On Fri, Jan 07, 2011 at 02:09:51PM +0000, Marc Zyngier wrote:
> > > As the integrator-flash driver is mostly a duplicate of physmap,
> > > move all users of this driver to physmap and get rid of the
> > > then unused driver.
> > 
> > Does MTD guarantee that the vpp will be turned off whenever the physmap
> > module is removed?  If not, can it?
> 
> Vpp seems to be controlled directly from the chip drivers (using the
> {ENABLE,DISABLE}_VPP macros and a command-set specific state machine),
> and none of the map drivers play with vpp at all, integrator-flash
> included.
> 
> By the look of it, it seems pretty safe, though your own experience
> seems to indicate otherwise. It should be quite easy to plug the vpp off
> feature in physmap. I'll give it a go and re-spin the patchset.

No - we need VPP enabled to write to the flash.  I'm talking about module
removal.  integrator-flash calls back on removal and insertion, where
VPP is controlled at platform level to make sure VPP is turned off.

Also there's the matter of the write enable on Integrator platforms.
That's not the same as VPP - it prevents any write to the flash devices,
even for ID probing.  MTD keeps VPP off during such operations.

So, unless physmap is extended with these callbacks, it can't be used
for Integrator.  So there's no point converting the other platforms.
