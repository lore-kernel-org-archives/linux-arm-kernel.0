From: robherring2@gmail.com (Rob Herring)
Date: Fri, 10 Jul 2015 14:04:29 -0500
Subject: [PATCH v7 4/9] nvmem: Add bindings for simple nvmem framework
In-Reply-To: <1436521513-10838-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1436521427-10568-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1436521513-10838-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <CAL_JsqKYT-+T=D=TKCb1TcydOvBTE8_yc-EEe1cwdmhr1B0dHQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 10, 2015 at 4:45 AM, Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
> This patch adds bindings for simple nvmem framework which allows nvmem
> consumers to talk to nvmem providers to get access to nvmem cell data.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> [Maxime Ripard: intial version of eeprom framework]
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  Documentation/devicetree/bindings/nvmem/nvmem.txt | 85 +++++++++++++++++++++++
>  1 file changed, 85 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/nvmem.txt
>
> diff --git a/Documentation/devicetree/bindings/nvmem/nvmem.txt b/Documentation/devicetree/bindings/nvmem/nvmem.txt
> new file mode 100644
> index 0000000..849f1e1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/nvmem/nvmem.txt
> @@ -0,0 +1,85 @@
> += NVMEM(Non Volatile Memory) Data Device Tree Bindings =
> +
> +This binding is intended to represent the location of hardware
> +configuration data stored in NVMEMs like eeprom, efuses and so on.
> +
> +On a significant proportion of boards, the manufacturer has stored
> +some data on NVMEM, for the OS to be able to retrieve these information
> +and act upon it. Obviously, the OS has to know about where to retrieve
> +these data from, and where they are stored on the storage device.
> +
> +This document is here to document this.
> +
> += Data providers =
> +Contains bindings specific to provider drivers and data cells as children
> +of this node.

#address-cells and #size-cells are required here.

> +
> +Optional properties:
> + read-only: Mark the provider as read only.

Couldn't this be per field rather than global?

> +
> += Data cells =
> +These are the child nodes of the provider which contain data cell
> +information like offset and size in nvmem provider.
> +
> +Required properties:
> +reg:   specifies the offset in byte within that storage device, start bit
> +       in the byte and the length in bytes of the data we care about.
> +       There could be more than one offset-length pairs in this property.
> +
> +Optional properties:
> +
> +bit-offset: specifies the offset in bit within the address range specified
> +       by reg property. Can take values from 0-7.
> +nbits: specifies number of bits this cell occupies starting from bit-offset.

How about just: "bits = <<offset> <size>>"

Then the bit specification is more aligned with the byte location
(i.e. reg property).

You could also do this all in the reg property with 2 address cells
for byte and bit position and then size can be in bits. reg doesn't
have to match a memory mapped bus addressing meanings. If you wanted
to handle ranges and address translation, then you would need custom
functions like PCI does. I'm not sure you would need that.

> +
> +For example:
> +
> +       /* Provider */
> +       qfprom: qfprom at 00700000 {
> +               ...
> +
> +               /* Data cells */
> +               tsens_calibration: calib at 404 {
> +                       reg = <0x404 0x10>;
> +               };
> +
> +               tsens_calibration_bckp: calib_bckp at 504 {
> +                       reg = <0x504 0x11>;
> +                       bit-offset = 6;
> +                       nbits = 128;
> +               };
> +
> +               pvs_version: pvs-version at 6 {
> +                       reg = <0x6 0x2>
> +                       bit-offset = 7;
> +                       nbits = 2;
> +               };
> +
> +               speed_bin: speed-bin at c{
> +                       reg = <0xc 0x1>;
> +                       bit-offset = 2;
> +                       nbits   = 3;
> +
> +               };
> +               ...
> +       };
> +
> += Data consumers =
> +Are device nodes which consume nvmem data cells/providers.
> +
> +Required-properties:
> +nvmem-cells: list of phandle to the nvmem data cells.
> +nvmem-cell-names: names for the each nvmem-cells specified. Required if
> +       nvmem-cells is used.
> +
> +Optional-properties:
> +nvmem  : list of phandles to nvmem providers.
> +nvmem-names: names for the each nvmem provider. required if nvmem is used.
> +
> +For example:
> +
> +       tsens {
> +               ...
> +               nvmem-cells = <&tsens_calibration>;
> +               nvmem-cell-names = "calibration";
> +       };
> --
> 1.9.1
>
