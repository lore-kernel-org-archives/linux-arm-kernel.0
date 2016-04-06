From: davem@davemloft.net (David Miller)
Date: Wed, 06 Apr 2016 17:20:08 -0400 (EDT)
Subject: [PATCH net-next V3 05/16] net: fec: reduce interrupts
In-Reply-To: <1459909562-22865-6-git-send-email-troy.kisky@boundarydevices.com>
References: <1459909562-22865-1-git-send-email-troy.kisky@boundarydevices.com>
 <1459909562-22865-6-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <20160406.172008.266926707628676037.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Troy Kisky <troy.kisky@boundarydevices.com>
Date: Tue,  5 Apr 2016 19:25:51 -0700

> By clearing the NAPI interrupts in the NAPI routine
> and not in the interrupt handler, we can reduce the
> number of interrupts. We also don't need any status
> variables as the registers are still valid.
> 
> Also, notice that if budget pkts are received, the
> next call to fec_enet_rx_napi will now continue to
> receive the previously pending packets.
> 
> To test that this actually reduces interrupts, try
> this command before/after patch
> 
> cat /proc/interrupts |grep ether; \
> ping -s2800 192.168.0.201 -f -c1000 ; \
> cat /proc/interrupts |grep ether
> 
> For me, before this patch is 2996 interrupts.
> After patch is 2010 interrupts.
> 
> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>

I really don't think this is a good idea at all.

I would instead really rather see you stash away the
status register values into some piece of software state,
and then re-read them before you are about to finish a
NAPI poll cycle.
