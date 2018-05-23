From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 23 May 2018 09:57:34 -0700
Subject: [PATCH net] net: phy: broadcom: Fix bcm_write_exp()
In-Reply-To: <89a1f8d7-5303-f3c0-aa38-43e64488ec5a@gmail.com>
References: <20180523000450.9384-1-f.fainelli@gmail.com>
 <20180523001503.GA16062@lunn.ch>
 <89a1f8d7-5303-f3c0-aa38-43e64488ec5a@gmail.com>
Message-ID: <f5ba663b-1067-25cf-901b-57e7e85ed9e6@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/22/2018 06:20 PM, Florian Fainelli wrote:
> Hi Andrew,
> 
> On 05/22/2018 05:15 PM, Andrew Lunn wrote:
>> On Tue, May 22, 2018 at 05:04:49PM -0700, Florian Fainelli wrote:
>>> On newer PHYs, we need to select the expansion register to write with
>>> setting bits [11:8] to 0xf. This was done correctly by bcm7xxx.c prior
>>> to being migrated to generic code under bcm-phy-lib.c which
>>> unfortunately used the older implementation from the BCM54xx days.
>>
>> Hi Florian
>>
>> Does selecting the expansion register affect access to the standard
>> registers? Does this need locking like the Marvell PHY has when
>> changing pages?
> 
> We should probably convert this to the page accessors since the
> expansion, misc and other shadow 0x1c accesses are all indirection
> layers to poke into a different address space of the PHY. That would be
> a separate fix though for a number of reasons.

I realize I did not quite answer your question, the answer to your
question AFAICT is no, setting the expansion register sequence and then
aborting mid-way is not a problem and does not impact the standard MII
registers because of how this is implemented. The registers are accessed
and latched through a specific indirect sequence, but there is no page
switching unlike the Marvell PHYs
-- 
Florian
