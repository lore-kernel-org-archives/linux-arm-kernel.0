From: dnelson@redhat.com (Dean Nelson)
Date: Thu, 8 Feb 2018 15:57:21 -0600
Subject: net: thunder: change q_len's type to handle max ring size
In-Reply-To: <20180208.153453.774785043965984772.davem@davemloft.net>
References: <151811766130.10712.18293368656209944798.email-sent-by-dnelson@aqua>
 <20180208.153453.774785043965984772.davem@davemloft.net>
Message-ID: <41824374-cdea-a3ef-0109-20565dbba43e@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/08/2018 02:34 PM, David Miller wrote:
> From: Dean Nelson <dnelson@redhat.com>
> Date:
> 
>> The Cavium thunder nicvf driver supports rx/tx rings of up to 65536 entries per.
>> The number of entires are stored in the q_len member of struct q_desc_mem. The
>> problem is that q_len being a u16, results in 65536 becoming 0.
>>
>> In getting pointers to descriptors in the rings, the driver uses q_len minus 1
>> as a mask after incrementing the pointer, in order to go back to the beginning
>> and not go past the end of the ring.
>>
>> With the q_len set to 0 the mask is no longer correct and the driver does go
>> beyond the end of the ring, causing various ills. Usually the first thing that
>> shows up is a "NETDEV WATCHDOG: enP2p1s0f1 (nicvf): transmit queue 7 timed out"
>> warning.
>>
>> This patch remedies the problem by changing q_len to a u32.
>>
>> Signed-off-by: Dean Nelson <dnelson@redhat.com>
> 
> Applied, thanks.

Thank you!

> 
> Another way to solve this could have been to encode that length
> as "length - 1"

True. I had pondered that, but felt that since changing q_len's type
didn't add any length to the structure and that it was less impactful
from a number-of-lines of code changed perspective, I'd opt for this
route.

Cavium, if you'd prefer this goes the route that Dave just mentioned,
please let me know and I can make a new patch against what's been
applied?

Thanks,
Dean
