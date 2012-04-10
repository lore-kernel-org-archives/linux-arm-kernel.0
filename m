From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 10 Apr 2012 10:09:28 +0100
Subject: [PATCH] ARM: fix amba_get_enable_vcore()'s handling of probe
 deferral
In-Reply-To: <20120410084833.GA13120@glitch>
References: <20120410084833.GA13120@glitch>
Message-ID: <20120410090928.GB24465@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 10, 2012 at 10:48:33AM +0200, Domenico Andreoli wrote:
> From: Domenico Andreoli <domenico.andreoli@linux.com>

> With v3.4-rc1 my board's console started to have problems. earlyprintk
> revealed that the PL011 serial driver deferred the initialization and
> never attempted it again. This resulted in console not being bound to
> any physical device.

> The error in probing the serial was due to amba_get_enable_vcore()
> not ignoring the -EPROBE_DEFER got from regulator_get(), which has
> been recently updated to ask for probe deferral in case the regulator
> is not available (yet).

> This fix makes amba_get_enable_vcore() consistently handle the new
> -EPROBE_DEFER error case.

As discussed in the other thread where Shawn proposed the same fix this
is not a good fix (and the original code is not a good idea either), it
makes things very dependant on probe ordering which is fragile and prone
to error.  With the code as-is platforms not using this feature really
should be stubbing out the regulator rather than ignoring failures to
acquire the regulator.

Russell just applied a patch removing this feature entirely (in favour
of implementing it in power domains on platforms that want it) which
avoids these issues.
