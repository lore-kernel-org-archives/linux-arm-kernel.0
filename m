From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 9 Oct 2012 09:11:11 +0200
Subject: [alsa-devel] [PATCH v2 1/2] ARM: imx: clk: Split SSI clock into
 'ipg' and 'per'
In-Reply-To: <CAOMZO5Beug=Db4_dW9ziNs-M=wUizrRSrDXMAXi0CXpUO1Nvzw@mail.gmail.com>
References: <1349725213-11354-1-git-send-email-fabio.estevam@freescale.com>
 <20121008214452.GA27665@pengutronix.de>
 <CAOMZO5ACVeMwGcjSXcEqyHMc9G3KgyrL-uC=wvjmf1AQOAhgWQ@mail.gmail.com>
 <CAOMZO5Beug=Db4_dW9ziNs-M=wUizrRSrDXMAXi0CXpUO1Nvzw@mail.gmail.com>
Message-ID: <20121009071111.GC27665@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 09, 2012 at 01:21:10AM -0300, Fabio Estevam wrote:
> Sascha,
> 
> On Mon, Oct 8, 2012 at 8:47 PM, Fabio Estevam <festevam@gmail.com> wrote:
> > Hi Sascha,
> >
> > On Mon, Oct 8, 2012 at 6:44 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> >
> >> I am not sure it's good to work around that issue in the ssi driver. We
> >> could also just enable the clock in the clk driver as it seems to be a
> >> ccm related issue.
> >
> > Yes, it would be better if we could fix this in clk-imx27 instead, but
> > I was not able to provide such fix yet.
> 
> The ssi1_sel clock is defined as:
> 
> clk[ssi1_sel] = imx_clk_mux("ssi1_sel", CCM_CSCR, 22, 1, ssi_sel_clks,
> ARRAY_SIZE(ssi_sel_clks));
> 
> ,where ssi_sel_clks is:
> static const char *ssi_sel_clks[] = { "spll", "mpll", }
> 
> ,which matches with the mx27 reference manual.
> 
> How do we tell the clk api to select spll or mpll as the source for ssi_sel?
> 
> I understand how to do this from register level, but not from the api.

In the clk driver you can do a clk_set_parent(clk[ssi1_sel], clk[mpll]);

I wonder what the parent setting has to do with this problem. Could you
come up with a minimum patch to clk-imx27.c which fixes the problem?
Then we can discuss afterwards how to integrate it properly (or not the
least dirty).

Right now the clk framework has been succesful in turning the clk mess
into a proper tree. There currently is no API to manipulate that tree
in a non painful way. That would be the next steps.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
