From: romain.izard.pro@gmail.com (Romain Izard)
Date: Mon, 6 Nov 2017 16:57:12 +0100
Subject: [PATCH 2/2] crypto: atmel-aes - Reset the controller before each
 use
In-Reply-To: <ff2356ef-2c11-18e5-6da2-654b1d77280c@microchip.com>
References: <20171031152524.25216-1-romain.izard.pro@gmail.com>
 <20171031152524.25216-3-romain.izard.pro@gmail.com>
 <ff2356ef-2c11-18e5-6da2-654b1d77280c@microchip.com>
Message-ID: <CAGkQfmNFZcfeTVPOhQEwqXjaUPVu1se+j-x_kbrB29ag_4OU9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-11-06 16:45 GMT+01:00 Tudor Ambarus <tudor.ambarus@microchip.com>:
> Hi, Romain,
>
> On 10/31/2017 05:25 PM, Romain Izard wrote:
>>
>> When using the rfc4543(gcm(aes))) mode, the registers of the hardware
>> engine are not empty after use. If the engine is not reset before its
>> next use, the following results will be invalid.
>>
>> Always reset the hardware engine.
>
>
> Thanks for the fix! I could reproduce the issue only when running
> rfc4543(gcm(aes))) and then, immediately after, ecb(aes).
>
> Have you encountered this bug with other combination of algorithms?
>
> I'm trying to isolate the bug so that we can have a more fine-grained
> fix.

I just ran the tcrypt tests because they were failing on the
cts(cbc(aes)) transform and I observed this issue when the ecb
test failed only on the second run.

For me, the issue looks like the rfc4543 mode does not read
all the registers from the AES engine, and the following operation
fails because the registers are reused directly in the ECB mode.

As the ECB mode is a rare case where we do not use an IV, this
may be the reason why other modes do not display the issue.

-- 
Romain Izard
