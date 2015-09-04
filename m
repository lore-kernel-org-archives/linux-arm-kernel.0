From: martin@sperl.org (Martin Sperl)
Date: Fri, 4 Sep 2015 14:35:52 +0200
Subject: [LINUX RFC v2 1/4] spi: add support of two chip selects & data
 stripe
In-Reply-To: <20150903121232.GW12027@sirena.org.uk>
References: <1440570367-22569-1-git-send-email-ranjit.waghmode@xilinx.com>
 <1440570367-22569-2-git-send-email-ranjit.waghmode@xilinx.com>
 <20150903121232.GW12027@sirena.org.uk>
Message-ID: <E4C1DE94-773C-498F-9CD5-639FBEEE3139@sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On 03.09.2015, at 14:12, Mark Brown <broonie@kernel.org> wrote:
> 
> On Wed, Aug 26, 2015 at 11:56:04AM +0530, Ranjit Waghmode wrote:
> 
>> To support dual parallel mode operation of ZynqMP GQSPI controller
>> following API's are added inside the core:
> 
> As covered in SubmittingPatches please try to make each patch a single
> change rather than having multiple separate changes in one commit.
> 
>> +	/* Controller may support more than one chip.
>> +	 * This flag will enable that feature.
>> +	 */
>> +#define SPI_MASTER_BOTH_CS		BIT(8)		/* enable both chips */
> 
> This isn't saying that the controller supports more than one chip, it's
> saying that the controller supports asserting more than one chip select
> at once which isn't the same thing.  I'm also not entirely sure that
> this makes sense as a separate feature to the data striping one - I'm
> struggling to think of a way to use this sensibly separately to that.

Well - there is one use-case that I can think of:
fbtft has the requirement for some devices to control a GPIO to
differentiate between command and data getting transferred
- sort of 9 bit.

Right now it is done outside of spi in the fbtft driver itself wrapping
spi_sync().

Similarly a ?hold? line on an eeprom or similar could get (de)asserted
without requiring holding a spi-bus-lock.

But then the current patch would not allow this kind of ?generic?
use-case.

Martin
