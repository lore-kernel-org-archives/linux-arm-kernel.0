From: richardcochran@gmail.com (Richard Cochran)
Date: Wed, 7 Jun 2017 15:28:17 +0200
Subject: [PATCH v2 4/4] net: macb: Add hardware PTP support
In-Reply-To: <BN3PR07MB2516A47C2CFEB58BCFFB2C46C9C80@BN3PR07MB2516.namprd07.prod.outlook.com>
References: <1496413439-12900-1-git-send-email-rafalo@cadence.com>
 <1496413690-22826-1-git-send-email-rafalo@cadence.com>
 <20170606183358.GA25220@localhost.localdomain>
 <BN3PR07MB2516A47C2CFEB58BCFFB2C46C9C80@BN3PR07MB2516.namprd07.prod.outlook.com>
Message-ID: <20170607132817.GA28329@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 07, 2017 at 11:13:36AM +0000, Rafal Ozieblo wrote:
> Please look at following call-stack:
> 
> 1. macb_interrupt()   // spin_lock(&bp->lock) is taken
> 2. macb_tx_interrupt()
> 3. macb_handle_txtstamp()
> 4. skb_tstamp_tx()
> 5. __skb_tstamp_tx()
> 6. skb_may_tx_timestamp()
> 7. read_lock_bh() // second lock is taken

Well, you can always drop the lock, or postpone the call to
skb_tstamp_tx() until after the spin lock is released...

> I know that those are different locks and different types. But this could lead 
> to deadlocks. This is the reason of warning I could see.

Can you please post the lockdep splat?

Thanks,
Richard
