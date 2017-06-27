From: snawrocki@kernel.org (Sylwester Nawrocki)
Date: Wed, 28 Jun 2017 00:57:32 +0200
Subject: [PATCH v1 1/6] DT bindings: add bindings for ov965x camera module
In-Reply-To: <39501C78-7B81-4803-94C1-25DFA06EA526@goldelico.com>
References: <1498143942-12682-1-git-send-email-hugues.fruchet@st.com>
 <1498143942-12682-2-git-send-email-hugues.fruchet@st.com>
 <D5629236-95D8-45B6-9719-E8B9796FEC90@goldelico.com>
 <64e3005d-31df-71f2-762b-2c1b1152fc2d@st.com>
 <5cd25a47-f3be-8c40-3940-29f26a245076@kernel.org>
 <39501C78-7B81-4803-94C1-25DFA06EA526@goldelico.com>
Message-ID: <e2a9df8b-00f8-ae36-f4f3-63dcc98dea50@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/27/2017 07:48 AM, H. Nikolaus Schaller wrote:
>> Am 26.06.2017 um 22:04 schrieb Sylwester Nawrocki <snawrocki@kernel.org>:
>>
>> On 06/26/2017 12:35 PM, Hugues FRUCHET wrote:
>>>> What I am missing to support the GTA04 camera is the control of the optional "vana-supply".
>>>> So the driver does not power up the camera module when needed and therefore probing fails.
>>>>
>>>>     - vana-supply: a regulator to power up the camera module.
>>>>
>>>> Driver code is not complex to add:
>>
>>> Yes, I saw it in your code, but as I don't have any programmable power
>>> supply on my setup, I have not pushed this commit.
>>
>> Since you are about to add voltage supplies to the DT binding I'd suggest
>> to include all three voltage supplies of the sensor chip. Looking at the OV9650
>> and the OV9655 datasheet there are following names used for the voltage supply
>> pins:
>>
>> AVDD - Analog power supply,
>> DVDD - Power supply for digital core logic,
>> DOVDD - Digital power supply for I/O.
> 
> The latter two are usually not independently switchable from the SoC power
> the module is connected to.
> 
> And sometimes DVDD and DOVDD are connected together.
> 
> So the driver can't make much use of knowing or requesting them because the
> 1.8V supply is always active, even during suspend.
> 
>>
>> I doubt the sensor can work without any of these voltage supplies, thus
>> regulator_get_optional() should not be used. I would just use the regulator
>> bulk API to handle all three power supplies.
> 
> The digital part works with AVDD turned off. So the LDO supplying AVDD should
> be switchable to save power (&vaux3 on the GTA04 device).>
> But not all designs can switch it off. Hence the idea to define it as an
> /optional/ regulator. If it is not defined by DT, the driver simply assumes
> it is always powered on.

I didn't say we can't define regulator supply properties as optional in the DT 
binding.  If we define them as such and any of these *-supply properties is 
missing in DT with regulator_get() the regulator core will use dummy regulator 
for that particular voltage supply.  While with regulator_get_optional() 
-ENODEV is returned when the regulator cannot be found. 

> So in summary we only need AVDD switched for the GTA04 - but it does not
> matter if the others are optional properties. We would not use them.
> 
> It does matter if they are mandatory because it adds DT complexity (size
> and processing) without added function.
 
We should not be defining DT binding only with selected use cases/board
designs in mind.  IMO all three voltage supplies should be listed in the
binding, presumably all can be made optional, with an assumption that when
the property is missing selected pin is hooked up to a fixed regulator.

--
Thanks,
Sylwester
