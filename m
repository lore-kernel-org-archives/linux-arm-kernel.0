From: robh@kernel.org (Rob Herring)
Date: Fri, 20 Nov 2015 10:03:46 -0600
Subject: [PATCH] spi: dts: sun4i: Add support for inter-word wait cycles
 using the SPI Wait Clock Register
In-Reply-To: <1447948422-4915-2-git-send-email-mweseloh42@gmail.com>
References: <1447948422-4915-1-git-send-email-mweseloh42@gmail.com>
 <1447948422-4915-2-git-send-email-mweseloh42@gmail.com>
Message-ID: <20151120160346.GA21921@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 19, 2015 at 04:53:42PM +0100, Marcus Weseloh wrote:
> Adds support and documentation for a new slave device property
> "sun4i,spi-wdelay" that allows to set the SPI Wait Clock Register per
> device / transfer. The SPI hardware will wait the specified amount of
> SPI clock periods (plus a constant 3 clock periods) before transmitting
> the next word.
> 
> The constant additional 3 clock periods are not documented by the vendor
> and have been determined by analyzing the generated waveforms across
> many different transmission speeds.
> 
> Signed-off-by: Marcus Weseloh <mweseloh42@gmail.com>
> ---
>  Documentation/devicetree/bindings/spi/spi-sun4i.txt | 11 +++++++++++
>  drivers/spi/spi-sun4i.c                             |  7 +++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-sun4i.txt b/Documentation/devicetree/bindings/spi/spi-sun4i.txt
> index de827f5..9c4d723 100644
> --- a/Documentation/devicetree/bindings/spi/spi-sun4i.txt
> +++ b/Documentation/devicetree/bindings/spi/spi-sun4i.txt
> @@ -10,6 +10,10 @@ Required properties:
>    - "mod": the parent module clock
>  - clock-names: Must contain the clock names described just above
>  
> +Optional properties for slave devices:
> +- sun4i,spi-wdelay : delay between transmission of words, specified in number
> +  of SPI clock periods (actual delay is wdelay + 3 clock periods)

Seems like a common property to me. For a common one, it should be the 
actual delay and the driver needs to subtract the 3 clock periods here.

Rob
