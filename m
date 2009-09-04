From: broonie@sirena.org.uk (Mark Brown)
Date: Fri, 4 Sep 2009 14:41:21 +0100
Subject: Samsung S3C6410 mainline merge coordination
In-Reply-To: <1b68c6790909031808n5bb06987yfe06b3438b1d05b0@mail.gmail.com>
References: <20090902031719.GK3838@prithivi.gnumonks.org>
	<20090902100500.GA4012@sirena.org.uk>
	<20090902121158.GU32606@prithivi.gnumonks.org>
	<1b68c6790909020644k757827f4kf590779f384ceccb@mail.gmail.com>
	<20090902144700.GD4012@sirena.org.uk>
	<1b68c6790909021738o3037c9dcve6699a7b272f6742@mail.gmail.com>
	<20090903121410.GC2954@sirena.org.uk>
	<1b68c6790909030639i55b7f18dy6c2961a2830e4862@mail.gmail.com>
	<20090903151812.GE2954@sirena.org.uk>
	<1b68c6790909031808n5bb06987yfe06b3438b1d05b0@mail.gmail.com>
Message-ID: <20090904134121.GB1576@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 04, 2009 at 10:08:43AM +0900, jassi brar wrote:
> Brown<broonie@sirena.org.uk> wrote:

> > The machine driver should just pick a suitable configuration and go with
> > it. ?This isn't something which users should need to be concerned about

> I think the 'suitable' configuration is the one that the user(device
> maker) wants.

> Because i think platform designers already are pretty sure of what
> mode they wanna run the SoC-I2S in - they won't run SoC in MASTER mode
> if they have attached a good OSC to the CODEC.

Quite, this is one of the reasons why this shouldn't be exposed in
Kconfig - the choice of clock master will either not matter or will have
been fixed at hardware design time.

> Btw, what cud be the criteria of switch from SoC Master to SoC Slave
> during runtime?

Some systems with more complex audio will need to reclock the system at
runtime when moving between different use cases, often due to things
like making tradeoffs between power and quality.  This will almost
always be managed by the machine driver and certainly isn't going to be
an issue for any of the SMDKs that I've seen.

> Machine driver should runtime configure Cpu_Dai and Codec_Dai as per
> the Master/Slave and Clock sourcing options it "got from make
> menuconfig".

No, this is not something that should be offered as a configuration
option.  As I've said the machine driver should just pick a
configuration that works well on the hardware and go with that.
Presenting the configuration means that users need to understand the
various options that are being offered and come to a decision.  Since
the end result will be that either one of the options is clearly better
(in which case there is no reason to choose the other option) or there's
no difference (in which case why bother the user with the decision in
the first place) this at best achieves nothing but wasting a bit of
their time and at worst will confuse them.

If someone has modified the hardware then they will most likely want to
produce a new machine driver anyway.  If someone is interested in
evaluating the various configurations (probably with the view to
producing their own board) they can easily modify the source code.
With a Kconfig choice they're going to have to rebuild the kernel to
change configurations anyway.
