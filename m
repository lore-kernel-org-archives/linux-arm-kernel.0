From: okaya@codeaurora.org (Sinan Kaya)
Date: Fri, 13 Apr 2018 12:36:33 -0400
Subject: [PATCH v3 2/2] MIPS: io: add a barrier after register read in
 readX()
In-Reply-To: <e38a329dfb9c461ab3e91de7b96db3dc@AcuMS.aculab.com>
References: <1522760109-16497-1-git-send-email-okaya@codeaurora.org>
 <1522760109-16497-2-git-send-email-okaya@codeaurora.org>
 <20180412215149.GA27802@saruman>
 <e38a329dfb9c461ab3e91de7b96db3dc@AcuMS.aculab.com>
Message-ID: <3688d54c-85f3-6eba-7f13-1cef0a0b5d85@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/13/2018 11:41 AM, David Laight wrote:
> From: James Hogan
>> Sent: 12 April 2018 22:52
>> On Tue, Apr 03, 2018 at 08:55:04AM -0400, Sinan Kaya wrote:
>>> While a barrier is present in writeX() function before the register write,
>>> a similar barrier is missing in the readX() function after the register
>>> read. This could allow memory accesses following readX() to observe
>>> stale data.
>>>
>>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>>> Reported-by: Arnd Bergmann <arnd@arndb.de>
>>
>> Both patches look like obvious improvements to me, so I'm happy to apply
>> to my fixes branch.
> 
> Don't you also need at least barrier() between the register write in writeX()
> and the register read in readX()?
> On ppc you probably need eieio.
> Or are drivers expected to insert that one?
> If they need to insert that one then why not all the others??
> 

Good question. The volatile in here should prevent compiler from reordering the
register read or write instructions. 

static inline type pfx##read##bwlq(const volatile void __iomem *mem)

This is the solution all other architectures rely on especially via
__raw_readX() and __raw_writeX() API.

Now, things can get reordered when it leaves the CPU. This is guaranteed by
embedding wmb() and rmb() into the writeX() and readX() functions in other
architectures.

This ordering guarantee has been agreed to be the responsibility of the
architecture not drivers.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
