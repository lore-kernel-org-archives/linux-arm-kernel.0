From: isubramanian@apm.com (Iyappan Subramanian)
Date: Wed, 26 Apr 2017 21:12:16 -0700
Subject: [PATCH net-next 1/9] drivers: net: xgene: Protect indirect MAC
 access
In-Reply-To: <d23578a5-fedd-accd-c49b-12200440b9ca@gmail.com>
References: <1493249935-30759-1-git-send-email-isubramanian@apm.com>
 <1493249935-30759-2-git-send-email-isubramanian@apm.com>
 <d23578a5-fedd-accd-c49b-12200440b9ca@gmail.com>
Message-ID: <CAKh23FnsvzvhwbxW0qp=NUnAs-YAs4858_A6-5+0o0NPL4=THQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 26, 2017 at 5:06 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> On 04/26/2017 04:38 PM, Iyappan Subramanian wrote:
>> From: Quan Nguyen <qnguyen@apm.com>
>>
>> This patch adds lock to protect indirect mac access sequence.
>>
>> Signed-off-by: Quan Nguyen <qnguyen@apm.com>
>> Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>
>> ---
>>  drivers/net/ethernet/apm/xgene/xgene_enet_hw.c    | 2 ++
>>  drivers/net/ethernet/apm/xgene/xgene_enet_main.c  | 1 +
>>  drivers/net/ethernet/apm/xgene/xgene_enet_main.h  | 1 +
>>  drivers/net/ethernet/apm/xgene/xgene_enet_sgmac.c | 7 ++++++-
>>  drivers/net/ethernet/apm/xgene/xgene_enet_xgmac.c | 2 ++
>>  5 files changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/apm/xgene/xgene_enet_hw.c b/drivers/net/ethernet/apm/xgene/xgene_enet_hw.c
>> index 2a835e0..3697ba7 100644
>> --- a/drivers/net/ethernet/apm/xgene/xgene_enet_hw.c
>> +++ b/drivers/net/ethernet/apm/xgene/xgene_enet_hw.c
>> @@ -365,9 +365,11 @@ static void xgene_enet_rd_mcx_mac(struct xgene_enet_pdata *pdata,
>>       cmd = pdata->mcx_mac_addr + MAC_COMMAND_REG_OFFSET;
>>       cmd_done = pdata->mcx_mac_addr + MAC_COMMAND_DONE_REG_OFFSET;
>>
>> +     spin_lock(&pdata->mac_lock);
>>       if (!xgene_enet_rd_indirect(addr, rd, cmd, cmd_done, rd_addr, rd_data))
>>               netdev_err(pdata->ndev, "MCX mac read failed, addr: %04x\n",
>>                          rd_addr);
>> +     spin_unlock(&pdata->mac_lock);
>
> Why not fold the spinlock manipulation within xgenet_enet_rd_indirect()?
> That way the caller does not have to know that acquiring the spinlock is
> required and you avoid potential bugs in the future where you are
> missing the spinlock on indirect accesses?

Thanks.  We'll do that and post the next version.

> --
> Florian
