From: starnight@g.ncu.edu.tw (Jian-Hong Pan)
Date: Sun, 5 Aug 2018 22:08:10 +0800
Subject: linux-lora.git and LoRaWAN (was: [RFC net-next 00/15] net: A
 socket API for LoRa)
In-Reply-To: <20180803150258.791b9942@alans-desktop>
References: <20180701110804.32415-1-afaerber@suse.de>
 <BY1PR02MB11147C7443AB9623D6B65798E75A0@BY1PR02MB1114.namprd02.prod.outlook.com>
 <e08cdcfb-207f-bd73-2afd-f775810b72b7@suse.de>
 <BY1PR02MB11143134B9ABAC9C9929A9C4E7530@BY1PR02MB1114.namprd02.prod.outlook.com>
 <CAC=mGzg0uP6ddm-kjev6JAH=GrKX9bT6s2canFOjKsC4rCcVAQ@mail.gmail.com>
 <6dda350b-66ab-b5ab-41ed-319b27e4e28c@suse.de>
 <20180803150258.791b9942@alans-desktop>
Message-ID: <CAC=mGzgW2fmRAA9GxojcbiBWm_G=rWqFh2MZECu-VST20MePBg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alan,

2018-08-03 22:02 GMT+08:00 Alan Cox <gnomes@lxorguk.ukuu.org.uk>:
>> I'm not yet too deep into LoRaWAN, but from the AT command interfaces
>> I've seen there's confirmed and unconfirmed transmission modes that with
>> PF_LORAWAN might be mapped to SOCK_STREAM and SOCK_DGRAM. Or do you see
>> a way of doing both on a single PF_LORA SOCK_LORAWAN socket?
>
> SOCK_STREAM is not a confirmed message, but a reliable data stream where
> packet boundaries have no meaning.
>
> SOCK_SEQPACKET is a reliable ordered stream where message boundaries have
> meaning.
>
> SOCK_RDM is reliable messaging where there is no ordering.
>
> The standard socket API has no concept of a single connection doing both
> reliable and unreliable messages.

Thanks for the useful information.

LoRaWAN has 4 kinds of data messages: Unconfirmed data up/down,
Confirmed data up/down.

Unconfirmed data up/down can be mapped to SOCK_DGRAM.
Confirmed data up/down can be mapped to SOCK_SEQPACKET.  Because,
there is the FCnt (frame counter) field in frame header for the order.

Regards,
Jian-Hong Pan

>> Additionally I've been looking into socket options at PF_LORA dgram
>> layer for some radio options, but discarded that again for lack of
>> precedence. Basically I wondered whether we could allow to choose SF,
>
> I don't know if it'll stretch that far in the right directions but to the
> extent you can re-use bits of the wifi API and it makes sense it would be
> good to do so.
>
> For stuff bound to a specific socket you need to use the generic SOCK_
> stuff or you may indeed need some socket options at the PF_LORA level -
> which is fine, and the whole point of setsockopt passing layers around.
>
> Some of the existing general stuff like priority is probably quite
> useable.
>
>> bandwidth, etc. on socket level and then apply those settings before
>> sending one packet rather than expecting a global netlink operation that
>> affects all sockets for that interface.
>
> Alan
