From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 12 Dec 2016 14:32:11 +0530
Subject: [PATCH v7 1/2] provide lock-less versions of clk_{enable|disable}
In-Reply-To: <20161209185421.fybpk4bdq6b7yglf@pengutronix.de>
References: <1481302773-14181-1-git-send-email-abailon@baylibre.com>
 <20161209185421.fybpk4bdq6b7yglf@pengutronix.de>
Message-ID: <e548f7cf-a1d5-0bc2-1095-db8464a1bcc4@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On Saturday 10 December 2016 12:24 AM, Uwe Kleine-K?nig wrote:
> Hello,
> 
> On Fri, Dec 09, 2016 at 05:59:32PM +0100, Alexandre Bailon wrote:
>> Rename __clk_{enable|disble} in davinci_clk_{enable|disable}.
>> davinci_clk_{enable|disable} is a lock-less version of
>> clk_{enable|disable}.
>> This is useful to recursively enable clock without doing recursive call
>> to clk_enable(), which would cause a recursive locking issue.
>> The lock-less version could be used by example by the usb20 phy clock,
>> that need to enable the usb20 clock before to start.
> 
> I wouldn't call that lock-less. The difference is that the newly exposed
> funcion requires the caller to already hold the lock. So maybe a better

Right.

> name would be clk_enable_locked.

I am not sure the new name you propose is much clearer. Unless I am
missing an obvious naming pattern in kernel. Besides, I want to have the
"davinci_" prefix for consistency with how other mach-davinci internal
functions are named. FWIW, the equivalent function in common-clk is
called clk_core_enable().

> 
> Would it be more sensible to convert davinci to common-clk?

Yes, but there is no work going on on that and AFAIK, know one is
planning on working on it too. These patches are needed anyway since we
need to fix the existing issue on v4.10

Thanks,
Sekhar
