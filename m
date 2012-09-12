From: rajanikanth.hv@stericsson.com (Rajanikanth HV)
Date: Wed, 12 Sep 2012 20:03:00 +0530
Subject: Implement devicetree support for AB8500 Btemp
In-Reply-To: <201209111122.08713.arnd@arndb.de>
References: <CAB4BAktQz5MY_AHHWUAhRp7HtEzC3v8uFbP0enx1b7ibJLoZ4Q@mail.gmail.com>
 <201209101401.06859.arnd@arndb.de> <504EFA0F.2090102@stericsson.com>
 <201209111122.08713.arnd@arndb.de>
Message-ID: <50509D1C.9060206@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tuesday 11 September 2012 04:52 PM, Arnd Bergmann wrote:
> On Tuesday 11 September 2012, Rajanikanth HV wrote:
>>>> +Supplied-to:
>>>> +     This shall be power supply class dependency where in the
>> runtime battery
>>>> +     properties will be shared across fuel guage and charging
>> algorithm driver.
>>>
>>> I probably don't understand enough of this, but shouldn't the other
>> devices
>>> that are supplied by this have a reference to this node rather than doing
>>> it this way around? Why use strings here instead of phandles?
>>
>> This is a logical binding w.r.t power supply event change
>> across energy-management-module drivers where in runtime battery
>> properties are shared along with uevent notification.
>> ref: di->btemp_psy.external_power_
>> changed =
>>      ab8500_btemp_external_power_changed;
>>      ref: ab8500_btemp.c
>>
>> Need for this property:
>>  btemp, fg and charger updates power-supply properties
>>  based on the events listed above.
>>  Event handler invokes power supply change notifier
>>  which in-turn invokes registered power supply class call-back
>>  based on the 'supplied_to' string.
>>  ref:
>>    power_supply_changed_work(..) ./drivers/power/power_supply_core.c
>>
>> In this case how to approach through phandle?
>> ============================
>>
> 
> Sorry, I really tried, but I cannot make sense of what you wrote
> there. Can you try again and describe in full English sentences
> how the hardware blocks are connected
Consider: USB charging:
            ______________________
           |                      |
--(Vbus)-->|   USB Charger with   |
           |  Charger FSM (h/w)   |
           |______________________|
                |    |
                |    |(Vbat and other signals)
                |  __|_____
        to      | |        |(GaugeSense
     Charger FSM| | LION   | Signal)     _____________
                | |Battery |----------->|FuelGauge blk|
                | |________|            |{Coulomb Ctr}|
                |       |                -------------
                |   <Thermistor>
                |       |
                |       | (BatCtrl Signal)
                |_______|---------->[Btemp blk]
                        |               |
                      [ADC]             |__Btemp_Low
                                        |__Btemp_Med
                                        |__Btemp_High

Note: Charging algorithm is a logical entity.

 and what their purpose is?
a) Coulomb counter comprises '12bit adc' and an 'N sample
average/accumulation' logic helps to measure battery capacity
Note: The charge and the discharge current of the battery is
        converted to voltage by an external resistor connected
        between GaugeSenseP and GaugeSenseN pins.

b) Battery temperature monitoring comprises a comparator which is
   enabled only by HW (charger state machine) helps to measure
   the thermal threshold
Note: The accuracy of the battery temperature measurement depends
        of the accuracy of the thermistor used.

c) Charger provides 'Constant Current Constant Voltage' USB and
   Main(Wall) Charging support, it embeds: voltage detection,
   thermal protection, Constant voltage charging with programmable level,
   clock dithering and battery voltage monitoring

e.g. Correlation between charger and Btemp
- if the battery temperature is higher than ?MaxTemp ?C,
  the charger does not start, but is enabled

- if the battery temperature is between 0?C and ?MaxTemp? ?C
  charging is done in AB8500 Hardware control mode

- charging is done in DB8500 Software control mode, if the battery:
  has a voltage higher than the ?BattOK Threshold

- If the battery temperature is between -10?C and 0?C:
  charging is done in AB8500 Hardware control mode

- If the battery temperature is below -10?C, charging is
  done in AB8500 Hardware control mode
> 
> 	Arnd
> 
