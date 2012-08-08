From: jarkko.nikula@bitmer.com (Jarkko Nikula)
Date: Wed, 08 Aug 2012 16:25:05 +0300
Subject: [PATCH 08/11] ARM: OMAP3: Remove callback for McBSP sidetone
 ICLK workaround
In-Reply-To: <1344417101-5015-9-git-send-email-peter.ujfalusi@ti.com>
References: <1344417101-5015-1-git-send-email-peter.ujfalusi@ti.com>
 <1344417101-5015-9-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <502268B1.9040506@bitmer.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/08/2012 12:11 PM, Peter Ujfalusi wrote:
> We can achieve the same result with SIDLEMODE field within McBSP SYSCONFIG
> register.
> The ASoC driver has been modified to use this method and we can now remove
> the workaround using the control module register.
> 
Are you sure it works without any changes to sidetone audio quality or
current consumption? What I remember idlemode was broken at least on
3430 and caused bad sidetone audio if autoidle was set and a little bit
higher current consumption (something like 2-3 mA higher where reference
consumption was around 10 mA) when McBSP was set to no-idle.

Here's the old thread:

http://www.mail-archive.com/linux-omap at vger.kernel.org/msg52024.html

I think I tested all of this by using arecord >/dev/null | aplay
/dev/zero with threshold based DMA transfers with all bells and whistles
set for dynamic retention idle in order to hear only McBSP sidetone
while measuring current consumption.

But I guess 2-3 mA higher consumption is ok if it simplifies SW a lot
and base consumption is anyway much higher than 10 mA when sidetone is
in real use (my test above was artificial where actual use is under a
phone call with heavy consumption from cellular modem etc).

-- 
Jarkko
