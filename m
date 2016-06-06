From: robh@kernel.org (Rob Herring)
Date: Mon, 6 Jun 2016 09:35:30 -0500
Subject: [PATCH v3] regulator: axp20x: Add support for the (external)
 drivebus regulator
In-Reply-To: <1464973184-17244-1-git-send-email-hdegoede@redhat.com>
References: <1464973184-17244-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20160606143530.GA21766@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 03, 2016 at 06:59:44PM +0200, Hans de Goede wrote:
> The axp20x pmics have 2 power inputs, one called ACIN which is intended
> for to be supplied via a powerbarrel on the board and one called VBUS
> which is intended to be supplied via an otg connector.
> 
> In the VBUS case the pmic needs to know if the board is supplying power
> to the otg connector, because then it should not take any power from
> its VBUS pin. The axp209 pmic has a N_VBUSEN input pin via which the
> board can signal to the pmic whether the board is supplying power to the
> otg connector or not.
> 
> On the axp221/axp223 this pin can alternatively be used as an output
> which controls an external regulator which (optionally) supplies
> power to the otg connector from the board. When the pin is used as
> output it is called DRIVEVBUS in the datasheet.
> 
> This commit adds support for the DRIVEVBUS pin as an extra pmic
> controlled regulator. Since this is optional a new x-powers,drivebus dt
> property is added. When this is present the misc-control register is
> written to change the N_VBUSEN input pin to DRIVEVBUS output pin mode and
> the extra drivebus regulator is registered with the regulator subsystem.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Acked-by: Chen-Yu Tsai <wens@csie.org>
> ---
> Changes in v2:
> -Set supply_name to just drivebus instead of drivevbus-supply
> -Fix some whitespace errors in the docs
> 
> Changes in v2:
> -Rename the dt property to drive-vbus-en
> -s/drivebus/drivevbus/
> -Add a line describing the drivevbus regulator to the table in
>  Documentation/devicetree/bindings/mfd/axp20x.txt
> -Set supply_name to drivevbus-supply
> ---
>  Documentation/devicetree/bindings/mfd/axp20x.txt |  6 +++++

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/regulator/axp20x-regulator.c             | 30 ++++++++++++++++++++++++
>  2 files changed, 36 insertions(+)
