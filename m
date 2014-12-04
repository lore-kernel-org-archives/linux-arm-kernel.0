From: Andrew.Jackson@arm.com (Andrew Jackson)
Date: Thu, 04 Dec 2014 09:03:17 +0000
Subject: [PATCH 3/5] ASoC: dwc: Iterate over all channels
In-Reply-To: <20141203172928.GD7712@sirena.org.uk>
References: <547F3CA5.2010500@arm.com> <20141203172928.GD7712@sirena.org.uk>
Message-ID: <54802355.4070500@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/03/14 17:29, Mark Brown wrote:
> On Wed, Dec 03, 2014 at 04:39:01PM +0000, Andrew Jackson wrote:
> 
>> +	/* Iterate over set of channels - independently controlled.
>> +	 */
>> +	do {
>> +		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
>> +			i2s_write_reg(dev->i2s_base, TCR(ch_reg),
>> +				      xfer_resolution);
>> +			i2s_write_reg(dev->i2s_base, TFCR(ch_reg), 0x02);
>> +			irq = i2s_read_reg(dev->i2s_base, IMR(ch_reg));
>> +			i2s_write_reg(dev->i2s_base, IMR(ch_reg), irq & ~0x30);
>> +			i2s_write_reg(dev->i2s_base, TER(ch_reg), 1);
>> +		} else {
>> +			i2s_write_reg(dev->i2s_base, RCR(ch_reg),
>> +				      xfer_resolution);
>> +			i2s_write_reg(dev->i2s_base, RFCR(ch_reg), 0x07);
>> +			irq = i2s_read_reg(dev->i2s_base, IMR(ch_reg));
>> +			i2s_write_reg(dev->i2s_base, IMR(ch_reg), irq & ~0x03);
>> +			i2s_write_reg(dev->i2s_base, RER(ch_reg), 1);
>> +		}
>> +	} while (ch_reg-- > 0);
> 
> The normal way to write an iteration would be with a for loop - why are
> we not doing that?

The intention was to minimise the changes, excluding whitespace, between this version and the original.  Also, it is a perfectly valid looping construct.  I'm happy to rework it into a for loop.

> Also I see that you've not sent these as a single thread - please use
> --thread.
> 

	Andrew
