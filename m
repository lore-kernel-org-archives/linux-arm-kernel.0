From: horms@verge.net.au (Simon Horman)
Date: Thu, 8 Jun 2017 15:45:21 +0200
Subject: [PATCH v2] ARM: dts: armadillo800eva: Split LCD mux and gpio
In-Reply-To: <38369176.p2s9nCEmhA@avalon>
References: <1496312820-27237-1-git-send-email-geert+renesas@glider.be>
 <38369176.p2s9nCEmhA@avalon>
Message-ID: <20170608134516.GC19821@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 02, 2017 at 08:53:26AM +0300, Laurent Pinchart wrote:
> Hi Geert,
> 
> Thank you for the patch.
> 
> On Thursday 01 Jun 2017 12:27:00 Geert Uytterhoeven wrote:
> > Configuration of the lcd0 pinmux group and GPIO hog for the external
> > GPIO mux are done using a single device node, causing the "output-high"
> > property to be applied to both.  This will fail for the pinmux group,
> > but doesn't cause any harm, as the failure is ignored silently.
> > 
> > However, after "pinctrl: sh-pfc: propagate errors on group config", the
> > failure will become fatal, leading to a broken display:
> > 
> >     sh-pfc e6050000.pin-controller: pin_config_group_set op failed for group
> > 102 sh-pfc e6050000.pin-controller: Error applying setting, reverse things
> > back sh-pfc e6050000.pin-controller: failed to select default state
> > 
> > Move the GPIO hog to its own node to fix this.
> > 
> > Fixes: ffd2f9a5afb730b9 ("ARM: shmobile: armadillo800eva dts: Add pinctrl
> > and gpio-hog for lcdc0") Signed-off-by: Geert Uytterhoeven
> > <geert+renesas@glider.be>
> > ---
> > This is a hard dependency for "pinctrl: sh-pfc: propagate errors on
> > group config" (https://patchwork.kernel.org/patch/9186713/).
> > 
> > v2:
> >   - Keep the GPIO hog, but move it to its own node, instead of using
> >     another level of subnodes.  As the GPIO hog node is not referenced from
> >     a pinctrl-0 property, pinconf doesn't fail with "No pin or group
> >     provided in DT node".
> 
> I like this approach better, it allows us to drive the output instead of 
> pulling it up, without requiring a full implementation of output drive control 
> in the pfc driver.
> 
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks, I have queued this up as a fix for v4.12.
