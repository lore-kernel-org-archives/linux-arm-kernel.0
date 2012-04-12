From: rnayak@ti.com (Rajendra Nayak)
Date: Thu, 12 Apr 2012 18:35:08 +0530
Subject: [PATCH v2 2/2] ARM: omap: hwmod: Make omap_hwmod_softreset wait
 for reset status
In-Reply-To: <alpine.DEB.2.00.1204111251100.29473@utopia.booyaka.com>
References: <1331659524-7635-1-git-send-email-rnayak@ti.com>
 <1331659524-7635-3-git-send-email-rnayak@ti.com>
 <alpine.DEB.2.00.1204101803020.20894@utopia.booyaka.com>
 <4F8565C7.4080506@ti.com>
 <alpine.DEB.2.00.1204111251100.29473@utopia.booyaka.com>
Message-ID: <4F86D304.1020902@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On Thursday 12 April 2012 12:29 AM, Paul Walmsley wrote:
> That approach sounds fine to me, but I don't think Fernando's patch will
> help with I2C..  Since it uses a custom reset function omap_i2c_reset(),
> the delay will actually need to go there.

While working on fixing this I stumbled upon a couple of other
things which don't seem right.

The i2c custom reset funtion (omap_i2c_reset) uses a hwmod exposed
api to set the SOFTRESET bit, however it then accesses the hwmod
internal structure to poll on RESETDONE status bit. Should there be
another function exposed to poll on RESETDONE too?

_reset() function documents its return value to be -ETIMEDOUT, if the
module fails to reset in time, and hence expects the custom reset
function to return the same in such cases. The omap_i2c_reset() function
seems to return 0 even in cases of timeout. However looking more closely
the return value from _reset() does not seem to be used in the framework
today.

The comment in _ocp_softreset() suggests the intent was to add a new
state to the hwmod state machine.

         /*
          * XXX add _HWMOD_STATE_WEDGED for modules that don't come back 
from
          * _wait_target_ready() or _reset()
          */

is it still the case, or should _reset() just return a void?

regards,
Rajendra
