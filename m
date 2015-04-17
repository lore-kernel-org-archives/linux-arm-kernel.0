From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 17 Apr 2015 15:01:01 +0200
Subject: [PATCH 0/2] crypto: add new driver for Marvell CESA
In-Reply-To: <20150417103946.2a46c243@bbrezillon>
References: <1428591523-1780-1-git-send-email-boris.brezillon@free-electrons.com>	<20150410135056.GB28873@io.lakedaemon.net>	<20150410171148.07bc9429@bbrezillon>	<20150410223008.GA18660@io.lakedaemon.net>	<552B8EC4.209@free-electrons.com>	<20150413124711.GI18660@io.lakedaemon.net>	<87r3rom2qu.fsf@natisbad.org>	<20150413201146.GL18660@io.lakedaemon.net>	<20150417103356.6ce78145@bbrezillon>
 <20150417103946.2a46c243@bbrezillon>
Message-ID: <5531040D.4000007@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

On 17/04/2015 10:39, Boris Brezillon wrote:
> On Fri, 17 Apr 2015 10:33:56 +0200
> Boris Brezillon <boris.brezillon@free-electrons.com> wrote:
> 
>> Hi Jason,
>>
>> On Mon, 13 Apr 2015 20:11:46 +0000
>> Jason Cooper <jason@lakedaemon.net> wrote:
>>
>>>>
>>>>> I'd appreciate if we'd look into it.  I understand from on-list and
>>>>> off-list discussion that the rewrite was unavoidable.  So I'm willing to
>>>>> concede that.  Giving people time to migrate from old to new while still
>>>>> being able to update for other security fixes seems reasonable.
>>>>
>>>> Jason, what do you think of the approach above? 
>>>
>>> I say keep it simple.  We shouldn't use the DT changes to trigger one
>>> vice the other.  We need to be able to build both, but only load one at
>>> a time.  If that's anything other than simple to do, then we make it a
>>> Kconfig binary choice and move on.
>>
>> Actually I was planning to handle it with a Kconfig dependency rule
>> (NEW_DRIVER depends on !OLD_DRIVER and OLD_DRIVER depends
>> on !NEW_DRIVER).
>> I don't know how to make it a runtime check without adding new
>> compatible strings for the kirkwood, dove and orion platforms, and I'm
>> sure sure this is a good idea.
>   ^ not
> 
>> Do you have any ideas ?

You use devm_ioremap_resource() in the new driver, so if the old one
is already loaded the memory region will be already hold and the new
driver will simply fail during the probe. So for this part it is OK.

However, the old driver doesn't try to reserve the region, it directly
uses an ioremap(). So if the new driver is loaded first, then the old
one will manage to be loaded too. I think that just adding a
request_region()/release_region() (or converting the ioremap in a
devm_ioremap_resource() in the old driver would be enough.


Gregory



-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
