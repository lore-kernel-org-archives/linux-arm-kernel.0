From: marek.belisko@gmail.com (Belisko Marek)
Date: Mon, 6 Dec 2010 20:11:16 +0100
Subject: [PATCH] arm: ecard: Fix compilation warning.
In-Reply-To: <20101206140506.GE31777@n2100.arm.linux.org.uk>
References: <1291644243-23540-1-git-send-email-marek.belisko@open-nandra.com>
	<20101206140506.GE31777@n2100.arm.linux.org.uk>
Message-ID: <AANLkTinynXGtFs-CTW1MwgZE_kRgZ7VgJ1mLy-hktrF5@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 6, 2010 at 3:05 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Dec 06, 2010 at 03:04:03PM +0100, Marek Belisko wrote:
>> Fix following compilation warning:
>> arch/arm/kernel/ecard.c:1066: warning: ignoring return value of
>> 'device_register', declared with attribute warn_unused_result
>>
>> Signed-off-by: Marek Belisko <marek.belisko@open-nandra.com>
>> ---
>> ?arch/arm/kernel/ecard.c | ? ?6 ++++--
>> ?1 files changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/kernel/ecard.c b/arch/arm/kernel/ecard.c
>> index eed2f79..da882b1 100644
>> --- a/arch/arm/kernel/ecard.c
>> +++ b/arch/arm/kernel/ecard.c
>> @@ -1063,8 +1063,10 @@ ecard_probe(int slot, card_type_t type)
>> ? ? ? *ecp = ec;
>> ? ? ? slot_to_expcard[slot] = ec;
>>
>> - ? ? device_register(&ec->dev);
>> -
>> + ? ? rc = device_register(&ec->dev);
>> + ? ? if (rc)
>> + ? ? ? ? ? ? goto nodev;
>> +
>> ? ? ? return 0;
>
> No. ?It is important that cards which are actually there remain present
> even if device_register fails. ?In other words, we _really_ don't care
> what device_register() returns.
OK understand but anyway to stop compiler bark following could be OK and
maybe other people saw error and try to send same patch so keep them informed.

diff --git a/arch/arm/kernel/ecard.c b/arch/arm/kernel/ecard.c
index eed2f79..d3dcb1a 100644
--- a/arch/arm/kernel/ecard.c
+++ b/arch/arm/kernel/ecard.c
@@ -1062,8 +1062,12 @@ ecard_probe(int slot, card_type_t type)

        *ecp = ec;
        slot_to_expcard[slot] = ec;
-
-       device_register(&ec->dev);
+       /*
+        * Return value not checked. It is important that cards
+        * which are actually there remain present even if
+        * device_register fails.
+        */
+       rc = device_register(&ec->dev);

        return 0;

>

thanks,

marek

-- 
as simple and primitive as possible
-------------------------------------------------
Marek Belisko - OPEN-NANDRA
Freelance Developer

Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
Tel: +421 915 052 184
skype: marekwhite
icq: 290551086
web: http://open-nandra.com
