From: andrii.tseglytskyi@ti.com (Andrii Tseglytskyi)
Date: Mon, 15 Apr 2013 19:21:25 +0300
Subject: [RFC v1] regulator: core: introduce regulator chain locking scheme
In-Reply-To: <20130415155040.GD15837@opensource.wolfsonmicro.com>
References: <1366031015-17073-1-git-send-email-grygorii.strashko@ti.com>
 <1366031015-17073-2-git-send-email-grygorii.strashko@ti.com>
 <20130415155040.GD15837@opensource.wolfsonmicro.com>
Message-ID: <516C2905.8000200@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 04/15/2013 06:50 PM, Mark Brown wrote:
>> In addition, such locking scheme allows to have access to the supplier
>> regulator API from inside child's (consumer) regulator API.
> I've still not seen any use case articulated for doing this...
Use case is introduced in ABB series:

http://www.mail-archive.com/linux-omap at vger.kernel.org/msg88293.html

During voltage scaling we would like to have the following sequence:

cpufreq_cpu0
     |
     |---> set_voltage(ABB)
                 |
                 |->set_voltage(AVS)
                         |
                         |-->set_voltage(smps123)


Where smps123 is a regulator, connected ot i2c bus. In this particular 
case "regulator chain" guarantees proper order of calls of voltage 
scaling sequence.

Regards,
Andrii
