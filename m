From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 16 Sep 2013 10:24:08 -0600
Subject: [PATCH] media: i2c: adv7343: fix the DT binding properties
In-Reply-To: <CA+V-a8sVyJ1TrTSiaj8vpaD+f_qJ5Hp287E3HuHJ_pRzzmdAvg@mail.gmail.com>
References: <1379073471-7244-1-git-send-email-prabhakar.csengg@gmail.com>
 <523395DC.5080009@wwwdotorg.org>
 <CA+V-a8sVyJ1TrTSiaj8vpaD+f_qJ5Hp287E3HuHJ_pRzzmdAvg@mail.gmail.com>
Message-ID: <523730A8.9060201@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/13/2013 11:23 PM, Prabhakar Lad wrote:
> Hi Stephen,
> 
> This patch should have been marked as RFC.
> 
> Thanks for the review.
> 
> On Sat, Sep 14, 2013 at 4:16 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> On 09/13/2013 05:57 AM, Prabhakar Lad wrote:
>>> From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
>>>
>>> This patch fixes the DT binding properties of adv7343 decoder.
>>> The pdata which was being read from the DT property, is removed
>>> as this can done internally in the driver using cable detection
>>> register.
>>>
>>> This patch also removes the pdata of ADV7343 which was passed from
>>> DA850 machine.
>>
>>> diff --git a/Documentation/devicetree/bindings/media/i2c/adv7343.txt b/Documentation/devicetree/bindings/media/i2c/adv7343.txt
>>
>>>  Required Properties :
>>>  - compatible: Must be "adi,adv7343"
>>> +- reg: I2C device address.
>>> +- vddio-supply: I/O voltage supply.
>>> +- vddcore-supply: core voltage supply.
>>> +- vaa-supply: Analog power supply.
>>> +- pvdd-supply: PLL power supply.
>>
>> Old DTs won't contain those properties. This breaks the DT ABI if those
>> properties are required. Is that acceptable?
>
> As of now adv7343 via DT binding is not enabled in any platforms
> so this wont break any DT ABI.

Well, if the binding has already been written, it technically already is
an ABI. Perhaps the binding can be fixed if it isn't in use yet, but
this is definitely not the correct approach to DT.

>> If it is, I think we should document that older versions of the binding
>> didn't require those properties, so they may in fact be missing.
>>
>> I note that this patch doesn't actually update the driver to
>> regulator_get() anything. Shouldn't it?
>
> As of now the driver isn?t enabling/accepting the regulators,
> so should I add those in DT properties or not ?

The binding should describe the HW, not what the driver does/doesn't yet
do. I wrote the above because it looked like the driver was broken, not
to encourage you to remove properties from the binding. How does the
driver work if it doesn't enable the required regulators though, I
wonder? I suppose the boards this driver has been tested on all must
used fixed (non-SW-controlled) regulators.

>>>  Optional Properties :
>>> -- adi,power-mode-sleep-mode: on enable the current consumption is reduced to
>>> -                           micro ampere level. All DACs and the internal PLL
>>> -                           circuit are disabled.
>>> -- adi,power-mode-pll-ctrl: PLL and oversampling control. This control allows
>>> -                        internal PLL 1 circuit to be powered down and the
>>> -                        oversampling to be switched off.
>>> -- ad,adv7343-power-mode-dac: array configuring the power on/off DAC's 1..6,
>>> -                           0 = OFF and 1 = ON, Default value when this
>>> -                           property is not specified is <0 0 0 0 0 0>.
>>> -- ad,adv7343-sd-config-dac-out: array configure SD DAC Output's 1 and 2, 0 = OFF
>>> -                              and 1 = ON, Default value when this property is
>>> -                              not specified is <0 0>.
>>
>> At a very quick glance, it's not really clear why those properties are
>> being removed. They seem like HW configuration, so might be fine to put
>> into DT. What replaces these?
> 
> Yes these were HW configuration but, its now internally handled in
> the driver.  The 'ad,adv7343-power-mode-dac' property which enabled the
> DAC's 1..6 , so now in the driver by default all the DAC's are enabled by
> default and enable unconnected DAC auto power down. Similarly
> 'ad,adv7343-sd-config-dac-out' property enabled SD DAC's 1..2 but
> now is enabled by reading the CABLE DETECT register which tells
> the status of DAC1/2.

OK, that's probably fine for the two properties you mentioned (you
didn't describe two of them...). Some more discussion on why SW doesn't
need these options might be useful in the patch description. Note that
the discussion should be written for software in general (i.e. any OS's
driver), and not for Linux's specific driver, since DT is not tied to
any one OS.
