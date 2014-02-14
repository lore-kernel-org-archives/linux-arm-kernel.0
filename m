From: ivo.g.dimitrov.75@gmail.com (Ivaylo Dimitrov)
Date: Fri, 14 Feb 2014 19:11:27 +0200
Subject: [BISECTED] ssh - Received disconnect from x.x.x.x: 2: Bad packet
 length 3149594624
In-Reply-To: <20140214162458.GF21986@mudshark.cambridge.arm.com>
References: <52FD08D1.3030405@gmail.com>
 <20140213182105.GN13576@mudshark.cambridge.arm.com>
 <52FD1243.9040706@gmail.com>
 <20140213192909.GO13576@mudshark.cambridge.arm.com>
 <52FE407C.3080002@gmail.com>
 <20140214162458.GF21986@mudshark.cambridge.arm.com>
Message-ID: <52FE4E3F.6020407@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 14.02.2014 18:24, Will Deacon wrote:
>
> You could try putting back the UNALIGNED_ACCESS in net/mac80211/rx.c and
> commenting out the skb->len = desc->length  - PLCP_HEADER_LENGTH;  line
> above.

This seems to fix the issue too, but I am afraid there is more to be 
done, as I see

Feb 14 18:33:46 Nokia-N900 kernel: [   88.599853] wlan0: authenticate 
with 00:23:cd:17:86:d0
Feb 14 18:33:46 Nokia-N900 kernel: [   88.781860] wlan0: send auth to 
00:23:cd:17:86:d0 (try 1/3)
Feb 14 18:33:46 Nokia-N900 kernel: [   88.799804] wlan0: authenticated
Feb 14 18:33:46 Nokia-N900 kernel: [   88.806243] wlan0: associating 
with AP with corrupt probe response
Feb 14 18:33:46 Nokia-N900 kernel: [   88.814544] wlan0: associate with 
00:23:cd:17:86:d0 (try 1/3)
Feb 14 18:33:46 Nokia-N900 kernel: [   88.826416] wlan0: RX AssocResp 
from 00:23:cd:17:86:d0 (capab=0x431 status=0 aid=2)

spit in dmesg log. AFAIR this is the first time I see "associating with 
AP with corrupt probe response" in dmesg, no matter of the kernel 
version. Despite of that error message, wlan seems to work as it should, 
so far. I guess we need the driver's author saying on the issue.

Thanks,
Ivo
