From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 23 Jan 2014 16:53:50 +0000
Subject: [PATCH 1/2] PWM: let of_xlate handlers check args count
In-Reply-To: <20140123110444.GI16215@pengutronix.de>
References: <20140123083714.3c6e86ae@ipc1.ka-ro>
 <1390467898-9216-1-git-send-email-s.hauer@pengutronix.de>
 <1390467898-9216-2-git-send-email-s.hauer@pengutronix.de>
 <20140123115632.6d3f1a58@ipc1.ka-ro> <20140123110444.GI16215@pengutronix.de>
Message-ID: <20140123165349.GY15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 23, 2014 at 12:04:44PM +0100, Sascha Hauer wrote:
> On Thu, Jan 23, 2014 at 11:56:32AM +0100, Lothar Wa?mann wrote:
> > Hi,
> > 
> > Sascha Hauer wrote:
> > > of_pwm_n_cells for the of_xlate handler is stored in struct pwm_chip,
> > > but it is only ever used by the of_xlate handler itsel. Remove
> > > of_pwm_n_cells from struct pwm_chip and let the handler do the argument
> > > count checking to simplify the code.
> > > 
> > This still does not make the PWM_POLARITY flag in the pwms node
> > optional as was the goal because of_parse_phandle_with_args() requires
> > at least #pwm-cells arguments in the node.
> > 
> > So, with a DT configuration like:
> > pwm0: pwm at 0 {
> > 	#pwm-cells = <3>;
> > };
> > backlight {
> > 	pwms = <&pwm0 0 100000>;
> > };
> 
> We misunderstood each other. My goal was to allow the driver to also
> work with old devicetrees which specify #pwm-cells = <2>, not to allow
> inconsistent devicetrees like the snippet above.

In which case, the patch I've posted seems to do that job too... I'm
just about to test out the three-cell version.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
