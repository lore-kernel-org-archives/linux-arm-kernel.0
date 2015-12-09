From: davem@davemloft.net (David Miller)
Date: Wed, 09 Dec 2015 15:26:22 -0500 (EST)
Subject: [PATCH 1/2] net: thunderx: HW TSO support for pass-2 hardware
In-Reply-To: <00b701d13279$d54d9c80$7fe8d580$@samsung.com>
References: <y@samsung.com>
 <1449661081-15435-2-git-send-email-sunil.kovvuri@gmail.com>
 <00b701d13279$d54d9c80$7fe8d580$@samsung.com>
Message-ID: <20151209.152622.589509558160050773.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Pavel Fedin <p.fedin@samsung.com>
Date: Wed, 09 Dec 2015 15:05:01 +0300

>  Hello!
> 
>> -----Original Message-----
>> From: netdev-owner at vger.kernel.org [mailto:netdev-owner at vger.kernel.org] On Behalf Of Sunil
>> Goutham
>> Sent: Wednesday, December 09, 2015 2:38 PM
>> To: netdev at vger.kernel.org
>> Cc: linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org; p.fedin at samsung.com;
>> Sunil.Goutham at caviumnetworks.com; Sunil Goutham
>> Subject: [PATCH 1/2] net: thunderx: HW TSO support for pass-2 hardware
>> 
>> From: Sunil Goutham <sgoutham@cavium.com>
>> 
>> This adds support for offloading TCP segmentation to HW in pass-2
>> revision of hardware. Both driver level SW TSO for pass1.x chips
>> and HW TSO for pass-2 chip will co-exist.
>> 
>> Signed-off-by: Sunil Goutham <sgoutham@cavium.com>
>> ---
>>  drivers/net/ethernet/cavium/thunder/nic.h          |   12 ++++++--
>>  drivers/net/ethernet/cavium/thunder/nic_main.c     |   11 ++-----
>>  drivers/net/ethernet/cavium/thunder/nicvf_main.c   |   15 ++++++++-
>>  drivers/net/ethernet/cavium/thunder/nicvf_queues.c |   20 ++++++++++---
>>  drivers/net/ethernet/cavium/thunder/q_struct.h     |   30 ++++++++++---------
>>  5 files changed, 56 insertions(+), 32 deletions(-)
>> 
>> diff --git a/drivers/net/ethernet/cavium/thunder/nic.h
>> b/drivers/net/ethernet/cavium/thunder/nic.h
>> index 39ca674..02571f4 100644
>> --- a/drivers/net/ethernet/cavium/thunder/nic.h
>> +++ b/drivers/net/ethernet/cavium/thunder/nic.h
>> @@ -262,9 +262,10 @@ struct nicvf {
>>  	struct pci_dev		*pdev;
>>  	u8			vf_id;
>>  	u8			node;
>> -	u8			tns_mode:1;
>> -	u8			sqs_mode:1;
>> -	u8			loopback_supported:1;
>> +	bool			tns_mode:1;
>> +	bool			sqs_mode:1;
> 
>  These little refactors are creeping in your code without even being mentioned in the commit message, this is not good practice
> IMHO. Additionally, may be turn these two flags into something like:

Also I disagree completely with boolean bitfields.  Just use plain 'bool' and let
the compiler decide how to lay it out.
