From: mark.langsdorf@calxeda.com (Mark Langsdorf)
Date: Wed, 28 Nov 2012 09:01:15 -0600
Subject: [PATCH 6/6 v6] cpufreq, highbank: add support for highbank cpufreq
In-Reply-To: <20121128151741.GC28170@S2100-06.ap.freescale.net>
References: <1351631056-25938-1-git-send-email-mark.langsdorf@calxeda.com>
 <1354046672-7392-1-git-send-email-mark.langsdorf@calxeda.com>
 <1354046672-7392-7-git-send-email-mark.langsdorf@calxeda.com>
 <20121128023240.GA28170@S2100-06.ap.freescale.net>
 <50B60E9C.9000405@calxeda.com>
 <20121128145759.GB28170@S2100-06.ap.freescale.net>
 <20121128151741.GC28170@S2100-06.ap.freescale.net>
Message-ID: <50B6273B.1000007@calxeda.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/28/2012 09:17 AM, Shawn Guo wrote:
> On Wed, Nov 28, 2012 at 10:58:02PM +0800, Shawn Guo wrote:
>> On Wed, Nov 28, 2012 at 07:16:12AM -0600, Mark Langsdorf wrote:
>>> I'd
>>> have to move most of the logic of hb_set_target() into
>>> clk_highbank.c:clk_pll_set_rate() and then add extra logic for when
>>> cpufreq is not enabled/loaded.
>>
>> You only need to move hb_voltage_change() into cpu clock's .set_rate()
>> hook with no need of checking if cpufreq is enabled or not.
>>
> Need to also check whether frequency or voltage should be changed first
> in .set_rate() though.

Yes, that's entirely what I meant when I said that I would need to move
most of the hb_set_target() logic into .set_rate(). I would also need to
account for retries if the voltage set operation fails, which it
sometimes does.

The ECME handles changing the voltage but doesn't look like a voltage
regulator. Amongst other things, by design it doesn't export meaningful
voltage information to Linux. I tried to get cpufreq-clk0 to work with
the Highbank design and it ended up being much easier and more sane to
create a separate driver.

--Mark Langsdorf
Calxeda, Inc.
