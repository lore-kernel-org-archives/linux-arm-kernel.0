From: oliver+list@schinagl.nl (Olliver Schinagl)
Date: Wed, 12 Aug 2015 13:55:59 +0200
Subject: [linux-sunxi] MMC clock gating broken on a20
In-Reply-To: <55CB3095.9050509@schinagl.nl>
References: <CAOMqctRhQHv1idY0ci6uzDxnv5oj7dbHtc4CTfo75ipXkXd1gw@mail.gmail.com>
 <55CB3095.9050509@schinagl.nl>
Message-ID: <55CB344F.6050608@schinagl.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Actually, I've reverted hans's

mmc: sunxi: Don't start commands while the card is busy

and that makes it disapear as well. So it looks like that patch triggers 
the aggressiveness more?

I'll apply your patch and undo the revert to see if that fixes the root 
issue.

Olliver

On 12-08-15 13:40, Olliver Schinagl wrote:
> Hey all,
>
> I'm noticing the exact same thing using hans's sunxi-wip from a few 
> days ago.
>
> I did see a patch from you about this very issue I belive
> mmc: sunxi: fix timeout in sunxi_mmc_oclk_onoff
>
> but can't find it in any of the repo's. Has it been merged yet and did 
> that actually solve the problem eventually?
>
>
> On 24-05-15 14:37, Michal Suchanek wrote:
>> Hello,
>>
>> I tried to update the kernel on my cubieboards to something recent and
>> while the a10 cubieboard works fine the a20 one won't boot.
>>
>> Looking at the console I found that the culprit is mmc clock so I
>> disabled mmc clock gating and the board works.
>>
>> I went as far back as 3.19 and the issue is pretty much the same. The
>> difference is that with linus master the clock gating seems more
>> aggressive so the board does not even boot whereas with 3.19 it
>> crashes shortly after booting fully.
>>
>> Anyone has some idea why the clock would fail re-enabling after gated?
>>
>> Supposedly the clock was already set up by the kernel when probing 
>> the mmc.
>>
>> Thanks
>>
>> Michal
>>
>> root at sunxi-a20:~# sunxi-mmc 1c0f000.mmc: fatal err update clk timeout
>> mmcblk0: error -5 requesting status
>> blk_update_request: I/O error, dev mmcblk0, sector 2048
>> Buffer I/O error on dev mmcblk0p1, logical block 0, lost async page 
>> write
>> blk_update_request: I/O error, dev mmcblk0, sector 2056
>> Buffer I/O error on dev mmcblk0p1, logical block 1, lost async page 
>> write
>> mmcblk0: error -5 sending status command, retrying
>> mmcblk0: error -5 sending status command, retrying
>> mmcblk0: error -5 sending status command, aborting
>> blk_update_request: I/O error, dev mmcblk0, sector 6776
>> Buffer I/O error on dev mmcblk0p1, logical block 591, lost async page 
>> write
>> mmcblk0: error -5 sending status command, retrying
>> mmcblk0: error -5 sending status command, retrying
>> mmcblk0: error -5 sending status command, aborting
>>
>
