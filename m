From: jagan@amarulasolutions.com (Jagan Teki)
Date: Mon, 29 Oct 2018 20:38:14 +0530
Subject: [PATCH v2 12/15] clk: sunxi-ng: a64: Add min and max rate for
 PLL_MIPI
In-Reply-To: <20181029090856.yyjnvaruyasgnzyz@flea>
References: <20181023155035.9101-1-jagan@amarulasolutions.com>
 <20181023155035.9101-13-jagan@amarulasolutions.com>
 <20181024181334.lul7ta7ijluwfb7v@flea>
 <CAMty3ZBJcH1fz5FyhT1rk9qiJ-aWoQYiH7P1ZyQPLKmVWOCkdA@mail.gmail.com>
 <20181029090856.yyjnvaruyasgnzyz@flea>
Message-ID: <CAMty3ZBcTsoJsCZa=sM9vjWgHjCjEjY2cDordTQcNySQpzyR=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 29, 2018 at 2:39 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Thu, Oct 25, 2018 at 09:21:31PM +0530, Jagan Teki wrote:
> > On Wed, Oct 24, 2018 at 11:43 PM Maxime Ripard
> > <maxime.ripard@bootlin.com> wrote:
> > >
> > > On Tue, Oct 23, 2018 at 09:20:32PM +0530, Jagan Teki wrote:
> > > > A64 manual say PLL_MIPI rates are 500MHz to 1.4GHz, but
> > > > using minimum 500MHz can't release the clock and which
> > > > is not working.
> > > >
> > > > So use working minimum rate as 300MHz which is tested on
> > > > Bananapi DSI panel.
> > >
> > > I'm not quite sure what you mean by that. What do you mean by "500MHz
> > > can't release the clock"? Why would 300MHz work better then? Should be
> > > avoid reaching 500MHz if it's a frequency in the valid range?
> >
> > PLL_MIPI can't be work with existing nkm where rate set to 270MHz
> > (from PLL_VIDEO)
> > /*** round rate call in ccu_nkm.c */
> > [    2.408356] round: rate = 118800000
> > [    2.408359] round: parent_rate = 158740688
> > [    2.408417] round: rate = 148500000
> > [    2.408420] round: parent_rate = 158740688
> > [    2.408439] round: rate = 178200000
> > [    2.408441] round: parent_rate = 158740688
> > [    2.408460] round: rate = 205615384
> > [    2.408462] round: parent_rate = 158740688
> > [    2.408481] round: rate = 237600000
> > [    2.408483] round: parent_rate = 158740688
> > [    2.408502] round: rate = 270000000
> > [    2.408504] round: parent_rate = 158740688
> > [    2.408523] round: rate = 118800000
> > [    2.408525] round: parent_rate = 158740560
> > [    2.408544] round: rate = 148500000
> > [    2.408546] round: parent_rate = 158740560
> > [    2.408565] round: rate = 178200000
> > [    2.408567] round: parent_rate = 158740560
> > [    2.408586] round: rate = 205615384
> > [    2.408588] round: parent_rate = 158740560
> > [    2.408607] round: rate = 237600000
> > [    2.408609] round: parent_rate = 158740560
> > [    2.408627] round: rate = 270000000
> > [    2.408630] round: parent_rate = 158740560
> > [    2.408648] round: rate = 270000000
> > [    2.408651] round: parent_rate = 158740640
> > [    2.408670] round: rate = 270000000
> > [    2.408672] round: parent_rate = 158740704
> >
> > /** set rate call in ccu_nkm **/
> > [    2.408685] set: rate = 270000000
> > [    2.408688] set: parent_rate = 297000000
> >
> > By using min and max rate as per A64 manual page 94 range of PLL can
> > be 500MHz~1.4GHz getting 1,2,1 nkm dividers which can't be work.
> > [    2.423589] sun4i_dclk_round_rate: min_div = 4 max_div = 127, rate = 55000000
> > [    2.423643] ideal = 220000000, rounded = 0
> > [    2.423647] ideal = 275000000, rounded = 0
> > [    2.423651] ideal = 330000000, rounded = 0
> > [    2.423692] ideal = 385000000, rounded = 384000000
> > [    2.423732] ideal = 440000000, rounded = 440000000
> > [    2.423736] sun4i_dclk_round_rate: div = 8 rate = 55000000
> > [    2.423740] sun4i_dclk_round_rate: min_div = 4 max_div = 127, rate = 55000000
> > [    2.423744] ideal = 220000000, rounded = 0
> > [    2.423748] ideal = 275000000, rounded = 0
> > [    2.423751] ideal = 330000000, rounded = 0
> > [    2.423791] ideal = 385000000, rounded = 384000000
> > [    2.423831] ideal = 440000000, rounded = 440000000
> > [    2.423834] sun4i_dclk_round_rate: div = 8 rate = 55000000
> > [    2.423957] sun4i_dclk_recalc_rate: val = 1, rate = 440000000
> > [    2.423961] sun4i_dclk_recalc_rate: val = 1, rate = 440000000
> > [    2.424378] ccu_nkm_set_rate: rate = 440000000, parent_rate = 220000000
> > [    2.424381] ccu_nkm_set_rate: _nkm.n = 1
> > [    2.424383] ccu_nkm_set_rate: _nkm.k = 2
> > [    2.424385] ccu_nkm_set_rate: _nkm.m = 1
> > [    2.424725] sun4i_dclk_set_rate div 8
> > [    2.424732] sun4i_dclk_recalc_rate: val = 8, rate = 55000000
> > [    2.561271] usb 3-1: new high-speed USB device number 2 using ehci-platform
> > [    2.718486] hub 3-1:1.0: USB hub found
> > [    2.718606] hub 3-1:1.0: 4 ports detected
> > [    3.437263] ------------[ cut here ]------------
> > [    3.437270] [CRTC:36:crtc-0] vblank wait timed out
> >
> > So, lowering the min rate by 300MHz seems working with bounded nkm
> > dividers 5, 2, 9. Tested on two different panels.
> >
> > [    2.415773] [drm] No driver support for vblank timestamp query.
> > [    2.424116] sun4i_dclk_round_rate: min_div = 4 max_div = 127, rate = 55000000
> > [    2.424172] ideal = 220000000, rounded = 0
> > [    2.424176] ideal = 275000000, rounded = 0
> > [    2.424194] ccu_nkm_round_rate: rate = 330000000
> > [    2.424197] ideal = 330000000, rounded = 330000000
> > [    2.424201] sun4i_dclk_round_rate: div = 6 rate = 55000000
> > [    2.424205] sun4i_dclk_round_rate: min_div = 4 max_div = 127, rate = 55000000
> > [    2.424209] ideal = 220000000, rounded = 0
> > [    2.424213] ideal = 275000000, rounded = 0
> > [    2.424230] ccu_nkm_round_rate: rate = 330000000
> > [    2.424233] ideal = 330000000, rounded = 330000000
> > [    2.424236] sun4i_dclk_round_rate: div = 6 rate = 55000000
> > [    2.424253] ccu_nkm_round_rate: rate = 330000000
> > [    2.424270] ccu_nkm_round_rate: rate = 330000000
> > [    2.424278] sun4i_dclk_recalc_rate: val = 1, rate = 330000000
> > [    2.424281] sun4i_dclk_recalc_rate: val = 1, rate = 330000000
> > [    2.424306] ccu_nkm_set_rate: rate = 330000000, parent_rate = 297000000
> > [    2.424309] ccu_nkm_set_rate: _nkm.n = 5
> > [    2.424311] ccu_nkm_set_rate: _nkm.k = 2
> > [    2.424313] ccu_nkm_set_rate: _nkm.m = 9
> > [    2.424661] sun4i_dclk_set_rate div 6
> > [    2.424668] sun4i_dclk_recalc_rate: val = 6, rate = 55000000
> >
> > Note: BPI-M64-bsp is setting the rate directly to 180MHz with 297MHz
> > parent with resulting dividers as 1, 2, 5. ans we can't produce this
> > 180MHz rate with dclk_round_rate and ccu_nkm.
>
> I'm still not quite sure what you mean by "500MHz can't release the
> clock".
>
> From what you're saying, this seems to be related to the boundaries of
> the dividers rather than the rate itself.

Yes, with 500MHz rate the boundaries of the dividers never release
hence it hangs during set_rate and finally after sometime it trigger
vblank timeout. can't release here means the same, may be I would
confused, sorry for that.
