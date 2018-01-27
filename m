From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sat, 27 Jan 2018 21:43:50 +0100
Subject: [PATCH] ARM: dts: imx25-pinfunc: Always set SION for SD CMD
In-Reply-To: <CA+sos78H1_ihvVghJcpZQZmB6rE2nfgXF8gq8kqK=cQE9Qs0mw@mail.gmail.com>
References: <20180127000752.2879-1-benoit.thebaudeau.dev@gmail.com>
 <20180127153733.7ziaq6frli3jemc7@pengutronix.de>
 <CA+sos78H1_ihvVghJcpZQZmB6rE2nfgXF8gq8kqK=cQE9Qs0mw@mail.gmail.com>
Message-ID: <20180127204350.3xswhyvvae6w4w2c@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 27, 2018 at 09:37:11PM +0100, Beno?t Th?baudeau wrote:
> On Sat, Jan 27, 2018 at 4:37 PM, Uwe Kleine-K?nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > On Sat, Jan 27, 2018 at 01:07:52AM +0100, Beno?t Th?baudeau wrote:
> >> The eSDHC does not work properly if the SION bit is not set for the
> >> bidirectional CMD signal, whatever the eSDHC instance and the selected
> >> pad. Therefore, setting SION is mandatory for all eSDHC CMD ports. Do
> >> this for MX25_PAD_*__SD*_CMD in imx25-pinfunc.h in order to enforce this
> >> behavior for all boards.
> >>
> >> This had already been done for eSDHC1, but not for eSDHC2. Also, define
> >> MX25_PAD_FEC_MDC__SDHC2_CMD so that all the possible cases are covered
> >> from now on.
> >
> > There is an inconsistency in the naming. The eSDHC1 CMD constants are
> > named:
> >
> >         MX25_PAD_SD1_CMD__SD1_CMD
> >
> > The reference calls this:
> >
> >         CMD of instance: esdhc1.
> >
> > The register name is correct though. Not sure it's worth to fix this to
> > use consistent naming (which would result in:
> >
> >         MX25_PAD_SD1_CMD__ESDHC1_CMD
> >
> > which looks ugly, too).
> 
> Indeed. I had also noticed this. I can send a patch to apply before
> this one. But that would break the out-of-tree DT files using these
> definitions. Would that be OK?

One possibility is to do something like this:

	#define MX25_PAD_SD1_CMD__ESDHC1_CMD	X Y Z ...

	...

	/*
	 * compat defines for out-of-tree users. Yes, you should update when you
	 * make use of one of them.
	 */
	#define MX25_PAD_SD1_CMD__SD1_CMD MX25_PAD_SD1_CMD__ESDHC1_CMD

This would also allow to fix the users in a separate step.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
