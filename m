From: samuel@sholland.org (Samuel Holland)
Date: Wed, 28 Feb 2018 11:19:11 -0600
Subject: [PATCH 3/3] mailbox: sunxi-msgbox: Add a new mailbox driver
In-Reply-To: <20180228083214.h4oi2kmjjqmoyfhn@flea>
References: <20180228022714.30068-1-samuel@sholland.org>
 <20180228022714.30068-4-samuel@sholland.org>
 <20180228083214.h4oi2kmjjqmoyfhn@flea>
Message-ID: <fdf86770-6f45-3b3c-50ea-7a8363894639@sholland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 02/28/18 02:32, Maxime Ripard wrote:
> On Tue, Feb 27, 2018 at 08:27:14PM -0600, Samuel Holland wrote:
>> +	/*
>> +	 * The failure path should not disable the clock or assert the reset,
>> +	 * because the PSCI implementation in firmware relies on this device
>> +	 * being functional. Claiming the clock in this driver is required to
>> +	 * prevent Linux from turning it off.
>> +	 */
>> +	ret = clk_prepare_enable(clk);
>> +	if (ret) {
>> +		dev_err(dev, "Failed to enable bus clock: %d\n", ret);
>> +		return ret;
>> +	}
> 
> You don't need it to be always on though. You only need it to be
> enabled when you access the registers (on both sides I guess?). So you
> could very well enable the clock in your registers accessors in Linux,
> and do the same in the ARISC firmware. That should work.

It does need to always be on because the *PSCI* implementation (ATF) also uses
SCPI concurrently with Linux (on a separate channel). Turning off the clock
anywhere in Linux could turn it off in the middle of a PSCI SCPI call on a
different CPU, causing ATF to hang in EL3 (which would be very bad).

> Maxime

Regards,
Samuel
