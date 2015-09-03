From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 3 Sep 2015 22:37:32 +0300
Subject: [PATCHv4 2/5] net: phy: extend fixed driver with
 fixed_phy_register()
In-Reply-To: <55E89D83.1090401@cogentembedded.com>
References: <1400249647-4643-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1400249647-4643-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <55E89D83.1090401@cogentembedded.com>
Message-ID: <55E8A17C.5010401@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/03/2015 10:20 PM, Sergei Shtylyov wrote:

>> The existing fixed_phy_add() function has several drawbacks that
>> prevents it from being used as is for OF-based declaration of fixed
>> PHYs:
>>
>>   * The address of the PHY on the fake bus needs to be passed, while a
>>     dynamic allocation is desired.
>>
>>   * Since the phy_device instantiation is post-poned until the next
>>     mdiobus scan, there is no way to associate the fixed PHY with its
>>     OF node, which later prevents of_phy_connect() from finding this
>>     fixed PHY from a given OF node.
>>
>> To solve this, this commit introduces fixed_phy_register(), which will
>> allocate an available PHY address, add the PHY using fixed_phy_add()
>> and instantiate the phy_device structure associated with the provided
>> OF node.
>>
>> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
>> Acked-by: Grant Likely <grant.likely@linaro.org>
>> ---
>>   drivers/net/phy/fixed.c   | 61
>> +++++++++++++++++++++++++++++++++++++++++++++++
>>   include/linux/phy_fixed.h | 11 +++++++++
>>   2 files changed, 72 insertions(+)
>>
>> diff --git a/drivers/net/phy/fixed.c b/drivers/net/phy/fixed.c
>> index e41546d..d60d875 100644
>> --- a/drivers/net/phy/fixed.c
>> +++ b/drivers/net/phy/fixed.c
> [...]
>> @@ -203,6 +204,66 @@ err_regs:
> [...]
>> +int fixed_phy_register(unsigned int irq,
>> +               struct fixed_phy_status *status,
>> +               struct device_node *np)
>> +{
>> +    struct fixed_mdio_bus *fmb = &platform_fmb;
>> +    struct phy_device *phy;
>> +    int phy_addr;
>> +    int ret;
>> +
>> +    /* Get the next available PHY address, up to PHY_MAX_ADDR */
>> +    spin_lock(&phy_fixed_addr_lock);
>> +    if (phy_fixed_addr == PHY_MAX_ADDR) {
>> +        spin_unlock(&phy_fixed_addr_lock);
>> +        return -ENOSPC;
>> +    }
>> +    phy_addr = phy_fixed_addr++;
>> +    spin_unlock(&phy_fixed_addr_lock);
>> +
>> +    ret = fixed_phy_add(PHY_POLL, phy_addr, status);
>
>     Was rummaging in the fixed_phy driver and a bug sprang right at me: 'phy'

    Sorry, s/phy/irq/ of course. Just noticed. :-/

> should have been passed here, not PHY_POLL. Luckily, all callers pass PHY_POLL
> anyway...

> [...]

MBR, Sergei
