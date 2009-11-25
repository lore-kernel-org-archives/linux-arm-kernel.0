From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 25 Nov 2009 08:46:31 +0100
Subject: [alsa-devel] [PATCH 03/12] add a mc13783 codec driver
In-Reply-To: <20091119193008.GC2814@sirena.org.uk>
References: <1258645706-9071-1-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-2-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-3-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-4-git-send-email-s.hauer@pengutronix.de>
	<20091119193008.GC2814@sirena.org.uk>
Message-ID: <20091125074631.GB27548@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

> > +static int mc13783_set_tdm_slot_codec(struct snd_soc_dai *dai,
> > +	unsigned int tx_mask, unsigned int rx_mask, int slots, int slot_width)
> > +{
> > +	struct snd_soc_codec *codec = dai->codec;
> > +	unsigned int reg;
> > +
> > +	if (slots != 4)
> > +		return -EINVAL;
> > +
> > +	reg = mc13783_read(codec, PMIC_SSI_NETWORK);
> > +
> > +	reg &= ~(0xfff << 0);
> > +	reg |= (0x00 << 2);	/* primary timeslot RX/TX(?) is 0 */
> > +	reg |= (0x01 << 4);	/* secondary timeslot TX is 1 */
> > +	reg |= (0x01 << 6);	/* secondary timeslot RX is 1 */
> 
> This appears to be pretty much ignoring the supplied arguments and using
> a fixed configuration?
> 

The problem here is that I don't really understand what arguments I
should supply to this function and how to parse them to archieve what I
want.

The MC13783 Voice Codec always uses a network mode to send data. It has
a fixed width of four slots.

PMIC_SSI_NETWORK[2:3] defines the slot for primary transmit/receive
PMIC_SSI_NETWORK[4:5] defines the secondary transmit timeslot
PMIC_SSI_NETWORK[6:7] defines the secondary receive timeslot

The Codec has two channels and it's not primarily desgined to do stereo
Audio. I want to put the primary channel into the first timeslot and
the secondary channel into the second timeslot.

Any idea how to do this correctly?

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
