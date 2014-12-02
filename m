From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 2 Dec 2014 11:21:30 +0000
Subject: [PATCH 4/4] i2c: cadence: Defeature repeated start based on
 devicetree property
In-Reply-To: <1417514749-24319-5-git-send-email-harinik@xilinx.com>
References: <1417514749-24319-1-git-send-email-harinik@xilinx.com>
 <1417514749-24319-5-git-send-email-harinik@xilinx.com>
Message-ID: <20141202112130.GD23671@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 02, 2014 at 10:05:49AM +0000, Harini Katakam wrote:
> From: Vishnu Motghare <vishnum@xilinx.com>
> 
> This patch defeatures repeated start in the driver if
> "defeature-repeated-start" property is present in the devicetree.
> 
> This defeature is proposed due to a few bugs in the controller
> - completion indication is not given to the driver at the end of
> a read/receive transfer with HOLD bit set.
> - Invalid read transaction are generated on the bus when HW timeout
> condition occurs with HOLD bit set.
> 
> Signed-off-by: Vishnu Motghare <vishnum@xilinx.com>
> Signed-off-by: Harini Katakam <harinik@xilinx.com>
> ---
>  drivers/i2c/busses/i2c-cadence.c |   44 +++++++++++++++++++++++++++-----------
>  1 file changed, 31 insertions(+), 13 deletions(-)

[...]

> @@ -840,6 +856,8 @@ static int cdns_i2c_probe(struct platform_device *pdev)
>  	cdns_i2c_writereg(CDNS_I2C_CR_ACK_EN | CDNS_I2C_CR_NEA | CDNS_I2C_CR_MS,
>  			  CDNS_I2C_CR_OFFSET);
>  
> +	of_property_read_u32(pdev->dev.of_node,	"defeature-repeated-start",
> +			     &id->defeature_repeated_start);

This will not work with the binding you described. You want to treat
this as a bool, and use of_property_read_bool.

Thanks,
Mark.
