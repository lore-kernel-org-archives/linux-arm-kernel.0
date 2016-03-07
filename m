From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Mon, 7 Mar 2016 15:27:10 +0100
Subject: [PATCH v3 0/8] arm64: rockchip: Initial GeekBox enablement
In-Reply-To: <56DD8176.2080603@st.com>
References: <1457294038-14243-1-git-send-email-afaerber@suse.de>
 <56DD7172.4000707@suse.de> <2714888.1DdqvJZ8cb@diego>
 <56DD7593.5060003@suse.de> <56DD8176.2080603@st.com>
Message-ID: <56DD8FBE.9010200@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Giuseppe,

Am 07.03.2016 um 14:26 schrieb Giuseppe CAVALLARO:
> On 3/7/2016 1:35 PM, Andreas F?rber wrote:
>> Am 07.03.2016 um 13:24 schrieb Heiko St?bner:
>>> Am Montag, 7. M?rz 2016, 13:17:54 schrieb Andreas F?rber:
>>>> Am 06.03.2016 um 20:53 schrieb Andreas F?rber:
>>>>> On next-20160304 the GMAC seems to have regressed, it no longer
>>>>> finds the
>>>>> PHY:
>>>>>
>>>>> libphy: PHY stmmac-0:ffffffff not found
> 
> snps,phy-addr is not correct. Can you check it?

It was never set:

https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/tree/arch/arm64/boot/dts/rockchip/rk3368.dtsi#n436

https://github.com/afaerber/linux/blob/96c5b5fd395fee5713755e93e677fb011cb9ddc0/arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts#L114

> In the stmmac_mdio if this is not passed as parameter the bus should
> be scanned and the first IDs found should select the right address.
> I suppose in your box there is a real transceiver, so maybe the patch
> from Gabriel is not actually necessary.

On the GeekBox module there's an RTL8211E phy.

Indeed, reverting Gabriel's commit fixes the observed error messages:

rk_gmac-dwmac ff290000.ethernet eth0: Link is Up - 1Gbps/Full - flow
control rx/tx

http://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/drivers/net/ethernet/stmicro?id=88f8b1bb41c6208f81b6a480244533ded7b59493

However, I am unable to ping any hosts on the network now.

Regards,
Andreas

>>>>> eth0: Could not attach to PHY
>>>>> stmmac_open: Cannot attach to PHY (error: -19)
>>>>
>>>> Still with us in next-20160307. CC'ing stmmac maintainers.
> 
> peppe
> 
>>>
>>> do you remember from what revision you rebased away from, when it was
>>> still
>>> working (as a known-good state)?
>>
>> Hm, next-20160111 possibly... leaving all the 5 days and 4 days ago
>> changes as candidates ("stmmac: share reset function between dwmac100
>> and dwmac1000" .. "stmmac: Fix 'eth0: No PHY found' regression").

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton; HRB 21284 (AG N?rnberg)
