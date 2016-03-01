From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Tue, 1 Mar 2016 14:51:26 -0700
Subject: [PATCH net-next V2 03/16] net: fec: pass txq to fec_enet_tx_queue
 instead of queue_id
In-Reply-To: <CAHrpEqSyuToC6QFEZygO0YyA=gV2cZEtkpRJMeZFOjhgTLdexQ@mail.gmail.com>
References: <1456360619-24390-1-git-send-email-troy.kisky@boundarydevices.com>
 <1456360619-24390-4-git-send-email-troy.kisky@boundarydevices.com>
 <CAHrpEqSyuToC6QFEZygO0YyA=gV2cZEtkpRJMeZFOjhgTLdexQ@mail.gmail.com>
Message-ID: <56D60EDE.7090100@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/1/2016 2:06 PM, Zhi Li wrote:
> On Wed, Feb 24, 2016 at 6:36 PM, Troy Kisky
> <troy.kisky@boundarydevices.com> wrote:
>> queue_id is the qid member of struct bufdesc_prop.
>>
>> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
>> ---
>>  drivers/net/ethernet/freescale/fec_main.c | 17 ++++++-----------
>>  1 file changed, 6 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
>> index 9619b9e..c517194 100644
>> --- a/drivers/net/ethernet/freescale/fec_main.c
>> +++ b/drivers/net/ethernet/freescale/fec_main.c
>> @@ -1156,25 +1156,18 @@ fec_enet_hwtstamp(struct fec_enet_private *fep, unsigned ts,
>>         hwtstamps->hwtstamp = ns_to_ktime(ns);
>>  }
>>
>> -static void
>> -fec_enet_tx_queue(struct net_device *ndev, u16 queue_id)
>> +static void fec_txq(struct net_device *ndev, struct fec_enet_private *fep,
>> +                   struct fec_enet_priv_tx_q *txq)
> 
> you can get fep from ndev.
> 

True, but fec_txq/fec_rxq is called in a loop. Why not pass it, rather than
look it up again?
