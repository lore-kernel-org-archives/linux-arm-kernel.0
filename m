From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 11 Sep 2014 21:29:48 -0700
Subject: Q about driver code for KSZ8873MML
In-Reply-To: <20140912040744.GD2522@tarshish>
References: <CAH=J7GMQMGhEgiGQiXru1P4zdZjemFwwWrUjhRWBN+jS-qsF=Q@mail.gmail.com>
 <20140912040744.GD2522@tarshish>
Message-ID: <541276BC.7000705@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/11/14 21:07, Baruch Siach wrote:
> Hi Patrick,
>
> On Thu, Sep 11, 2014 at 10:40:29PM -0400, Patrick Boyle wrote:
>> In the linux/include/micrel_phy.h file the PHY ID for the KSZ8873MML
>> is defined as (0x000e7237)
>>
>> #define MICREL_PHY_ID_MASK     0x00fffff0
>>
>> #define PHY_ID_KSZ8873MLL      0x000e7237
>> #define PHY_ID_KSZ9021         0x00221610
>> #define PHY_ID_KSZ8737         0x00221720
>> /* same id: KS8021, KS8031 */
>> #define PHY_ID_KSZ8021         0x00221555
>> #define PHY_ID_KSZ8041         0x00221510
>> #define PHY_ID_KSZ8051         0x00221550
>> /* same id: ks8001 Rev. A/B, and ks8721 Rev 3. */
>> #define PHY_ID_KSZ8001         0x0022161A
>> /* same id: KS8081, KS8091 */
>> #define PHY_ID_KSZ8081         0x00221560
>> #define PHY_ID_KSZ8061         0x00221570
>> #define PHY_ID_KSZ9031         0x00221620
>>
>> /* struct phy_device dev_flags definitions */
>> #define MICREL_PHY_50MHZ_CLK   0x00000001
>>
>> But the datasheet from Micrel for this part (and using mii to probe
>> the part on my board) shows:
>>
>> 0x00221430
>>
>> So where did 0x000e7237 come from?
>
> git has a wonderful tool called 'git blame'. This tool indicates that the
>
> #define PHY_ID_KSZ8873MLL      0x000e7237
>
> line comes from commit 93272e07d8539c
> (http://git.kernel.org/linus/93272e07d8539c) by Jean-Christophe
> PLAGNIOL-VILLARD (added to Cc).

Since that chip is an Ethernet switch, one possible confusion, which is 
is easy to get is that the chip will reply with a different value 
depending on whether you access one of its port PHY address (e.g: 1 
through 3 for the KSZ8873ML) or if you access the switch 
pseudo-PHY/global/control address (e.g: 16 for Marvell, 30 for Broadcom).

The correct value indeed seems to be 0x00221430 when accessing PHYAD1 or 
PHYAD2. What you can do to prevent the same PHY driver from trying to 
bind multiple time to the per-port PHYs is to register a PHY fixup 
similar to these ones:

https://dev.openwrt.org/browser/trunk/target/linux/generic/files/drivers/net/phy/mvswitch.c#L389
https://dev.openwrt.org/browser/trunk/target/linux/generic/files/drivers/net/phy/b53/b53_phy_fixup.c
--
Florian
