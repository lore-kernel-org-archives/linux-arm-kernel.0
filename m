From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 6 Apr 2013 15:34:36 +0200
Subject: [PATCH v3 1/5] drivers: memory: Introduce Marvell EBU Device Bus
 driver
In-Reply-To: <1365246930-13315-2-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1365246930-13315-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1365246930-13315-2-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <201304061534.36682.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 06 April 2013, Ezequiel Garcia wrote:
> +       device-bus at d0010400 {
> +               status = "okay";
> +               ranges = <0 0 0xf0000000 0x1000000>; /* CS0 @addr 0xf0000000, size 0x1000000 */
> +               #address-cells = <2>;
> +               #size-cells = <1>;
> +
> +               flash at 0 {
> +                       compatible = "cfi-flash";
> +
> +                       /* CS0, 16 MiB */
> +                       reg = <0 0 0x1000000>;
> +                       bank-width = <2>;
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +
> +                       /* Device Bus parameters are required */
> +
> +                       /* Read parameters */
> +                       devbus,dev-width    = <1>;
> +                       devbus,turn-off-ps  = <60000>;
> +                       devbus,badr-skew-ps = <0>;
> +                       devbus,acc-first-ps = <124000>;
> +                       devbus,acc-next-ps  = <248000>;
> +                       devbus,rd-setup-ps  = <0>;
> +                       devbus,rd-hold-ps   = <0>;

I just read the email from Jason Gunthorpe suggesting to have a separate
device-bus instance for each CS under it.

I think the implication of that is that all the "devbus,..." properties can
now be moved into the parent node, which makes the split between the
devbus node and its attached device clearer.

	Arnd
