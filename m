From: jc@eclis.ch (Jean-Christian de Rivaz)
Date: Wed, 30 Sep 2015 12:13:33 +0200
Subject: [PATCH 1/1] Disable CONFIG_UACCESS_WITH_MEMCPY in Atmel config.
In-Reply-To: <20150930061002.GI3982@pengutronix.de>
References: <1443565968-7012-1-git-send-email-jc@eclis.ch>
 <20150930061002.GI3982@pengutronix.de>
Message-ID: <560BB5CD.1040908@eclis.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 30. 09. 15 08:10, Uwe Kleine-K?nig a ?crit :
> Hello,
>
> On Wed, Sep 30, 2015 at 12:32:48AM +0200, jc at eclis.ch wrote:
>> From: Jean-Christian de Rivaz <jc@eclis.ch>
>>
>> According to Russell King:
>> In any case, unless you have a Marvell platform, you should have this
>> disabled - it provides a performance boost for Marvell platforms, but
>> degrades performance everywhere else.  Please ensure that you disable
>> CONFIG_UACCESS_WITH_MEMCPY.
>>
>> Signed-off-by: Jean-Christian de Rivaz <jc@eclis.ch>
> the change is fine now. Feel free to add my Ack also if you do another
> round to improve the changelog.
>
> Best regards
> Uwe
>

Thanks Uwe,

Nicolas and Russell, for my own curiosity I tested the difference on 
this system:

# cat /proc/cpuinfo
processor    : 0
model name    : ARMv7 Processor rev 1 (v7l)
BogoMIPS    : 348.97
Features    : half thumb fastmult vfp edsp vfpv3 vfpv3d16 tls vfpv4
CPU implementer    : 0x41
CPU architecture: 7
CPU variant    : 0x0
CPU part    : 0xc05
CPU revision    : 1

Hardware    : Atmel SAMA5
Revision    : 0000
Serial        : 0000000000000000

# dd if=/dev/zero of=/dev/null bs=4k count=1M

Take about 10 seconds to complete on this system and report the 
following speed in MB/s in 10 rounds:

CONFIG_UACCESS_WITH_MEMCPY=y
470, 419, 440, 446, 434, 437, 418, 412, 431, 437

# CONFIG_UACCESS_WITH_MEMCPY disabled is not set
387, 387, 382, 383, 385, 388, 387, 387, 384, 386

So It look like this feature still give some advantage on system other 
than Orion CPU core. I still propose my patch to disable it until it's 
rock stable as it used to be a least with the kernel 3.19.0.

Regards,
Jean-Christian
