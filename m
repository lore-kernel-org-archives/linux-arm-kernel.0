From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Fri, 9 Oct 2015 19:23:40 +0800
Subject: [PATCH v5 06/10] dmaengine: add API for getting dma controller's
 quirk
In-Reply-To: <20151007143205.GG3320@vkoul-mobl.iind.intel.com>
References: <1442187923-5736-1-git-send-email-shawn.lin@rock-chips.com>
 <1442188139-6017-1-git-send-email-shawn.lin@rock-chips.com>
 <20151005153746.GG13501@vkoul-mobl.iind.intel.com>
 <56139289.7000005@rock-chips.com>
 <20151007143205.GG3320@vkoul-mobl.iind.intel.com>
Message-ID: <5617A3BC.3050401@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/10/7 22:32, Vinod Koul wrote:
> On Tue, Oct 06, 2015 at 05:21:13PM +0800, Shawn Lin wrote:
>
>>>> +	int (*device_get_quirks)(struct dma_chan *chan);
>>>
>>> And why do we want to expose this to users? THis doesnt seem right!
>>>
>>
>> Basically I agree not to expose dma's quirk to slave controllers...But, the
>> fact I mentioned on cover letter explain the reasons why I have to let slave
>> controllers know that they are working with a broken dma. It's a dilemma
>> that if we don't want that to be exposed(let slave controllers' driver get
>> the info via a API), we have to add broken quirk for all of them ,here and
>> there, which seems to be a disaster:(
>>
>> I would appreciate it if you could give me some suggestions at your earliest
>> convenience. :)
>>
>>> A quirk may exists but should be handled inside the controller driver and do
>>> appropriate action. You don't tell users or expect them to handle these
>>>
> I laready gave one re-read the above lines.
>
> Anyway I went ahead and read the usage. You are setting the slave parameters
> for this. I can see two ways:
> 1. Have the quirk to driver and based on quirk reset the slave settings when
> they are set by client.
> 2. Put this in DT and set the dma properties based on these quirks and let
> driver and cleint be agnostic to it

+Mark Brown

Thanks for these.

The first one is hard for dma to distinguish "broken 
slave"(I2S/SPI/UART..) from the unbroken ones(block devices like 
mmc/SFC...). If all clients are broken for that, it's easy to reset the 
slave parameters in dma driver. Unfortunately, not always, at least for 
rockchips' Socs.

And before V4, I did pass quirks to clents from DT, but Mark thought we 
should avoid to get it from dt. Anyway, now I think about it again,

(1) dma drivers doesn't know the users who should use limited burst and 
who won't. That make it's impossible for dma drivers to handle it alone 
or expose new API of burst capabilities to clients.
(2) It's inappropriate to expose quirks to clients.

so the only way I can see is to make some tricks from DT.
I would prefer to add "burst limit" property for the broken slaves 
instead of quirks for them which I did before V4.

Something like:

&spi{
max-burst-len=<1>;
}

How about?
:)

>


-- 
Best Regards
Shawn Lin
