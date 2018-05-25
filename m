From: julien.thierry@arm.com (Julien Thierry)
Date: Fri, 25 May 2018 14:42:29 +0100
Subject: [PATCH v4 00/26] arm64: provide pseudo NMI with GICv3
In-Reply-To: <02afa8bb-5d27-f229-6085-8f61a626bc63@arm.com>
References: <1527241772-48007-1-git-send-email-julien.thierry@arm.com>
 <20180525101632.cfcfnmnt2u7rz3lt@holly.lan>
 <02afa8bb-5d27-f229-6085-8f61a626bc63@arm.com>
Message-ID: <8703b3e0-b5f8-e607-2d8f-3d0b71a5ec3c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 25/05/18 11:40, Julien Thierry wrote:
> 
> 
> On 25/05/18 11:16, Daniel Thompson wrote:
>> On Fri, May 25, 2018 at 10:49:06AM +0100, Julien Thierry wrote:
>>> This series is a continuation of the work started by Daniel [1]. The 
>>> goal
>>> is to use GICv3 interrupt priorities to simulate an NMI.
>>>
>>> To achieve this, set two priorities, one for standard interrupts and
>>> another, higher priority, for NMIs. Whenever we want to disable 
>>> interrupts,
>>> we mask the standard priority instead so NMIs can still be raised. Some
>>> corner cases though still require to actually mask all interrupts
>>> effectively disabling the NMI.
>>>
>>> Currently, only PPIs and SPIs can be set as NMIs. IPIs being currently
>>> hardcoded IRQ numbers, there isn't a generic interface to set SGIs as 
>>> NMI
>>> for now. I don't think there is any reason LPIs should be allowed to 
>>> be set
>>> as NMI as they do not have an active state.
>>> When an NMI is active on a CPU, no other NMI can be triggered on the 
>>> CPU.
>>>
>>> After the big refactoring I get performances similar to the ones I had
>>> in v3[2], reposting old results here:
>>>
>>> - "hackbench 200 process 1000" (average over 20 runs)
>>> +-----------+----------+------------+------------------+
>>> |?????????? | native?? | PMR guest? | v4.17-rc6 guest? |
>>> +-----------+----------+------------+------------------+
>>> | PMR host? | 40.0336s |?? 39.3039s |???????? 39.2044s |
>>> | v4.17-rc6 | 40.4040s |?? 39.6011s |???????? 39.1147s |
>>> +-----------+----------+------------+------------------+
>>>
>>> - Kernel build from defconfig:
>>> PMR host:? 13m45.743s
>>> v4.17-rc6: 13m40.400s
>>>
>>> I'll try to post more detailed benchmarks later if I find notable
>>> differences with the previous version.
>>
>> Do you have a public git tree anywhere... I *can* apply 26 patches from
>> e-mail but I'd rather pull them!
>>
> 
> Yes that makes sense, I'll try to get one set up.
> 
> I'll let you know once I have done so.

My public git is up. You can pull the patches from:

git://linux-arm.org/linux-jt.git v4.17-pseudo-nmi

Cheers,

-- 
Julien Thierry
