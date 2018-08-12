From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Sun, 12 Aug 2018 19:59:35 +0200
Subject: [RFC net-next 00/15] net: A socket API for LoRa
In-Reply-To: <CAC=mGzhaLiSj5-+euM-YTRLwNDi8QJY0fAbiZbUadkPhZGRh_Q@mail.gmail.com>
References: <20180701110804.32415-1-afaerber@suse.de>
 <CAC=mGzgUCopz2xTOA0R-WD8a1DOaOOUn=YpfdMiJ33y3hnh6kg@mail.gmail.com>
 <92ee4016-1da9-826b-3674-b2d604a64848@suse.de>
 <20180808213640.10a1d76f@alans-desktop>
 <a70e9715-beac-d9a8-145e-de00175e56fa@suse.de>
 <20180809125939.39ac2cc9@alans-desktop>
 <CAC=mGzjn4Kc-q9NFwX6NhU4V_thnzBP8SHtFQKyRbpSKR=yx3w@mail.gmail.com>
 <20180810165711.59bf26f7@alans-desktop>
 <CAC=mGzhaLiSj5-+euM-YTRLwNDi8QJY0fAbiZbUadkPhZGRh_Q@mail.gmail.com>
Message-ID: <11276f7d-0175-05e9-a9bd-c72868067081@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 12.08.2018 um 18:37 schrieb Jian-Hong Pan:
> Alan Cox <gnomes@lxorguk.ukuu.org.uk> ? 2018?8?10? ?? ??11:57???
>>
>>> The sleep/idle/stop mitigate the unconcerned RF signals or messages.
>>
>> At the physical level it's irrelevant. If we are receiving then we might
>> hear more things we later discard. It's not running on a tiny
>> microcontroller so the extra CPU cycles are not going to kill us.
> 
> According different power resource, LoRaWAN defines Class A, B and C.
> Class A is the basic and both Class B and C devices must also
> implement the feature of Class A.
[...]
> So, yes!  Class C opens the RX windows almost all the time, except the TX time.
> And uses different channel to avoid the reflection noise (*).
> 
> However, Class C must also implements Class A and C is more complex than A.
> I think starting from the simpler one and adding more features and
> complexity in the future will be a better practice.

Jian-Hong, you've failed to come up with any practical proposal or patch
how to implement what you are saying LoRaWAN requires. Doing the
impossible is never simpler!

Implementing a simple back-off timer sounds doable by comparison.

May I remind you, LoRa is the simpler step before LoRaWAN - if our
layering is done right, someone else might choose to implement LoRaWAN
in userspace based on PF_LORA. There is absolutely no reason to hardcode
any LoRaWAN settings at device driver level for e.g. SX1276.

>>>> How do you plan to deal with routing if you've got multiple devices ?
>>>
>>> For LoRaWAN, it is a star topology.
>>
>> No the question was much more how you plan to deal with it in the OS. If
>> for example I want to open a LORA connection to something, then there
>> needs to be a proper process to figure out where the target is and how to
>> get traffic to them.
>>
>> I guess it's best phrased as
>>
>> - What does a struct sockaddr_lora look like
> 
> According to LoRaWAN spec, the Data Message only has the device's
> DevAddr (the device's address in 4 bytes) field related to "address".
> The device just sends the uplink Data Message through the interface
> and does not know the destination.  Then, a LoRaWAN gateway receives
> the uplink Data Message and forwards to the designated network server.
> So, end device does not care about the destination.  It only knows
> there is a gateway will forward its message to some where.
> Therefore, only the DevAddr as the source address will be meaningful
> for uplink Data Message.

Note that he was asking about sockaddr_lora, not LoRaWAN.

The simple answer is that, inspired by CAN, it uses an ifindex to select
the interface the user asked to use. That then also answers Alan's next
question: This ifindex determines which interface it goes out to.

sockaddr_lora was in patch 02/15, latest code here:
https://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-lora.git/tree/include/uapi/linux/lora.h?h=lora-next

>> - How does the kernel decide which interface it goes out of (if any), and
>>   if it loops back
> 
> There is the MAC Header in the Data Message which is one byte.
> Bits 5 to 7 indicate which kind of type the message is.
> 000: Join Request
> 001: Join Accept
> 010: Unconfirmed Data Up
> 011: Unconfirmed Data Down
> 100: Confirmed Data Up
> 101: Confirmed Data Down
> 110: RFU
> 111: Proprietary
> 
> So, end device only accepts the types of downlink and the matched
> DevAddr (the device's address) in downlink Data Message for RX.

LoRaWAN is an entirely different story, therefore my agreement that we
need a separate PF_LORAWAN and sockaddr_lorawan for EUI addressing.

I still think the user will need to explicitly say which interface they
want to bind their socket to. AFAIU the device EUI is more comparable to
an Ethernet MAC address than to an IP address that the user would
configure routes for. If you have e.g. four SX1301 devices then they may
be configured for different frequencies, bandwidths, etc. but unlikely
for certain destination/source addresses. So either all that data comes
via sockaddr (which I was discussing in the FSK/OOK part of this thread)
or the user needs to make the interface choice for us.

Loopback mode would require a separate virtual device driver such as
fakelr or vlora.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
