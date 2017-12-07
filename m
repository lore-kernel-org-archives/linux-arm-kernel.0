From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 7 Dec 2017 14:26:43 +0800
Subject: [PATCH 2/2] arm64: allwinner: a64: bananapi-m64: add usb otg
In-Reply-To: <CAD6G_RR-VccHjdrXs55=C50OvDEr96c7axtbR0eKp2THFNx6sg@mail.gmail.com>
References: <1512582664-24936-1-git-send-email-jagan@amarulasolutions.com>
 <CAGb2v67uFnV+m1Ub7rFVGhkv0HKD4ukpQFtJ1pqRi2vf4F=tFA@mail.gmail.com>
 <CAD6G_RR-VccHjdrXs55=C50OvDEr96c7axtbR0eKp2THFNx6sg@mail.gmail.com>
Message-ID: <CAGb2v67dh=dfPKdDOwfj8m7qmUk-=s4kXS3FvZLczskrjbr7eQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 7, 2017 at 2:18 PM, Jagan Teki <jagannadh.teki@gmail.com> wrote:
> On Thu, Dec 7, 2017 at 8:54 AM, Chen-Yu Tsai <wens@csie.org> wrote:
>> On Thu, Dec 7, 2017 at 1:51 AM, Jagan Teki <jagannadh.teki@gmail.com> wrote:
>>> usb otg on bananapi-m64 has configured with USB-ID with PH9
>>> and USB-DRVVBUS attached with dcdc1 regulatort.
>>
>> That is not how you read the schematic...
>>
>> Intersecting lines that are tied together will have a dot representing
>> the connection. The DCDC1 line is a pull-up for the ID pin. This is very
>> clear because it has a resistor connected in series.
>>
>> VBUS for OTG is controlled by the IC displayed to the right in the
>> schematic, which is powered from 5V, and controlled by the DRVVBUS
>> pin from the PMIC. Please take a look at how the A31/A33/A83T board
>> dts files represent this.
>
> This is where I confused, USB-DRVVBUS is connected to pin 51 of PMIC
> if we add 5v regulator how can configure gpio number for this? I saw

>From the axp20x bindings:

- x-powers,drive-vbus-en: boolean, set this when the N_VBUSEN pin is
                          used as an output pin to control an external
                          regulator to drive the OTG VBus, rather then
                          as an input pin which signals whether the
                          board is driving OTG VBus or not.
                          (axp221 / axp223 / axp813 only)

Setting this allows you to use the "drivevbus" regulator under the PMIC.
As I said, look at how other boards are doing it.

> sun8i-a33-olinuxino.dts which is also similar but it has gpio = <&pio
> 1 9 GPIO_ACTIVE_HIGH>;

I have no idea where you saw this. It does not exist in my tree.

Why don't you just trace backwards from the usb0_vbus-supply property
under the usbphy node, and see where it all leads.

ChenYu
