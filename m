From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 24 Nov 2010 14:16:23 +0000
Subject: [PATCH 1/9] spi/pxa2xx: don't use subys initcall for driver init
In-Reply-To: <4CED1C95.8070300@linutronix.de>
References: <1290597207-29838-1-git-send-email-bigeasy@linutronix.de>
	<1290597207-29838-2-git-send-email-bigeasy@linutronix.de>
	<AANLkTin4vh85XRkEd7YocCmKngViR_qZDe7z1b4JXyd-@mail.gmail.com>
	<4CED1C95.8070300@linutronix.de>
Message-ID: <20101124141623.GH24970@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 24, 2010 at 03:09:25PM +0100, Sebastian Andrzej Siewior wrote:

> I've been pointed out to this commit but I don't understand _why_.
> The part I don't get is "so it can be used with cpufreq". Is it
> refered to a driver or the subsystem as it?

We need the regulators for the CPU rails to start before the cpufreq
driver starts so cpufreq can talk to them, and since the regulators may
be SPI attached this means we also need the SPI controller to start
before cpufreq.  cpufreq starts at vanilla init time.

There's an approach being looked at for handling this for devices but
for deviceless stuff like cpufreq we've nothing.
