From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 23 May 2013 12:01:11 -0400
Subject: [PATCH 2/2] net: mv643xx_eth: proper initialization for
 Kirkwood SoCs
In-Reply-To: <20130522201607.GA18823@obsidianresearch.com>
References: <1369154510-4927-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1369253042-15082-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1369253042-15082-2-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130522201607.GA18823@obsidianresearch.com>
Message-ID: <20130523160111.GP31290@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sebastian,

On Wed, May 22, 2013 at 02:16:07PM -0600, Jason Gunthorpe wrote:
> On Wed, May 22, 2013 at 10:04:02PM +0200, Sebastian Hesselbarth wrote:
> 
> > Ethernet controllers found on Kirkwood SoCs not only suffer from loosing
> > MAC address register contents on clock gating but also some important
> > registers are reset to values that would break ethernet. This patch
> 
> FWIW, we found that the bootloader has to write to PSC1, the driver
> doesn't work with the power on/reset value of the register. So I think
> it is safe to assume that all kirkwood bootloaders alter the value.
> 
> Our systems write the value 0x00638488 to PSC1.
> 
> I looked at patching mv643xx_eth, but ran into the same complexity you
> did, it isn't clear what variants of this IP block have the
> register/etc.
> 
> > +	/* Kirkwood resets some registers on gated clocks. Especially
> > +	 * CLK125_BYPASS_EN must be cleared but is not available on
> > +	 * all other SoCs/System Controllers using this driver.
> > +	 */
> > +	if (of_machine_is_compatible("marvell,kirkwood"))
> > +		wrlp(mp, PORT_SERIAL_CONTROL1,
> > +		     rdlp(mp, PORT_SERIAL_CONTROL1) & ~CLK125_BYPASS_EN);
> 
> of_machine_is_compatible seems heavy handed, I would expect this to be
> based on the compatible string of the ethernet node itself, not the
> machine??

Is there a model number variation between IP that needs this and IP that
doesn't?  If not, I'm fine with of_machine_is_compatible().

thx,

Jason.
