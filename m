From: yixun.lan@amlogic.com (Yixun Lan)
Date: Thu, 5 Jul 2018 10:52:12 +0800
Subject: [PATCH 0/3] pinctrl: meson-g12a: add pinctrl driver support
In-Reply-To: <78da7e13-e80b-d714-86d0-7c5f6fc0d9f5@baylibre.com>
References: <20180704224511.29350-1-yixun.lan@amlogic.com>
 <78da7e13-e80b-d714-86d0-7c5f6fc0d9f5@baylibre.com>
Message-ID: <886462fa-1833-a99a-a2fa-5b7dd58341fd@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI Neil

On 07/04/18 22:57, Neil Armstrong wrote:
> Hi Yixun,
> 
> On 05/07/2018 00:45, Yixun Lan wrote:
>> This patch series try to add pinctrl driver support for
>> the Meson-G12A SoC.
> 
> Thanks for submitting these patches.
> 
> Can you explicit this patchset with more details on the G12A SoC family ?
> It's relationship with AXG and the differences in term of pinmuxing with the other SoC families ?
> 
I thought this was already discussed while we doing pinctrl driver for
Meson-AXG SoC.

Anyway, here it is:

Starting from Meson-AXG SoC, the pinctrl controller block using 4
continues bit to specific pin mux function, while comparing to old
generation SoC which kind of using various length bits for the pin mux
definition. The new design would greatly simplify the software model..

for detail example, one 32bit register can describe 8 pins, and each of
them has 0-7 value to set, start from value 0 to 7.

partition the register into 8 parts:
bit[3:0]
bit[7:4]
bit[11:8]
bit[15:12]
bit[19:16]
bit[23:20]
bit[27:24]
bit[31:28]


for each value:
value == 0, means the pin is GPIO
value = {1, 2, ... 7 } is one of specific PIN function

I could put this info into cover-letter or commit message?

> Why is there a GPIOE bank within the AO controller ?
> 

It actually sit in the AO domain, although it's sounds strange from the
naming..

I'm not sure if it's good idea to append a AO suffix? since the
documentation just use the plain GPIOE

> Thanks,
> Neil
> 
>>
>> Yixun Lan (3):
>>   documentation: Add compatibles for Amlogic Meson G12A pin controllers
>>   dt-bindings: pinctrl: meson-g12a: document pin name
>>   pinctrl: meson-g12a: add pinctrl driver support
>>
>>  .../bindings/pinctrl/meson,pinctrl.txt        |    2 +
>>  drivers/pinctrl/meson/Kconfig                 |    6 +
>>  drivers/pinctrl/meson/Makefile                |    1 +
>>  drivers/pinctrl/meson/pinctrl-meson-g12a.c    | 1432 +++++++++++++++++
>>  include/dt-bindings/gpio/meson-g12a-gpio.h    |  114 ++
>>  5 files changed, 1555 insertions(+)
>>  create mode 100644 drivers/pinctrl/meson/pinctrl-meson-g12a.c
>>  create mode 100644 include/dt-bindings/gpio/meson-g12a-gpio.h
>>
> 
> .
> 
