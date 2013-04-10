From: prabhakar.csengg@gmail.com (Prabhakar Lad)
Date: Wed, 10 Apr 2013 13:42:29 +0530
Subject: Query on pinctrl usage for DT nodes
In-Reply-To: <5162FD4A.1030909@wwwdotorg.org>
References: <CA+V-a8uiPwsAD--OHFAE=i2ed+-wbXm4p2deZXr92+Zv6GDS1w@mail.gmail.com>
 <515C5C76.3080009@wwwdotorg.org>
 <CA+V-a8t3wtP77DdeUoQHKMjAuWmV+ude+1J3UjJmMTqobgStjA@mail.gmail.com>
 <5162FD4A.1030909@wwwdotorg.org>
Message-ID: <CA+V-a8vwdCkyMqiynj5BodXbjwJ=e4qNb-29FhLweqbjc7DBQA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,Peter,

On Mon, Apr 8, 2013 at 10:54 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 04/08/2013 07:12 AM, Prabhakar Lad wrote:
>> On Wed, Apr 3, 2013 at 10:14 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>>> On 04/03/2013 03:16 AM, Prabhakar Lad wrote:
>>>> Hi Linus/Stephen,
>>>>
>>>> I am working adding  DT nodes for DA850.
> ...
>>>> But while booting I see the following boot log:-
>>>> ...
>>>> cpuidle: using governor menu
>>>> TCP: cubic registered
>>>> NET: Registered protocol family 17
>>>> pinctrl-single 1c14120.pinmux: pin 1c14130 already requested by
>>>> davinci_mdio.0; cannot claim for i2c_davinci.1
>>>> pinctrl-single 1c14120.pinmux: pin-4 (i2c_davinci.1) status -22
>>>> pinctrl-single 1c14120.pinmux: could not request pin 4 on device pinctrl-single
>>>> console [netcon0] enabled
>>>> ....
>>>>
>>>> This is because the mdio and i2c are using same pin 0x10,
>>>
>>> How can two devices use the same pin? I mean physically, in hardware?
>>>
>>> Is this because pinctrl-single uses the register address as the pin
>>> number, whereas you have registers which configure multiple pins at
>>
>> Yes you are correct, we have registers  which configure multiple pins at once.
>> For example for above Pin Multiplexing Control 4 Register (Pinmux4)
>> [1] page(250) : -
>>
>> PINMUX4_31_28 --> SP1_SCS[2]/UART1_TXD/SATA_CP_POD/GP1[0] Control
>> PINMUX4_27_24 --> SPI1_SCS[3]/UART1_RXD/SATA_LED/GP1[1] Control
>> PINMUX4_23_20 --> SPI1_SCS[4]/UART2_TXD/I2C1_SDA/GP1[2] Control
>> PINMUX4_19_16 --> SPI1_SCS[5]/UART2_RXD/I2C1_SCL/GP1[3] Control
>> PINMUX4_15_12 --> SPI1_SCS[6]/I2C0_SDA/TM64P3_OUT12/GP1[4] Control
>> PINMUX4_11_8 --> SPI1_SCS[7]/I2C0_SCL/TM64P2_OUT12/GP1[5] Control
>> PINMUX4_7_4 --> SPI0_SCS[0]/TM64P1_OUT12/GP1[6]/MDIO_D/TM64P1_IN12 Control
>> PINMUX4_3_0 --> SPI0_SCS[1]/TM64P0_OUT12/GP1[7]/MDIO_CLK/TM64P0_IN12 Control
>>
>>> once? If so, your hardware isn't something that can be represented by
>>> pinctrl-single.
>>
>> What is the alternative for such case ? any pointer would be helpful.
>>
>> [1] http://www.ti.com/general/docs/lit/getliterature.tsp?literatureNumber=spruh77a&fileType=pdf
>
> Tony previously replied:
>
> Tony wrote:
>> Tony wrote:
>>> ??? wrote:
>>>> Prabhakar wrote:
>>>>> Is there any
>>>>> alternative way to handle if the two node's are using same pins any
>>>>> pointers could be very much helpful ?
>>>
>>> It could also that the mux register(s) follow the one-mux-per-bit
>>> mapping.
>>>
>>> In that case pinctrl-single,bits option as documented in the
>>> Documentation/devicetree/bindings/pinctrl/pinctrl-single.txt.
>>
>> Oh it's already using pinctrl-single,bits option. Maybe there's a
>> bug, adding Peter to cc.
>
> So I guess you need to debug the code to see why that option isn't
> working for you.
>
Following is the proposed fix/hack let me know if its OK.

Regards,
--Prabhakar

->>>>>>>>>>>>>>>>>>>

diff --git a/drivers/pinctrl/core.h b/drivers/pinctrl/core.h
index ee72f1f..78fb42d 100644
--- a/drivers/pinctrl/core.h
+++ b/drivers/pinctrl/core.h
@@ -46,6 +46,7 @@ struct pinctrl_dev {
        struct pinctrl *p;
        struct pinctrl_state *hog_default;
        struct pinctrl_state *hog_sleep;
+       bool bits_per_mux;
 #ifdef CONFIG_DEBUG_FS
        struct dentry *device_root;
 #endif
diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index 5c32e88..d2a91ec 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -974,6 +974,7 @@ static int pcs_probe(struct platform_device *pdev)
                ret = -EINVAL;
                goto free;
        }
+       pcs->pctl->bits_per_mux = pcs->bits_per_mux;

        dev_info(pcs->dev, "%i pins at pa %p size %u\n",
                 pcs->desc.npins, pcs->base, pcs->size);
diff --git a/drivers/pinctrl/pinmux.c b/drivers/pinctrl/pinmux.c
index 1a00658..4989f01 100644
--- a/drivers/pinctrl/pinmux.c
+++ b/drivers/pinctrl/pinmux.c
@@ -110,7 +110,7 @@ static int pin_request(struct pinctrl_dev *pctldev,

                desc->gpio_owner = owner;
        } else {
-               if (desc->mux_usecount && strcmp(desc->mux_owner, owner)) {
+               if (!pctldev->bits_per_mux && desc->mux_usecount &&
strcmp(desc->mux_owner, owner)) {
                        dev_err(pctldev->dev,
                                "pin %s already requested by %s;
cannot claim for %s\n",
                                desc->name, desc->mux_owner, owner);
@@ -118,7 +118,7 @@ static int pin_request(struct pinctrl_dev *pctldev,
                }

                desc->mux_usecount++;
-               if (desc->mux_usecount > 1)
+               if (desc->mux_usecount > 1 && !pctldev->bits_per_mux)
                        return 0;

                desc->mux_owner = owner;
