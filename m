From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 17 Apr 2015 16:40:43 +0200
Subject: [PATCH 0/2] crypto: add new driver for Marvell CESA
In-Reply-To: <20150417143216.GQ15807@lukather>
References: <20150410171148.07bc9429@bbrezillon>
 <20150410223008.GA18660@io.lakedaemon.net> <552B8EC4.209@free-electrons.com>
 <20150413124711.GI18660@io.lakedaemon.net> <87r3rom2qu.fsf@natisbad.org>
 <20150413201146.GL18660@io.lakedaemon.net>
 <20150417103356.6ce78145@bbrezillon> <20150417103946.2a46c243@bbrezillon>
 <5531040D.4000007@free-electrons.com> <20150417161922.54adec64@bbrezillon>
 <20150417143216.GQ15807@lukather>
Message-ID: <55311B6B.2090108@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On 17/04/2015 16:32, Maxime Ripard wrote:
> On Fri, Apr 17, 2015 at 04:19:22PM +0200, Boris Brezillon wrote:
>> Hi Gregory,
>>
>> On Fri, 17 Apr 2015 15:01:01 +0200
>> Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:
>>
>>> Hi Boris,
>>>
>>> On 17/04/2015 10:39, Boris Brezillon wrote:
>>>> On Fri, 17 Apr 2015 10:33:56 +0200
>>>> Boris Brezillon <boris.brezillon@free-electrons.com> wrote:
>>>>
>>>>> Hi Jason,
>>>>>
>>>>> On Mon, 13 Apr 2015 20:11:46 +0000
>>>>> Jason Cooper <jason@lakedaemon.net> wrote:
>>>>>
>>>>>>>
>>>>>>>> I'd appreciate if we'd look into it.  I understand from on-list and
>>>>>>>> off-list discussion that the rewrite was unavoidable.  So I'm willing to
>>>>>>>> concede that.  Giving people time to migrate from old to new while still
>>>>>>>> being able to update for other security fixes seems reasonable.
>>>>>>>
>>>>>>> Jason, what do you think of the approach above? 
>>>>>>
>>>>>> I say keep it simple.  We shouldn't use the DT changes to trigger one
>>>>>> vice the other.  We need to be able to build both, but only load one at
>>>>>> a time.  If that's anything other than simple to do, then we make it a
>>>>>> Kconfig binary choice and move on.
>>>>>
>>>>> Actually I was planning to handle it with a Kconfig dependency rule
>>>>> (NEW_DRIVER depends on !OLD_DRIVER and OLD_DRIVER depends
>>>>> on !NEW_DRIVER).
>>>>> I don't know how to make it a runtime check without adding new
>>>>> compatible strings for the kirkwood, dove and orion platforms, and I'm
>>>>> sure sure this is a good idea.
>>>>   ^ not
>>>>
>>>>> Do you have any ideas ?
>>>
>>> You use devm_ioremap_resource() in the new driver, so if the old one
>>> is already loaded the memory region will be already hold and the new
>>> driver will simply fail during the probe. So for this part it is OK.
>>
>> I like the idea :-).
> 
> Not really, how do you know which device is going to be probed? For
> that matter, it's pretty much random, and you have no control over it.
> 
> Why not just have a choice option, and select which one you want to
> enable?

Because you can't prevent an user to build a module, then modifying the
configuration and building the other module. So even if there is a choice at
build time, and I think that it is something expected for the v2, we still need
preventing having the both drivers trying accessing the same hardware in the
same time.


Thanks,

Gregory



> 
> Maxime
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
