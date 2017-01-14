From: guohanjun@huawei.com (Hanjun Guo)
Date: Sat, 14 Jan 2017 10:56:54 +0800
Subject: [PATCH v7 15/15] irqchip: mbigen: Add ACPI support
In-Reply-To: <20170113102104.GB20837@red-moon>
References: <1484147199-4267-1-git-send-email-hanjun.guo@linaro.org>
 <1484147199-4267-16-git-send-email-hanjun.guo@linaro.org>
 <20170113102104.GB20837@red-moon>
Message-ID: <58799376.6040302@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lorenzo,

On 2017/1/13 18:21, Lorenzo Pieralisi wrote:
> On Wed, Jan 11, 2017 at 11:06:39PM +0800, Hanjun Guo wrote:
>> With the preparation of platform msi support and interrupt producer
>> in DSDT, we can add mbigen ACPI support now.
>>
>> We are using _PRS methd to indicate number of irq pins instead
>> of num_pins in DT to avoid _DSD usage in this case.
>>
>> For mbi-gen,
>>     Device(MBI0) {
>>           Name(_HID, "HISI0152")
>>           Name(_UID, Zero)
>>           Name(_CRS, ResourceTemplate() {
>>                   Memory32Fixed(ReadWrite, 0xa0080000, 0x10000)
>>           })
>>
>>           Name (_PRS, ResourceTemplate() {
>> 		  Interrupt(ResourceProducer,...) {12,14,....}
> I still do not understand why you are using _PRS for this, I think
> the MBIgen configuration is static and if it is so the Interrupt
> resource should be part of the _CRS unless there is something I am
> missing here.

Sorry for not clear in the commit message. MBIgen is an interrupt producer
which produces irq resource to devices connecting to it, and MBIgen itself
don't consume wired interrupts.

Also devices connecting MBIgen may not consume all the interrupts produced
by MBIgen, for example, MBIgen may produce 128 interrupts but only half of
them are currently used, so _PRS here means "provide interrupt resources
may consumed by devices connecting to it".

Should I add this into the commit message?

Thanks
Hanjun
