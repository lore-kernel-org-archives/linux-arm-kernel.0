From: bjorn@mork.no (=?utf-8?Q?Bj=C3=B8rn_Mork?=)
Date: Thu, 22 Nov 2012 09:55:30 +0100
Subject: [PATCH 1/1] asix: use ramdom hw addr if the one read is not valid
In-Reply-To: <50AD36A8.6000702@mvista.com> (Sergei Shtylyov's message of "Wed,
 21 Nov 2012 23:16:40 +0300")
References: <1353493362-30418-1-git-send-email-plagnioj@jcrosoft.com>
 <50AD36A8.6000702@mvista.com>
Message-ID: <878v9uow3h.fsf@nemi.mork.no>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sergei Shtylyov <sshtylyov@mvista.com> writes:
> On 11/21/2012 01:22 PM, Jean-Christophe PLAGNIOL-VILLARD wrote:
>
>> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
>> Cc: linux-usb at vger.kernel.org
>> Cc: netdev at vger.kernel.org
>> ---
>>  drivers/net/usb/asix_devices.c |   24 +++++++++++++++++++++---
>>  1 file changed, 21 insertions(+), 3 deletions(-)
>
>> diff --git a/drivers/net/usb/asix_devices.c b/drivers/net/usb/asix_devices.c
>> index 33ab824..7ebec5b 100644
>> --- a/drivers/net/usb/asix_devices.c
>> +++ b/drivers/net/usb/asix_devices.c
>> @@ -225,7 +225,13 @@ static int ax88172_bind(struct usbnet *dev, struct usb_interface *intf)
>>  			   ret);
>>  		goto out;
>>  	}
>> -	memcpy(dev->net->dev_addr, buf, ETH_ALEN);
>> +
>> +	if (is_valid_ether_addr(buf)) {
>> +		memcpy(dev->net->dev_addr, buf, ETH_ALEN);
>> +	} else {
>> +		netdev_info(dev->net, "invalid hw address, using random\n");
>> +		eth_hw_addr_random(dev->net);
>> +	}
>>  
>>  	/* Initialize MII structure */
>>  	dev->mii.dev = dev->net;
[..]
>
>    Repeated thrice, this asks to be put into subroutine...

Yes.  Looking at the driver, this probably goes for most of the three
_bind() functions.  There is a lot of common code there.

But more important wrt the eth_hw_addr_random() change: Does this
actually work with real devices?  The driver implements a
asix_set_mac_address() which writes the address back to the device when
you change it.  I assume there is a reason for doing that.  Why don't
you do it here?


Bj?rn
