From: nm@ti.com (Nishanth Menon)
Date: Tue, 6 May 2014 14:46:10 -0500
Subject: [PATCH V5 1/3] arm: dts: dra7: Add crossbar device binding
In-Reply-To: <20140506194055.GA6962@saruman.home>
References: <1399384579-25620-1-git-send-email-r.sricharan@ti.com>
 <1399384579-25620-2-git-send-email-r.sricharan@ti.com>
 <20140506194055.GA6962@saruman.home>
Message-ID: <53693C02.2090305@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/06/2014 02:40 PM, Felipe Balbi wrote:
> On Tue, May 06, 2014 at 07:26:17PM +0530, Sricharan R wrote:
>> This adds the irq crossbar device node.
>>
>> There is a IRQ crossbar device in the soc, which
>> maps the irq requests from the peripherals to the
>> mpu interrupt controller's inputs. The Peripheral irq
>> requests are connected to only one crossbar
>> input and the output of the crossbar is connected to only one
>> controller's input line. The crossbar device is used to map
>> a peripheral input to a free mpu's interrupt controller line.
>>
>> Cc: Benoit Cousson <bcousson@baylibre.com>
>> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> Cc: Rajendra Nayak <rnayak@ti.com>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Signed-off-by: Sricharan R <r.sricharan@ti.com>
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>> ---
>> [V5] Rebased on top of 3.15-rc4 and corrected the
>>      irqs-reserved list
>>
>>  arch/arm/boot/dts/dra7.dtsi |    8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
>> index 149b550..0274a86 100644
>> --- a/arch/arm/boot/dts/dra7.dtsi
>> +++ b/arch/arm/boot/dts/dra7.dtsi
>> @@ -790,6 +790,14 @@
>>  			status = "disabled";
>>  		};
>>  	};
>> +
>> +	crossbar_mpu: crossbar at 4a020000 {
> 
> shouldn't this be "status = disabled"; so that boards enable this
> on-demand ??
> 
It cannot be and does not need to be. crossbar is an SoC feature. by
defining crossbar, the IRQ numbers we provide in DTS now becomes
crossbar numbers which get mapped to GIC interrupt numbers dynamically.

further crossbar is not a board feature. it is as ingrained in DRA7
behavior as GIC is. we are fortunate that we have some default mapping
of crossbar that allows the current peripherals to work, with this
support, we dont have to depend any longer on "we are lucky that is
mapped".

That said, in hindsight, patch #1 and 2 should be squashed IMHO. else
we have a bisectability problem here.

-- 
Regards,
Nishanth Menon
