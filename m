From: bgriffis@ti.com (Griffis, Brad)
Date: Mon, 27 Oct 2014 19:02:47 +0000
Subject: [PATCH 0/4] Touchscreen performance related fixes
In-Reply-To: <544E821D.5040004@linutronix.de>
References: <1414408111-2631-1-git-send-email-vigneshr@ti.com>
 <544E821D.5040004@linutronix.de>
Message-ID: <912A29987EAE174BA6CF187D7CDFA9CE26F46B2B@DLEE08.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/27/2014 12:34 PM, Sebastian Andrzej Siewior wrote:
> Do we really need #3 (and then #4)? Given the complexity we have already, is there any benefit by decreasing this value? 

I specifically requested we add ti,charge-delay to the device tree because it is THE critical value to tune for a given design.  Although I think the current value of 0xB000 will be suitable for a great many designs, I expect that many users will need to adjust this value for their hardware.  Details such as which touchscreen vendor is being used and how the touchscreen is connected (header vs cable) have an effect on what's appropriate here.

> Would  someone want to increase it? Can we safely determine a value which works for everyone?

This value represents a hardware delay before checking for the pen-up event.  So in the scenario where someone is seeing excessive false pen-up events they will want to increase this parameter.  The downsize of making this larger is that it decreases the overall sampling speed of both the touchscreen as well as the standalone ADC samples.  At one point I tried making it huge, but that made the touchscreen overly sluggish because the sampling became too slow.  So there is a definite trade-off that if you make it too large the touchscreen becomes sluggish, and if you make it too small then you may see false pen-up events.  The optimal value will need to be tuned for a given design.
