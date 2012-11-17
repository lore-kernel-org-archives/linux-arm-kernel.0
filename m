From: linux@prisktech.co.nz (Tony Prisk)
Date: Sat, 17 Nov 2012 17:07:39 +1300
Subject: pwm_backlight/general pwm issue.
Message-ID: <1353125259.18544.7.camel@gitbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thierry,

Looking a little feedback regarding a problem introduced with the pwm
patch I sent converting the vt8500 pwm driver to devicetree.

One of the recommendations you made was to enable/disable the pwm clock
in pwm_enable/pwm_disable, rather than at driver probe, to reduce power
usage. Unfortunately, when the last pwm is disabled, the clock is
disabled which prevents the pwm module from responding to register
read/writes. This would be fine if pwm_enable was called before any
other functions.

The pwm_backlight driver calls pwm_config before pwm_enable, which
doesn't work because the pwm module has been disabled. I can appreciate
that no one wants to enable a pwm before it's configured so I don't
think this is particularly a driver issue.


My recommendation is the re-enable the previous behaviour which was to
enable the clock during driver probe, and disable during driver unload.

Looking for your thoughts (or anyone else that wants to chime in).

Regards
Tony Prisk
