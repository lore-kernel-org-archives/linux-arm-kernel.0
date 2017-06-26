From: snawrocki@kernel.org (Sylwester Nawrocki)
Date: Mon, 26 Jun 2017 22:04:53 +0200
Subject: [PATCH v1 1/6] DT bindings: add bindings for ov965x camera module
In-Reply-To: <64e3005d-31df-71f2-762b-2c1b1152fc2d@st.com>
References: <1498143942-12682-1-git-send-email-hugues.fruchet@st.com>
 <1498143942-12682-2-git-send-email-hugues.fruchet@st.com>
 <D5629236-95D8-45B6-9719-E8B9796FEC90@goldelico.com>
 <64e3005d-31df-71f2-762b-2c1b1152fc2d@st.com>
Message-ID: <5cd25a47-f3be-8c40-3940-29f26a245076@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/26/2017 12:35 PM, Hugues FRUCHET wrote:
>> What I am missing to support the GTA04 camera is the control of the optional "vana-supply".
>> So the driver does not power up the camera module when needed and therefore probing fails.
>>
>>     - vana-supply: a regulator to power up the camera module.
>>
>> Driver code is not complex to add:

> Yes, I saw it in your code, but as I don't have any programmable power
> supply on my setup, I have not pushed this commit.

Since you are about to add voltage supplies to the DT binding I'd suggest
to include all three voltage supplies of the sensor chip. Looking at the OV9650
and the OV9655 datasheet there are following names used for the voltage supply
pins:

AVDD - Analog power supply,
DVDD - Power supply for digital core logic,
DOVDD - Digital power supply for I/O.

I doubt the sensor can work without any of these voltage supplies, thus
regulator_get_optional() should not be used. I would just use the regulator
bulk API to handle all three power supplies.

--
Regards,
Sylwester
