From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 6 Dec 2016 18:24:18 +0000
Subject: next-20161205 build: 3 failures 4 warnings (next-20161205)
In-Reply-To: <20161206181050.GF30492@tuxbot>
References: <E1cDo86-0008IX-9W@optimist>
 <20161205112043.pyzcbhtu7bklioas@sirena.org.uk>
 <7b3daf13-dbab-5acf-cd5f-2414141500b3@arm.com>
 <20161206181050.GF30492@tuxbot>
Message-ID: <ff2adb13-0a87-1a51-0f37-d665eb462ddd@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/12/16 18:10, Bjorn Andersson wrote:
> On Mon 05 Dec 07:44 PST 2016, Marc Zyngier wrote:
> 
>> On 05/12/16 11:20, Mark Brown wrote:
>>> On Mon, Dec 05, 2016 at 07:56:06AM +0000, Build bot for Mark Brown wrote:
>>>
>>> Today's -next fails to build an arm64 allnodconfig and allmodconfig
>>> with:
>>>
>>>> 	arm64-allnoconfig
>>>> ../arch/arm64/lib/clear_user.S:33: Error: bad or irreducible absolute expression
>>>> ../arch/arm64/lib/clear_user.S:53: Error: bad or irreducible absolute expression
>>>> ../arch/arm64/lib/clear_user.S:33: Error: attempt to move .org backwards
>>>> ../arch/arm64/lib/clear_user.S:53: Error: attempt to move .org backwards
>>>> ../arch/arm64/lib/copy_from_user.S:67: Error: bad or irreducible absolute expression
>>>> ../arch/arm64/lib/copy_from_user.S:70: Error: bad or irreducible absolute expression
>>>> ../arch/arm64/lib/copy_from_user.S:67: Error: attempt to move .org backwards
>>>> ../arch/arm64/lib/copy_from_user.S:70: Error: attempt to move .org backwards
>>>> ../arch/arm64/lib/copy_in_user.S:68: Error: bad or irreducible absolute expression
>>>> ../arch/arm64/lib/copy_in_user.S:71: Error: bad or irreducible absolute expression
>>>> ../arch/arm64/lib/copy_in_user.S:68: Error: attempt to move .org backwards
>>>> ../arch/arm64/lib/copy_in_user.S:71: Error: attempt to move .org backwards
>>>> ../arch/arm64/lib/copy_to_user.S:66: Error: bad or irreducible absolute expression
>>>> ../arch/arm64/lib/copy_to_user.S:69: Error: bad or irreducible absolute expression
>>>> ../arch/arm64/lib/copy_to_user.S:66: Error: attempt to move .org backwards
>>>> ../arch/arm64/lib/copy_to_user.S:69: Error: attempt to move .org backwards
>>>
>>> This was triggered somehow by bca8f17f57bd7 (arm64: Get rid of
>>> asm/opcodes.h) though I didn't figure out how.
>>
>> Old and broken gas. I have a workaround stashed there:
>>
>> http://git.kernel.org/cgit/linux/kernel/git/maz/arm-platforms.git/commit/?h=arm64/standalone.h&id=559f97365362ed9e96f594200020379df46630d8
>>
>> At least binutils 2.24 and 2.25 are affected, while 2.27 is not.
>>
> 
> Made me realize that the Ubuntu 15.10 release I'm on is deprecated.
> 
> If I read the release notes for Ubuntu correctly the 14.04 LTS release
> is supported until April 2019, with binutils 2.24. So I would be
> surprised if this won't bite quite a bunch of people down the road.

Catalin has taken a slightly different set of fixes which do address
this problem:

https://git.kernel.org/cgit/linux/kernel/git/arm64/linux.git/commit/?h=for-next/core&id=bbb56c27228d4ad64aca858c5af49d0f2f11c645
https://git.kernel.org/cgit/linux/kernel/git/arm64/linux.git/commit/?h=for-next/core&id=cd9e1927a525f6ce7c0d99c6e038f0a0b9e85176

The build system will warn you that your binutils are broken, and enable
the workaround (which will only result in slightly painful disassembly
for some instructions).

Some of the most visible distros have also other "features", such as
compilers that do not implement basic capabilities on which the kernel
relies for performance (jump labels, for example)...

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
