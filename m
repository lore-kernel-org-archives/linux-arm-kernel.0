From: robherring2@gmail.com (Rob Herring)
Date: Thu, 24 Jan 2013 11:27:25 -0600
Subject: OMAP4 randconfig failure: Zynq
In-Reply-To: <20130124170803.GA1036@beefymiracle.amer.corp.natinst.com>
References: <20130124111117.GU23505@n2100.arm.linux.org.uk>
 <20130124155704.GJ11970@beefymiracle.amer.corp.natinst.com>
 <20130124160609.GW23505@n2100.arm.linux.org.uk>
 <20130124161211.GX23505@n2100.arm.linux.org.uk>
 <20130124170803.GA1036@beefymiracle.amer.corp.natinst.com>
Message-ID: <51016EFD.3060101@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/24/2013 11:08 AM, Josh Cartwright wrote:
> On Thu, Jan 24, 2013 at 04:12:11PM +0000, Russell King - ARM Linux wrote:
>> On Thu, Jan 24, 2013 at 04:06:09PM +0000, Russell King - ARM Linux wrote:
>>> On Thu, Jan 24, 2013 at 09:57:04AM -0600, Josh Cartwright wrote:
>>>> On Thu, Jan 24, 2013 at 11:11:17AM +0000, Russell King - ARM Linux wrote:
>>>>> The OMAP4 randconfig build last night failed with this error:
>>>>>
>>>>> arch/arm/mach-zynq/common.c:99:14: error: 'irqchip_init' undeclared here (not in a function)
>>>>>
>>>>> Full details at the usual place - 
>>>>> http://www.arm.linux.org.uk/developer/build/
>>>>
>>>> Curious.  This doesn't look like a valid config to me.
>>>
>>> I think you're wrong.
> 
> Yes, indeed.  I was running my tests using the wrong tree.  I can see
> this issue in today's linux-next.  Sorry for the noise.
> 
> [..]
>>
>> And what's missing is _specific_ to Zynq.  Let's look at the error again:
>>
>> arch/arm/mach-zynq/common.c:99:14: error: 'irqchip_init' undeclared here (not in a function)
>>
>> What it means is that the "irqchip_init" identifier was not declared by
>> anything before it has been used.  That means arch/arm/mach-zynq/common.c
>> is missing a required #include statement.
>>
>> irqchip_init can be found in linux/irqchip.h.  Does arch/arm/mach-zynq/common.c
>> include this required include?  No.  Therefore, the build fails with the
>> above error.
>>
>> You need to add this include file...
> 
> Agreed, thanks.  Looks like this was introduced with "ARM: use common
> irqchip_init for GIC init".  Here's a patch to fix it up, it probably
> makes sense to be pulled into Rob's irqchip/gic-vic-move branch.

Can you also add zynq to multi_v7_defconfig if that is not already
queued up.

Rob
