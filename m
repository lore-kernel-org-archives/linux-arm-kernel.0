From: amelie.delaunay@st.com (Amelie DELAUNAY)
Date: Fri, 23 Feb 2018 10:46:52 +0000
Subject: [PATCH v2] usb: host: ehci-platform: add support for optional
 external vbus supply
In-Reply-To: <Pine.LNX.4.44L0.1802221325220.1295-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1802221325220.1295-100000@iolanthe.rowland.org>
Message-ID: <55196991-f9c1-6d8d-368f-2ab5f8e81c56@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/22/2018 07:27 PM, Alan Stern wrote:
> On Thu, 22 Feb 2018, Amelie DELAUNAY wrote:
> 
>>>>>>> --- a/Documentation/devicetree/bindings/usb/usb-ehci.txt
>>>>>>> +++ b/Documentation/devicetree/bindings/usb/usb-ehci.txt
>>>>>>> @@ -19,6 +19,7 @@ Optional properties:
>>>>>>>      - phys : phandle + phy specifier pair
>>>>>>>      - phy-names : "usb"
>>>>>>>      - resets : phandle + reset specifier pair
>>>>>>> + - vbus-supply : phandle of regulator supplying vbus
>>>>>>>     
>>>>>>
>>>>>> Can platforms have more than one regulator e.g. one regulator per port?
>>>>>>
>>>>>
>>>>> I imagine that yes, platforms could have one regulator per port.
>>>>> Regulator consumers bindings impose a <name>-supply property per
>>>>> regulator, so, what do you think about :
>>>>> vbus0-supply for port#0
>>>>> vbus1-supply for port#1
>>>>> ...
>>>>> vbusN-supply for port#N
>>>>>
>>>>> And then in probe, allocate 'struct regulator *vbus_supplies' with a
>>>>> size corresponding to 'HCS_N_PORTS(ehci->hcs_params) * sizeof(struct
>>>>> regulator *)'.
>>>>> And loop to get optional regulator vbus0, vbus1,..., vbusN.
>>>>> And then enable/disable the corresponding regulator in
>>>>> ehci_platform_port_power thanks to portnum.
>>>>
>>>> Looks fine to me but we need to get Alan's opinion if this is worth the effort.
>>>> If there isn't a single platform needing it we could probably do without it
>>>> but the DT binding must be scalable to add this feature in the future.
>>>
>>> I agree that for now there don't seem to be any platforms requiring
>>> more than one regulator, but this should be implemented in a way that
>>> could be expanded if necessary.
>>>
>>> Anyway, the basic idea is reasonable.  I don't know to what extent
>>> people want to power-off their EHCI ports, but if they do then we ought
>>> to turn off external regulators at the same time.
>>>
>>> Is there a real-life use case for this?
>>>
>>> Alan Stern
>>>
>>
>> On my setup I have the following:
>>
>>                    regulator_____vbus
>>    _________________             \
>> | EHCI controller |-port0-----[USB connector]
>> |_________________|-port1-----X
>>
>> So, I have one regulator only for port0. But I could I have one more if
>> port1 was connected. My current regulator could also supplies port1.
>>
>> To allocate a vbus_supplies array depending on N_PORTS, I have to move
>> this initialization from probe to ehci_platform_reset, after ehci_setup
>> is done.
>> Then, I have to define each regulator id depending on the port number.
>> This imposes a binding like
>> - portN_vbus-supply : phandle of regulator supplying vbus for port N
>> But I don't know if we can describe it like this in dt-bindings ?
>>
>> &ehci {
>> 	...
>> 	port0_vbus-supply = <&vbus_reg>;
>> 	port1_vbus-supply = <&vbus_reg>; //Could be another regulator, or not
>> specified if port is not connected.
>> 	...
>> };
>>
>> Is it ok to move vbus_supplies initialization in ehci_platform_reset ?
> 
> Yes, it's okay to move the code if you need to.
> 
> However, I can not speak on the DT implications.  Someone who knows
> more about it should chime in.
> 
> Alan Stern
> 

Thanks Alan,

I'm going to send a v3 including all these changes to ease review.

Regards,
Amelie
