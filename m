From: robherring2@gmail.com (Rob Herring)
Date: Wed, 27 Jun 2012 07:54:11 -0500
Subject: [PATCH v3 0/4] DT clock bindings
In-Reply-To: <20120621175443.GL4402@gmail.com>
References: <1339512111-11172-1-git-send-email-robherring2@gmail.com>
 <87bokd15x7.fsf@octavius.laptop.org> <4FE33723.3040403@gmail.com>
 <20120621175443.GL4402@gmail.com>
Message-ID: <4FEB0273.9050707@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/21/2012 12:54 PM, Mike Turquette wrote:
> On 20120621-10:00, Rob Herring wrote:
>> On 06/21/2012 02:27 AM, Chris Ball wrote:
>>>
>>> 2) Use alloc_bootmem() instead of kzalloc() in of_clk_add_provider(),
>>>    because we need to set up clocks during .init_early on ARM (which
>>>    happens pre-slab) so that they are available for platform init.
>>
>> This depends on 1 as the common clock code would have the same issue.
>> Generally, the first place clocks are needed is the timer init. At that
>> point, you can call kzalloc. This is where all the clock init used to be
>> done until init_early was added and some platforms have moved their
>> clock init. I don't think there was really ever much reason to move it
>> other than to make the timer init function only deal with timer setup.
>>
> 
> Hi Rob,
> 
> Just FYI I've been looking at using alloc_bootmem in the common clk code
> as a way to get rid of the static initialization stuff (which only
> existed due to very early initialization of timers).

The slab is up at the time timers are initialized. The only real problem
is mixing clock init into the timer init functions and clk init in
init_early is cleaner in that regard.

> The suggested change above to of_clk_add_provider would jive well with
> my change to the common clk code.

Are you planning this for 3.6? If not, then this can be addressed at the
time the clk framework supports bootmem.

I'm not so sure more users of bootmem are desired. There seems to be
some effort/desire to remove it:

http://lists.linux-foundation.org/pipermail/ksummit-2012-discuss/2012-June/000562.html
https://lkml.org/lkml/2012/3/13/586
http://lists.infradead.org/pipermail/linux-arm-kernel/2011-December/074886.html

Rob
