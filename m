From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 8 Oct 2014 09:27:06 +0100
Subject: FP register corruption in Exynos 4210 (Cortex-A9)
In-Reply-To: <5434F387.804@gmail.com>
References: <54345FA7.9030606@gmail.com>
 <20141007221515.GY5182@n2100.arm.linux.org.uk> <5434F387.804@gmail.com>
Message-ID: <20141008082705.GC5182@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 08, 2014 at 05:19:19AM -0300, Lanchon wrote:
>
> On 10/07/2014 07:44 PM, Russell King - ARM Linux wrote:
>> On Tue, Oct 07, 2014 at 07:35:14PM -0300, Lanchon wrote:
>>>> I hope this helps; I didn't answer your specific questions because it
>>>> seemed I would just end up repeating what I've said above.
>>>>
>>> actually no, answers to my very specific questions would help me
>>> understand this: if we had a close-source driver (ISR or kernel thread)
>>> that touched the FPU, how would the kernel react?
>> I already covered this.  It would corrupt the VFP state, thereby
>> corrupting the VFP state which userspace sees.
>>
>> Hence why I said:
>>
>> 	Which means that the kernel itself must /never/ make use of floating
>> 	point itself - if it does, it /will/ corrupt the user state in the way
>> 	               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> 	you are seeing.
>> 	^^^^^^^^^^^^^^^
>>
>> How can I make that more clear?
>
> no, actually you did not answer my questions. you stated that the end  
> result would be corruption of user FP state, which i already know. i am  
> inquiring as to *how* the process of corruption comes about exactly, not  
> the end result.

It is really /very/ simple.

1. ISR changes VFP registers.
2. Userspace sees changed VFP registers.
3. Userspace state is corrupted.

For some reason, you think that there's more going on here than that.
There isn't.  The kernel sees the very same set of registers as
userspace sees.  Any changes which the kernel makes to those registers
will be visible to userspace.

Hence, using VFP instructions in the kernel will result in VFP registers
changing.  Userspace will then see the changed VFP registers.  The
userspace state will then be corrupted.

Simple.  Really.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
