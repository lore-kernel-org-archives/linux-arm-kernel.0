From: computersforpeace@gmail.com (Brian Norris)
Date: Fri, 23 Aug 2013 04:46:52 -0700
Subject: [PATCH V1 3/5] mtd: m25p80: add the quad-read support
In-Reply-To: <20130823094141.GE25263@sirena.org.uk>
References: <1376885403-12156-1-git-send-email-b32955@freescale.com>
 <201308222229.01778.marex@denx.de> <20130822233611.GA25263@sirena.org.uk>
 <201308230158.05909.marex@denx.de> <20130823094141.GE25263@sirena.org.uk>
Message-ID: <52174BAC.3070901@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/23/2013 02:41 AM, Mark Brown wrote:
> On Fri, Aug 23, 2013 at 01:58:05AM +0200, Marek Vasut wrote:
>>> I was actually thinking something more generic than that - putting the
>>> property at the SPI generic bindings level.  Though if all flashes with
>>> this dual/quad read functionality have the prefix m25p the above would
>>> work also, at the minute this does seem to be mostly used by flash (I
>>> bet someone's got some DSPs or something though).
> 
>> Ah! So you mean the SPI controller would provide information that it can do
>> dual/quad transfers? But then, the additional pins can only be wired to certain
>> chips (controller by certain CS lines).
> 
> No, not exactly - I just meant that the property on the child node
> should be one that's consistent over all chips and could hopefully be
> implemented in the SPI core as part of instantiating the device in DT.
> Which probably just means stripping or changing the vendor prefix.

(Now that I've been pointed to the support merged into the SPI tree...)

Aren't the following new DT properties (for the SPI slave) sufficient?

spi-rx-nbits
spi-tx-nbits

We can leave the detection of which flash chips support which modes to 
software (m25p80.c) where it belongs, IMO.

They're already in the following commit:

commit f477b7fb13df2b843997559ff34e87d054ba6538
Author: wangyuhang <wangyuhang2014@gmail.com>
Date:   Sun Aug 11 18:15:17 2013 +0800

    spi: DUAL and QUAD support
    
    fix the previous patch some mistake below:
    1. DT in slave node, use "spi-tx-nbits = <1/2/4>" in place of using
       "spi-tx-dual, spi-tx-quad" directly, same to rx. So correct the
       previous way to get the property in @of_register_spi_devices().
    2. Change the value of transfer bit macro(SPI_NBITS_SINGLE, SPI_NBITS_DUAL
       SPI_NBITS_QUAD) to 0x01, 0x02 and 0x04 to match the actual wires.
    3. Add the following check
       (1)keep the tx_nbits and rx_nbits in spi_transfer is not beyond the
          single, dual and quad.
       (2)keep tx_nbits and rx_nbits are contained by @spi_device->mode
          example: if @spi_device->mode = DUAL, then tx/rx_nbits can not be set
                   to QUAD(SPI_NBITS_QUAD)
       (3)if "@spi_device->mode & SPI_3WIRE", then tx/rx_nbits should be in
          single(SPI_NBITS_SINGLE)
    
    Signed-off-by: wangyuhang <wangyuhang2014@gmail.com>
    Signed-off-by: Mark Brown <broonie@linaro.org>

Brian
