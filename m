From: leigh@solinno.co.uk (Leigh Brown)
Date: Tue, 03 Dec 2013 23:20:38 +0000
Subject: Spurious timeouts in mvmdio
In-Reply-To: <529E5F03.8040607@gmail.com>
References: <529CA42A.3040504@freebox.fr>
 <20131203122346.GD29282@titan.lakedaemon.net>
 <20131203124033.GT16735@n2100.arm.linux.org.uk>
 <abe249f5cba5c267e2c536bd62c57908@doppler.thel33t.co.uk>
 <529E5F03.8040607@gmail.com>
Message-ID: <8d65780eb7bfe49bb0734a09f05f70a6@doppler.thel33t.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013-12-03 22:45, Sebastian Hesselbarth wrote:
> On 12/03/2013 09:57 PM, Leigh Brown wrote:
[...]
>> Nicolas' patch should fix the issue, but I prefer the following as it 
>> is
>> more
>> correct, as it only adjusts the timeout when calling
>> wait_event_timeout().  As
>> I said above,I believe the polling code is correct.
>> 
>> diff --git a/drivers/net/ethernet/marvell/mvmdio.c
>> b/drivers/net/ethernet/marvell/mvmdio.c
>> index 7354960..b187c08 100644
>> --- a/drivers/net/ethernet/marvell/mvmdio.c
>> +++ b/drivers/net/ethernet/marvell/mvmdio.c
>> @@ -92,6 +92,14 @@ static int orion_mdio_wait_ready(struct mii_bus 
>> *bus)
>>               if (time_is_before_jiffies(end))
>>                   ++timedout;
>>               } else {
>> +            /*
>> +             * wait_event_timeout does not guarantee a delay of at
>> +             * least one whole jiffie, so timeout must be no less
>> +             * than two.
>> +             */
>> +            if (timeout < 2)
>> +                timeout = 2;
> 
> If you always want to wait at least two jiffies, why not just increase
> TIMEOUT makro to 20ms instead of messing here with it again?
> As said on IRC log above, originally timeout was 100ms.
> 
> Sebastian

You could do that, but would you not feel bad leaving a latent bug in 
the code?
I know it's unlikely that someone would set HZ to 50, but if they did, 
the same
bug would appear again.

Regards,

Leigh.
