From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 13 Jul 2011 13:57:11 +0200
Subject: [PATCH V2 03/10] ASoc: mxs: add mxs-sgtl5000 machine driver
In-Reply-To: <1310483085-31442-4-git-send-email-b29396@freescale.com>
References: <1310483085-31442-1-git-send-email-b29396@freescale.com>
	<1310483085-31442-4-git-send-email-b29396@freescale.com>
Message-ID: <20110713115711.GG1928@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 12, 2011 at 11:04:38PM +0800, Dong Aisheng wrote:
> The driver only supports playback firstly.
> For recording, as we have to use two saif instances to implement full
> duplex (playback & recording) due to hardware limitation, we need to
> figure out a good design to fit in ASoC.
> 
> Signed-off-by: Dong Aisheng <b29396@freescale.com>

Which version of the codec do you have? I have:

[    0.370000] sgtl5000 0-000a: sgtl5000 revision 17
[    0.370000] sgtl5000 0-000a: asoc: failed to probe CODEC sgtl5000.0-000a: -22
[    0.380000] asoc: failed to instantiate card mxs_sgtl5000: -22

The failure is because CONFIG_REGULATOR is not set and it thus fails in the
codec-driver:

#else /* CONFIG_REGULATOR */
static int ldo_regulator_register(struct snd_soc_codec *codec,
				struct regulator_init_data *init_data,
				int voltage)
{
	return -EINVAL;
}

(I can patch it to load properly, but well...)

Proper regulator support for mxs is not in mainline yet. Is that
planned? How do you do it?

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110713/957bf247/attachment-0001.sig>
