From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Tue, 14 Nov 2017 17:41:09 +0100
Subject: [PATCH v3 3/4] net: nb8800: Move HW init to ndo_open()
In-Reply-To: <yw1xfu9h0xv7.fsf@mansr.com>
References: <230165aa-eaf1-6e2b-7ff3-45b3ee4ffc62@sigmadesigns.com>
 <103bc878-9311-a727-1c21-2070e0a480e5@sigmadesigns.com>
 <yw1xwp2t11ap.fsf@mansr.com>
 <4e22ef54-d823-fc29-fedc-d447fa3d9c88@sigmadesigns.com>
 <yw1xfu9h0xv7.fsf@mansr.com>
Message-ID: <30042004-4e13-b7e2-b49d-754db54cc5ce@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/11/2017 14:54, M?ns Rullg?rd wrote:

> Marc Gonzalez writes:
> 
>> On 14/11/2017 13:40, M?ns Rullg?rd wrote:
>>
>>> Marc Gonzalez wrote:
>>>
>>>> Power entire ethernet block down in ndo_stop().
>>>> Power it back up in ndo_open() and perform HW init.
>>>> Delete nb8800_dma_stop.
>>>
>>> Leave it alone, please.  Not all chips might have a separate power
>>> domain for this.  Also, it works just fine on the older chips.
>>
>> There is no need for separate power domains. The ethernet block is
>> clock-gated when it is held in reset.
> 
> So you're not powering it down then.  Please be accurate.

Smirk. That looks like trolling.


>> The reset register is implemented on all tango3, tango4, tango5 chips.
> 
> It's still not a core feature.

Correct. But it covers 100% of all chips using this driver.
There is no point in trying to implement support for chips that
have never existed, do not exist, and never will.


>> nb8800_dma_stop() is a hack.
> 
> The hack originated from your company.

So why are you so insistent that we keep using it?


>> The HW dev has stated that it is not supported.  One cannot conclude
>> that it "works fine" just because you've never triggered the error
>> condition. (On tango5, the error condition triggers systematically.)
> 
> That sounds like a problem for tango5.

tango5 does have its share of issues.


> Also, I have repeated asked you what happens if the tango5 runs out of
> DMA buffers under normal operation.  Does that also cause it to lock up?
> If so, you have a much bigger problem on your hands.

I will run iperf3 tests with RX_DESC_COUNT lowered to 2.
Would that produce conclusive results?
Do you have other suggestions?


>> We have several customer bug reports on tango3 and tango4 chips complaining
>> about "broken" ethernet after a link down / link up cycle. They are using a
>> different driver, but it implements the same hack in enet_stop_rx().
>> There is a high probability that the DMA hack is responsible, and wedged the
>> RX DMA state machine.
> 
> But you have no idea what's really the problem?

I have an idea that enet_stop_rx() wedged the RX DMA state machine.
