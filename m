From: baruch@tkos.co.il (Baruch Siach)
Date: Mon, 17 Oct 2011 12:39:58 +0200
Subject: [PATCH] ARM: mxs: Add initial support for Bluegiga APX4
	Development Kit
In-Reply-To: <20111017094434.GA21504@pengutronix.de>
References: <1318838916-8529-1-git-send-email-lauri.hintsala@bluegiga.com>
	<20111017094434.GA21504@pengutronix.de>
Message-ID: <20111017103958.GD7761@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe, Lauri,
On Mon, Oct 17, 2011 at 11:44:34AM +0200, Uwe Kleine-K?nig wrote:
> Hello,
> 
> On Mon, Oct 17, 2011 at 11:08:36AM +0300, Lauri Hintsala wrote:
> > Added initial support for Bluegiga APX4 module and Development Kit.
> > Patches are based on Linux v3.1-rc9.

[snip]

> > +static int __init apx4devkit_fec_get_mac(char *macstr)
> > +{
> > +	int i, h, l;
> > +
> > +	macstr++;
> > +
> > +	for (i = 0; i < 6; i++) {
> > +		if (i != 5 && *(macstr + 2) != ':')
> > +			goto error;
> > +
> > +		h = hex_to_bin(*macstr++);
> > +		if (h == -1)
> > +			goto error;
> > +
> > +		l = hex_to_bin(*macstr++);
> > +		if (l == -1)
> > +			goto error;
> > +
> > +		macstr++;
> > +		mx28_fec_pdata.mac[i] = (h << 4) + l;
> > +	}
> > +	return 0;
> I wonder if there isn't a more generic way to parse a mac address.
> 
> Other machines put the mac into the otp.
> 
> > +error:
> > +	pr_err("%s: invalid mac address\n", __func__);
> > +	return -EINVAL;
> > +}
> > +
> > +__setup("ethaddr", apx4devkit_fec_get_mac);
> the name is IMHO too generic for a board specific parameter. Think about
> a kernel that runs on all mxs based machines. ethaddr=... only affects
> your machine type. And it's not possible to add the same parameter to a
> different board.

The fec driver already supports the macaddr module parameter. See the comment 
at the beginning of the fec_get_mac() routine in drivers/net/fec.c.

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
