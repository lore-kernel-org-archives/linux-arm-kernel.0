From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 5 Feb 2013 14:37:10 -0500
Subject: [GIT PULL] ARM: mvebu fixes for v3.8-rc6 (round 2)
In-Reply-To: <20130205185758.GB21776@quad.lixom.net>
References: <1360013837.bfC5F0.15090@triton>
 <20130205140353.GT14746@titan.lakedaemon.net>
 <20130205185758.GB21776@quad.lixom.net>
Message-ID: <20130205193710.GA14746@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 05, 2013 at 10:57:58AM -0800, Olof Johansson wrote:
> On Tue, Feb 05, 2013 at 09:03:53AM -0500, Jason Cooper wrote:
> > Olof, Arnd, Russell,
> > 
> > On Mon, Feb 04, 2013 at 09:37:17PM +0000, Jason Cooper wrote:
> > > The following changes since commit de27686b77f1c5c5dddf06d48fd322c52f098d51:
> > > 
> > >   arm: mvebu: i2c come back in defconfig
> > > 
> > > are available in the git repository at:
> > > 
> > >   git://git.infradead.org/users/jcooper/linux.git tags/mvebu_fixes_for_v3.8-rc6-round2
> > > 
> > > for you to fetch changes up to b3fa2a0a2e3ac23415efec7ae848efd918b6b444:
> > > 
> > >   rtc: rtc-mv: Add support for clk to avoid lockups
> > > 
> > > ----------------------------------------------------------------
> > > mvebu fixes for v3.8-rc6 (round 2)
> > >     
> > >     This series of four patches started with Simon Baatz reporting lost MAC
> > >     addresses when compiling mv643xx_eth as a module.  Accompanying that, he was
> > >     getting hard lockups on boot when most other drivers were compiled as modules.
> > >     
> > >     All of this boiled down to gated clocks.  mv643xx_eth looses it's mac address
> > >     after it's clock gets gated.  The patch included in this series prevents the
> > >     ge0 and ge1 clocks from being gated when doing legacy platform init of the
> > >     driver.
> > >     
> > >     There is another patch to accompany the DT conversion of the driver which will
> > >     allow reading the mac address from the devicetree.  This patch is not included
> > >     here because the bindings are being added for v3.9.
> > >     
> > >     The hard lockups at boot were the result of many SoC IPs using the runit gate
> > >     clock.  Several drivers (gpio, rtc) were not claiming the clock, and of_serial
> > >     wouldn't claim the clock if clock-frequency was specified in the DT.
> > >     
> > >     clock-frequency was only necessary before we added proper clock support, it is
> > >     now removed from all kirkwood dts files.
> > >     
> > >     Last, proper clock support is added to gpio-mvebu and rtc-mv.
> > >     
> > >     With these four fixes all drivers that can be compiled as modules can be
> > >     without breaking bootup.
> > > ----------------------------------------------------------------
> > 
> > In light of Russell's recent comment (re i.MX fixes) on Linus' standard
> > for -rc7, I'd like to clarify the above.
> > 
> > While only one user reported the above problems (Simon Baatz), it was
> > caused by compiling v3.8-rc5 with the debian kernel config.  This config
> > builds almost everything it can as a module.
> 
> Is debian planning on shipping 3.8 on these platforms, or is it just one user
> that tried to build it for his own use?

To the best of my knowledge, it's the latter.  So I will hold off on
these for after v3.8 drops and CC stable.

I'd like to think more people doing embedded debian are rolling their
own kernels, but I don't think that is the case, unfortunately.

> > I'd like to do a v2 of this pull request since it was pointed out to me
> > this morning that I missed a clock-frequency in
> > kirkwood-ns2-common.dtsi.
> > 
> > Does the above meet the metric Linus has set for -rc7?  I think so, but
> > I leave that up to you guys.
> > 
> > If so, I'll redo these four patches to explicitly say they fix boot
> > problems caused when using debians default kernel config.
> 
> It depends on the above question. If Debian needs this for their actual,
> real, userbase (assuming they have one on kirkwood), then it's warranted
> to go in.
> 
> But the fixes need to be rebased on -rc6 because I am not going to send
> in some of the previous ones I had already queued but not sent in yet.

I'll rebase against v3.8 or newer when I resend.

thx,

Jason.
