From: davem@davemloft.net (David Miller)
Date: Mon, 26 Jan 2015 14:34:02 -0800 (PST)
Subject: [PATCH] drivers: net: xgene: fix: Out of order descriptor
 bytes read
In-Reply-To: <CAKh23FmxvV82mVrHq5jv-FE+e6u6CkW+xL_a2_ULAQgP_mM2VA@mail.gmail.com>
References: <1421957007-720-1-git-send-email-isubramanian@apm.com>
 <1421967050.3471.14.camel@edumazet-glaptop2.roam.corp.google.com>
 <CAKh23FmxvV82mVrHq5jv-FE+e6u6CkW+xL_a2_ULAQgP_mM2VA@mail.gmail.com>
Message-ID: <20150126.143402.1309886104452878553.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Iyappan Subramanian <isubramanian@apm.com>
Date: Mon, 26 Jan 2015 13:12:23 -0800

>>> @@ -369,6 +369,8 @@ static int xgene_enet_process_ring(struct xgene_enet_desc_ring *ring,
>>>               if (unlikely(xgene_enet_is_desc_slot_empty(raw_desc)))
>>>                       break;
>>>
>>> +             /* read fpqnum field after dataaddr field */
>>> +             smp_rmb();
>>>               if (is_rx_desc(raw_desc))
>>>                       ret = xgene_enet_rx_frame(ring, raw_desc);
>>>               else
>>
>> Reading your changelog, it looks like you need a plain rmb() here.
> 
> rmb() translates into dsb, which in arm64 serializes everything
> including instructions and thus expensive compared to dmb.
> 
> Do you see any issue with smp_rmb() (which translates into dmb) ?

smp_rmb() is not appropriate.  You're not serializing accesses between
two cpus, you're serializing the cpu with the device.
