From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Sat, 17 Nov 2012 08:28:14 +0100
Subject: pwm_backlight/general pwm issue.
In-Reply-To: <1353125259.18544.7.camel@gitbox>
References: <1353125259.18544.7.camel@gitbox>
Message-ID: <20121117072814.GA26391@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 17, 2012 at 05:07:39PM +1300, Tony Prisk wrote:
> Hi Thierry,
> 
> Looking a little feedback regarding a problem introduced with the pwm
> patch I sent converting the vt8500 pwm driver to devicetree.
> 
> One of the recommendations you made was to enable/disable the pwm clock
> in pwm_enable/pwm_disable, rather than at driver probe, to reduce power
> usage. Unfortunately, when the last pwm is disabled, the clock is
> disabled which prevents the pwm module from responding to register
> read/writes. This would be fine if pwm_enable was called before any
> other functions.
> 
> The pwm_backlight driver calls pwm_config before pwm_enable, which
> doesn't work because the pwm module has been disabled. I can appreciate
> that no one wants to enable a pwm before it's configured so I don't
> think this is particularly a driver issue.
> 
> 
> My recommendation is the re-enable the previous behaviour which was to
> enable the clock during driver probe, and disable during driver unload.
> 
> Looking for your thoughts (or anyone else that wants to chime in).

What other drivers do is explicitly make sure that the clock is enabled
before accessing registers if the hardware requires so. Does the driver
work if you change it to do so?

In the end I'll leave it up to you how you want to handle this. If the
power savings aren't an issue on vt8500 (and I suppose keeping the
peripheral clock running all the time doesn't save you *that* much) I'm
willing to take a patch that fixes things for you.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121117/1d805f17/attachment.sig>
