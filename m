From: khilman@ti.com (Kevin Hilman)
Date: Wed, 11 Apr 2012 15:46:20 -0700
Subject: [PATCH 05/12] arm: omap3: am35x: Add PWROFF feature
In-Reply-To: <1334171147-7517-6-git-send-email-mgreer@animalcreek.com> (Mark
 A. Greer's message of "Wed, 11 Apr 2012 12:05:40 -0700")
References: <1334171147-7517-1-git-send-email-mgreer@animalcreek.com>
 <1334171147-7517-6-git-send-email-mgreer@animalcreek.com>
Message-ID: <87iph5q43n.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

"Mark A. Greer" <mgreer@animalcreek.com> writes:

> From: "Mark A. Greer" <mgreer@animalcreek.com>
>
> Typical OMAP3 SoCs have four power domain states: ON,
> INACTIVE, RETENTION, and OFF.  The am35x family of SoCs
> has only two states: ON and INACTIVE.  To distinguish which
> set of states the current device has, add the 'OMAP3_HAS_PWROFF'
> feature.  When that feature/bit is set, the device supports the
> RETENTION and OFF states; otherwise, it doesn't.
>
> Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>

Paul has mentioned this already, but the same applies here: We shouldn't
be using SoC-global feature flag for this.   We already have per-pwrdm
flags that indicate what states a given powerdomain suports (see .pwrsts
field.)

Wherever we have blind writes to next powerstates that assume support
for RET/OFF is present, those should probably use a helper function from
the powerdomain code that checks if that state is even supported.

Jean's work on functional powerstates will probably help here if you
really need to support INACTIVE.  However, Paul may be right in that you
might just start with supporing ON only, and validate that module-level
wakups acutally work.

Kevin
