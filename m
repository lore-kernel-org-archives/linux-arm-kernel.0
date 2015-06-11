From: gerg@uclinux.org (Greg Ungerer)
Date: Thu, 11 Jun 2015 14:04:18 +1000
Subject: [PATCH] ARM: mvebu: pass the coherency availability information
 at init time
In-Reply-To: <20150611034521.GA12809@kroah.com>
References: <1433992764-12753-1-git-send-email-gerg@uclinux.org>
 <20150611034521.GA12809@kroah.com>
Message-ID: <557908C2.4090302@uclinux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/06/15 13:45, Greg KH wrote:
> On Thu, Jun 11, 2015 at 01:19:24PM +1000, gerg at uclinux.org wrote:
>> From: Greg Ungerer <gerg@uclinux.org>
>>
>> This patch is specifically meant to be applied to stable tree linux-3.10.y.
> 
> Why?  What's wrong with taking the exact specific upstream patches
> instead?

The exact patch mentioned below ("5686a1e5aa4") will not apply.
Too much of the code around it has changed. This does the same
thing in the same away taking into account the changes around it.


> Your descriptions here:
> 
>> IO coherency should not be used on the Armada 370 SoC, due to all
>> the necessary pre-requisites for reliable operation not being met
>> (such as write allocate cache policy, shareable pages, SMP bit set).
>>
>> Commit e55355453600a33bb5ca4f71f2d7214875f3b061 ("ARM: mvebu: disable
>> I/O coherency on non-SMP situations on Armada 370/375/38x/XP") was
>> intended to disable IO coherency for the Armada 370. However it only
>> disables the CPU side IO coherency. The mbus driver (drivers/bus/
>> mvebu-mbus.c) still passes the IO coherency attributes through the
>> dram chip selects and onto driver memory window attributes. It
>> does this based on looking directly into the device tree (looking
>> for "marvell,coherency-fabric").
>>
>> To fix we pass the coherency availability information (whether enabled
>> or not) to the mbus driver at init time. This is done in the same way
>> that it was done for mainline kernels in commit
>> 5686a1e5aa436c49187a60052d5885fb1f541ce6 ("bus: mvebu: pass the
>> coherency availability information at init time").
>>
>> Having the IO coherency enabled on the Armada 370 SoC causes rare
>> unreliable system behavior. It is not easy to consistently reproduce
>> problems caused by this. Best method I have seen is heavy network
>> load resulting in kernel dumps due to corrupted memory.
> 
> I don't understand the issue here, I really don't want to not take
> patches that are not in Linus's tree, sorry.

Sure.

Regards
Greg
