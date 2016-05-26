From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Thu, 26 May 2016 09:14:16 +0200
Subject: [PATCH v3 1/3] arm64: dts: r8a7796: Add Renesas R8A7796 SoC
 support
In-Reply-To: <20160526022833.GE18393@verge.net.au>
References: <1464054880-25843-1-git-send-email-horms+renesas@verge.net.au>
 <1464054880-25843-2-git-send-email-horms+renesas@verge.net.au>
 <b30c9c84-23b6-b088-4983-b2498317492b@de.bosch.com>
 <20160525004825.GC7292@verge.net.au>
 <c0fd13d5-c5c4-579b-6fad-c637bda92398@de.bosch.com>
 <20160526022833.GE18393@verge.net.au>
Message-ID: <59e6225a-6dfa-8bde-dd2e-3428d6fedfe2@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On 26.05.2016 04:28, Simon Horman wrote:
> Hi Dirk,
>
> On Wed, May 25, 2016 at 07:10:26AM +0200, Dirk Behme wrote:
>> Hi Simon,
>>
>> On 25.05.2016 02:48, Simon Horman wrote:
>>> Hi Dirk,
>>>
>>> On Tue, May 24, 2016 at 07:30:17AM +0200, Dirk Behme wrote:
>>>> Hi Simon,
>>>
>>> [...]
>>>
>>>> With Renesas R-Car3 we will get a whole family of SoCs. I.e. different
>>>> computing power (e.g. different number of Cores) with more or less similar
>>>> peripherals.
>>>>
>>>> I would think that we want to reflect this in the device tree, too.
>>>> Therefore I think what we want is a hierarchy of device trees. Similar
>>>> what's done with other SoC families (compare e.g. i.MX6).
>>>>
>>>> E.g. we want an initial rcar3.dtsi, which contains all common parts of all
>>>> R-Car3 SoCs. E.g. one CA57 core, the SCIF where its common etc.
>>>>
>>>> Then you will have the r8a779x.dtsi which includes the rcar3.dtsi and
>>>> extends it for SoC specific parts. Which then will be included by the board
>>>> device trees, as already done, now.
>>>>
>>>> Or in other words: As soon as you have similar parts in the r8a779x.dtsi's,
>>>> it's time to think about moving the parts one hierarchy level up into the
>>>> rcar3.dtsi. Else you will end up in a maintenance hell once you have to
>>>> change/fix anything.
>>>
>>> Thanks for raising this issue.
>>>
>>> I agree entirely that we should work towards a situation where maintenance
>>> is as easy as it can be. However, due to the per-SoC binding scheme that
>>> we are using for IP related to Renesas SoCs I suspect that very few DT nodes
>>> can be shared between SoCs verbatim.
>>
>>
>> Could you kindly share an example for this? Looking into the H3 and the M3-W
>> manual, it looks to me that ~90% (?) of the peripherals are the same.
>
> The background is that this is a conversation that has been going around
> for years. The basic thinking is that at this point we have documentation
> that indicates that many hardware blocks on the H3 and M3-W are the same.
> But we do not have insight into the internal versioning of the IP blocks
> nor if they are really the same. And furthermore even if they are currently
> the same we don't really know if that will continue to be the case.
>
> Probably it is. Maybe it isn't. The response has been to take a
> conservative approach to DT bindings to give us the flexibility to update
> the driver implementation to reflect any differences that subsequently
> surface. And by providing per-SoC bindings these driver changes can be
> activated on a per-SoC basis without updating DTB files (which may be
> burned into ROMs).


Sorry, but I don't think that these are good arguments for this kind of 
discussion ;)

The discussion has to be based on facts. And not on "maybe" or 
"probably". The fact is that the documentation tells us that the IPs are 
the same. And the documentation tells us where this isn't the case. This 
is what we can reflect in the code and the device trees.

Or the other way around: I don't ask to not have any SoC specific device 
trees (r8a7795.dtsi, r8a7796.dtsi etc). So we *always* have the option 
to move anything to them, once there might be any difference found or 
documented. But maintaining x (x > 5?) quite similar device trees just 
because there *might* be the possibility that one or two device *might* 
be different doesn't sound like a good argument to me.

Or again, an other way: If I understood correctly, you are working 
already since some time on R-Car, e.g. R-Car Gen2. How many examples do 
you have from the Gen2 family where the IP blocks are different that 
they need to be distinguished in the device tree?


>>> Probably some sort of scheme can be cooked up using preprocessor macros.
>>> And probably there are other ways to resolve this problem. But I would
>>> prefer if we worked towards resolving this maintenance problem in parallel
>>> with rather than as a dependency of merging r8a7796 support into mainline.
>>
>>
>> I'd propose to do it correct from the beginning.
>>
>> Doing it later would either be more work or forgotten, and never be done,
>> then.
>
> I'm sorry but I don't agree. I think that having r8a7796 support
> in mainline is a higher priority than sorting this out.


Looking at the example I gave in

http://article.gmane.org/gmane.linux.kernel.renesas-soc/4013

which took me < 1h to create, I'm not sure what would block us from 
mainlining the r8a7796 *including* this.


>> For a starting point, I'd propose to put the r8a7795.dtsi and r8a7796.dtsi
>> into a graphical diff tool and move all common parts to a rcar3.dtsi (I'd be
>> happy to discuss the name, though)
>
> I'm not opposed to that. But being consistent with my statement above
> I would prefer it to be done as follow-up work.
>
> My suspicion is that right now much of the proposed r8a7796.dtsi can be
> moved into a hypothetical rcar3.dtsi. But that this is because the proposed
> r8a7796.dtsi is very small. I would not expect nearly such a large
> proportion of r8a7795.dtsi to be able to be moved into rcar3.dtsi because
> it enables more hardware blocks and they typically have (or should have in
> keeping with the prevailing policy as described above) per-SoC bindings.


What doesn't prevent us to use a rcar3.dtsi like given in

http://article.gmane.org/gmane.linux.kernel.renesas-soc/4013


Having a rcar3.dtsi gives us *both* options. It doesn't force us to use 
the one or the other. I.e. we have for each IP block the *option* to 
declare it as common (put it onto rcar3.dtsi) *or* SoC specific (put it 
into r8a779x.dtsi).

Without having a common rcar3.dtsi we don't have this option at all.

So I think the conclusion is: Let's have all options (by adding a 
rcar3.dtsi) and then decide for each IP block individually where to 
place it best. Or move it later from the common dtsi to the individual 
dtsi once there is an issue found (what I really doubt that it will 
happen that often, but this is an other topic ;) )


> I believe that there is also a another issue which is that we wish
> to control enabling features on different SoCs once they are known to work.
> Of course things slip through the cracks. But blindly assuming all
> IP blocks enabled for one SoC work on another, even if based on the
> documentation, seems to be asking for trouble to me. For one thing
> it implies that the level of firmware support is the same.
>
> As for a name, I suggest rcar-gen3.dtsi.


Sounds good to me :)


Best regards

Dirk
