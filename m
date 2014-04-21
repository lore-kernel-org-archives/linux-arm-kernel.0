From: nm@ti.com (Nishanth Menon)
Date: Mon, 21 Apr 2014 08:16:28 -0500
Subject: [PATCH V2 05/19] bus: omap_l3_noc: switch over to relaxed variants
 of readl/writel
In-Reply-To: <20140417220329.GF8504@saruman.home>
References: <1397492726-17203-1-git-send-email-nm@ti.com>
 <1397767775-10965-1-git-send-email-nm@ti.com>
 <1397767775-10965-6-git-send-email-nm@ti.com>
 <20140417215228.GD8504@saruman.home> <53504DFF.7090907@ti.com>
 <20140417220329.GF8504@saruman.home>
Message-ID: <53551A2C.8060404@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/17/2014 05:03 PM, Felipe Balbi wrote:
> On Thu, Apr 17, 2014 at 05:56:15PM -0400, Santosh Shilimkar wrote:
>> On Thursday 17 April 2014 05:52 PM, Felipe Balbi wrote:
>>> Hi,
>>>
>>> On Thu, Apr 17, 2014 at 03:49:21PM -0500, Nishanth Menon wrote:
>>>> Currently we use __raw_readl and writel in this driver, however, there
>>>
>>> __raw_* and *_relaxed variants are the same, just have a look <asm/io.h>
>>>
>> Except the relaxed version can take care of endian conversion if
>> needed. :-)
> 
> right, but according to commit log, this commit is more concerned about
> the memory barriers which writel()/readl() add, not endianness. Just a
> matter of fixing up commit log.
> 

yep, this patch does replace writel with writel_relaxed there is no
strong need for barriers in the operations that we perform here.

I agree that the commit message should probably be a little more
detailed at this point.


How about:
Currently we use __raw_readl and writel in this driver. Considering
there is no specific need for a memory barrier, replacing writel with
endian-neutral writel_relaxed and replacing __raw_readls with the
corresponding endian-neutral readl_relaxed allows us to have a
standard set of register operations for the driver.

While at it, simplify address computation using variables for register.


-- 
Regards,
Nishanth Menon
