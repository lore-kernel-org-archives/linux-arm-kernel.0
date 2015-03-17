From: hns@goldelico.com (Dr. H. Nikolaus Schaller)
Date: Tue, 17 Mar 2015 15:12:58 +0100
Subject: [PATCH v3 3/6] Documentation: DT: Document twl4030-madc-battery
 bindings
In-Reply-To: <20150317135913.GA4034@amd>
References: <1423088075-10025-1-git-send-email-marek@goldelico.com>
 <1423088075-10025-4-git-send-email-marek@goldelico.com>
 <20150316210532.GA11441@amd>
 <CAAfyv34vnRY=TAyx4+7s1SW7rVE7CFh9z+OOcCsbCx63y9aVog@mail.gmail.com>
 <20150317084730.GA9761@amd>
 <940EE988-03A4-4B1B-A168-959E367953A6@goldelico.com>
 <20150317103746.GB3759@amd>
 <CDA0FF88-2D00-46E0-828E-DD6F4FF4ADAF@goldelico.com>
 <20150317135913.GA4034@amd>
Message-ID: <4E240771-5F35-44BB-B1BA-7D24FE93F08E@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pavel,

Am 17.03.2015 um 14:59 schrieb Pavel Machek <pavel@ucw.cz>:

> Hi!
> 
>>>>>>> to introduce coefficients for temperature and discharge rate?
>>>>>> What do you mean? Nothing like that is used in current driver why do
>>>>>> we need to add it?
>>>>> 
>>>>> Well, conversion between Li-ion's voltage and state of charge at 0
>>>>> current is well known:
>>>> 
>>>> We can?t measure at 0 current since the OMAP is driven from battery
>>>> and charger and may also draw some mA?
>>> 
>>> Yes, but you know how many mA you are taking just now. So if you knew
>>> the internal resistance, you could compute the voltage at 0
>>> current. (And it should also work during charging, as long as you know
>>> how much current is going in.)
>> 
>> As far as I understand the twl4030 charger and MADC it is not possible to
>> separate these values. It is only reporting the inflow from charger to
>> battery + system. So you don?t know how many mA are supplying the system
>> and how many mA are left over for charging.
>> 
>> You can only assume how much the system is drawing while running (something
>> between 50 and 600 mA but this depends on system activities, power state
>> of peripherald and e.g. backlight being switched on).
>> 
>> I think your basic assumption that we know any time how many mA the system
>> is taking is not given.
> 
> So.. you won't be able to get exact value while charging, but you
> get one while discharging, which is what really matters??

Is it the same during charging?

And, as we already discussed it depends on the situation.

In addition, GSM power consumption runs in bursts and I don?t know if the sample
rate of the MADC is good enough to track that correctly.

> 
>>> Yes, and that coefficient should be internal battery resistance ;-).
>> 
>> But where do you know this value from to write it into a DT file?
>> Usually you can?t measure it easily and for some batteries you don?t have
>> a data sheet.
>> 
>> Contrary, the calibration curves can easily be measured on the device
>> (assuming that the charge level decreases/increases linearly over time
>> between Full and Empty).
> 
> If you can copy it from the data sheet, that's the easiest option. If
> not, you should be able to easily compute it from the charge/discharge
> curves or from measured voltage at different loads.

Well, this again assumes that you can generate/control different loads
easily (e.g. turn on/off this and that peripheral) to check the voltage
drop. Sounds good in theory, but I don?t want to do it in practice to
derive this parameter.

And, don?t forget that the MADC signals are nosiy and don?t have the
best precision. So it is likely that you get wrong values.

As said, I think it is not worth the effort around the imperfect twl4030/MADC
charging system.

If someone wants precise data, that is what fuel gauge chips are good for.
And we already have drivers for them.

BR,
Nikolaus
