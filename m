From: yegor_sub1@visionsystems.de (Yegor Yefremov)
Date: Mon, 22 Feb 2010 16:47:58 +0100
Subject: [PATCH][KS8695] Mark network interface as running on ifconfig up
In-Reply-To: <20100216.160647.208330407.davem@davemloft.net>
References: <4B73E62B.3030305@visionsystems.de>
	<20100216.160647.208330407.davem@davemloft.net>
Message-ID: <4B82A72E.50508@visionsystems.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

David Miller schrieb:
> From: Yegor Yefremov <yegor_sub1@visionsystems.de>
> Date: Thu, 11 Feb 2010 12:12:43 +0100
> 
>> [KS8695] Mark network interface as running on ifconfig up
>>
>> Without netif_carrier_on() network interface will not transmit any packets
>> after ifconfig down and subsequent ifconfig up.
>>
>> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
>>
>> Index: linux-2.6.33-rc7/drivers/net/arm/ks8695net.c
>> ===================================================================
>> --- linux-2.6.33-rc7.orig/drivers/net/arm/ks8695net.c
>> +++ linux-2.6.33-rc7/drivers/net/arm/ks8695net.c
>> @@ -1371,6 +1371,7 @@ ks8695_open(struct net_device *ndev)
>>  
>>  	napi_enable(&ksp->napi);
>>  	netif_start_queue(ndev);
>> +	netif_carrier_on(ndev);
>>  
>>  	return 0;
>>  }
>>
> 
> Only ks8695_link_irq() should be setting the carrier state.
> 
> If necessary, reset the PHY on device open so that the link up
> interrupt arrives and the code handling that event can set the carrier
> status properly.
> 
> This is how every other driver handles this situation.

According to this guideline is it also wrong to call netif_carrier_on(ndev) within ndo_stop() routine? I removed this call and the ifconfig up/down is functioning properly. So the resulting patch could look like this:


[KS8695] Don't call netif_carrier_off() from ndo_stop()

netif_carrier_on() and netif_carrier_off() should be called from
link status interrupt handler

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>

Index: linux-2.6.33-rc7/drivers/net/arm/ks8695net.c
===================================================================
--- linux-2.6.33-rc7.orig/drivers/net/arm/ks8695net.c
+++ linux-2.6.33-rc7/drivers/net/arm/ks8695net.c
@@ -1335,7 +1335,6 @@ ks8695_stop(struct net_device *ndev)
 
 	netif_stop_queue(ndev);
 	napi_disable(&ksp->napi);
-	netif_carrier_off(ndev);
 
 	ks8695_shutdown(ksp);
 
