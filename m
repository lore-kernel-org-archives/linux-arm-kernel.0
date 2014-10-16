From: addy.ke@rock-chips.com (addy ke)
Date: Thu, 16 Oct 2014 17:16:02 +0800
Subject: [PATCH 1/2] spi/rockchip: fix bug that case spi can't go as fast
 as slave request
In-Reply-To: <20141015130452.GD27755@sirena.org.uk>
References: <1413372311-4203-1-git-send-email-addy.ke@rock-chips.com>
 <1413372349-4254-1-git-send-email-addy.ke@rock-chips.com>
 <20141015130452.GD27755@sirena.org.uk>
Message-ID: <543F8CD2.1010302@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi, Mark

On 2014/10/15 21:04, Mark Brown wrote:
> On Wed, Oct 15, 2014 at 07:25:49PM +0800, Addy Ke wrote:
> 
>> +	if (WARN_ON(rs->speed > MAX_SCLK_OUT))
>> +		rs->speed = MAX_SCLK_OUT;
>> +
>> +	/* the minimum divsor is 2 */
>> +	if (rs->max_freq < 2 * rs->speed) {
>> +		clk_set_rate(rs->spiclk, 2 * rs->speed);
>> +		rs->max_freq = clk_get_rate(rs->spiclk);
>> +	}
> 
> I'll apply this but you should be checking the return code from
> clk_set_rate() here, please send a followup patch doing that.  It might

If clk_set_rate return error, do I only put dev_warn here or return error value to spi core?

> also be worth consdering just setting the rate unconditionally here, it
> seems like it should make things simpler.
> 
I think we need.
If we set the rate unconditionally here, clk_set_rate() will be executed in each spi transfer.
