From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Wed, 6 Apr 2016 17:42:47 -0700
Subject: [PATCH net-next V3 05/16] net: fec: reduce interrupts
In-Reply-To: <20160406.172008.266926707628676037.davem@davemloft.net>
References: <1459909562-22865-1-git-send-email-troy.kisky@boundarydevices.com>
 <1459909562-22865-6-git-send-email-troy.kisky@boundarydevices.com>
 <20160406.172008.266926707628676037.davem@davemloft.net>
Message-ID: <5705AD07.10009@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/6/2016 2:20 PM, David Miller wrote:
> From: Troy Kisky <troy.kisky@boundarydevices.com>
> Date: Tue,  5 Apr 2016 19:25:51 -0700
> 
>> By clearing the NAPI interrupts in the NAPI routine
>> and not in the interrupt handler, we can reduce the
>> number of interrupts. We also don't need any status
>> variables as the registers are still valid.
>>
>> Also, notice that if budget pkts are received, the
>> next call to fec_enet_rx_napi will now continue to
>> receive the previously pending packets.
>>
>> To test that this actually reduces interrupts, try
>> this command before/after patch
>>
>> cat /proc/interrupts |grep ether; \
>> ping -s2800 192.168.0.201 -f -c1000 ; \
>> cat /proc/interrupts |grep ether
>>
>> For me, before this patch is 2996 interrupts.
>> After patch is 2010 interrupts.
>>
>> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
> 
> I really don't think this is a good idea at all.
> 
> I would instead really rather see you stash away the
> status register values into some piece of software state,
> and then re-read them before you are about to finish a
> NAPI poll cycle.
> 
> 

Sure, that's an easy change. But if a TX int is what caused the interrupt
and masks them, and then a RX packet happens before napi runs, do you want
the TX serviced 1st, or RX ?
