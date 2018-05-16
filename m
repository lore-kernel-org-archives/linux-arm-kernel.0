From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 16 May 2018 15:23:27 +0100
Subject: [PATCH RFC 2/6] dt-bindings: hwmon: Add Raspberry Pi voltage
 sensor
In-Reply-To: <1526477827-10859-3-git-send-email-stefan.wahren@i2se.com>
References: <1526477827-10859-1-git-send-email-stefan.wahren@i2se.com>
 <1526477827-10859-3-git-send-email-stefan.wahren@i2se.com>
Message-ID: <30fc5bac-0c4a-b2c4-a018-ea521510aaea@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/05/18 14:37, Stefan Wahren wrote:
> Recent VC4 firmware provides a hardware-independent way to retrieve the
> under-voltage sensor on the following Raspberry Pi boards:
>    - Raspberry Pi B+ (via GPIO on SoC)
>    - Raspberry Pi A+ (via GPIO on SoC)
>    - Raspberry Pi 2 B (via GPIO on SoC)
>    - Raspberry Pi 3 B (via GPIO on port expander)
>    - Raspberry Pi 3 B+ (via PMIC)
> 
> TODO:
>    - try to make bcm2835 firmware a bus driver

Do you actually need a DT binding? From the probe routine in patch 2 it 
looks like this capability can be discovered dynamically by asking the 
firmware, therefore it might be more straightforward for the firmware 
driver itself to probe that and create a child device iff the feature is 
present, which the hwmon driver can then bind to as a pure platform driver.

Robin.

> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>   .../devicetree/bindings/hwmon/raspberrypi-hwmon.txt   | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/hwmon/raspberrypi-hwmon.txt
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/raspberrypi-hwmon.txt b/Documentation/devicetree/bindings/hwmon/raspberrypi-hwmon.txt
> new file mode 100644
> index 0000000..ec2523f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/raspberrypi-hwmon.txt
> @@ -0,0 +1,19 @@
> +Raspberry Pi voltage sensor
> +---------------------------
> +
> +The VC4 firmware exposes a mailbox interface that allows the ARM core
> +to access the board's voltage sensor.
> +
> +Required properties :
> +- compatible : Should be "raspberrypi,bcm2835-hwmon"
> +
> +Example:
> +
> +firmware: firmware-rpi {
> +	compatible = "raspberrypi,bcm2835-firmware";
> +	mboxes = <&mailbox>;
> +
> +	voltage-sensor {
> +		compatible = "raspberrypi,bcm2835-hwmon";
> +	};
> +};
> 
