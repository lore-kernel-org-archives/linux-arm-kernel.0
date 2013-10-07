From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 7 Oct 2013 09:18:46 +0530
Subject: [PATCH 1/3] dmaengine: pl330: Set residue in tx_status callback.
In-Reply-To: <026501cec2fe$1387c630$3a975290$@samsung.com>
References: <1378879685-5352-1-git-send-email-padma.v@samsung.com>
 <1378879685-5352-2-git-send-email-padma.v@samsung.com>
 <00b401ceafac$e3a88170$aaf98450$@samsung.com>
 <CAEUnVG72uTzHrQCoVtdT8UmkPcz2ks_qWT8QMbhHjUW-u3WnNQ@mail.gmail.com>
 <026501cec2fe$1387c630$3a975290$@samsung.com>
Message-ID: <20131007034846.GG2954@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 07, 2013 at 10:39:34AM +0900, Chanho Park wrote:
> > > Why didn't you use a cookie value to track the request?
> > > The cookie is assigned when each transfer is submitted.
> > > If you save the value in the desc, we can find the request easily.
> > 
> > If there are several cyclic desc in the work list, is there a better way
> > to find the "current" one?  The chan struct tracks the last completed and
> > last submitted cookies, but these will be the first and last
> > respectively as long as the cyclic transfer is active.  Is there an
> > "active" cookie stored somewhere that I missed?
> 
> Assume there are three cookies. If you want to get the second cookie not
> latest cookie, your way can be also correct in such case?
> I think tx_status API is to get dma status of the given cookie.
> You are only considering a cyclic case.
For cyclic case you would have possible same descriptor running till you
terminate.

For non cyclic, if you have 3 descriptors submitted, the cookie value can be, say
7, 8 and 9. If you query the status of any descriptor and pass the last optional
txstate arg then you will know the last cookie completed. so if txstate->last is
7, then 7th was completed and 8 should be running and 9 in queue!
> > Looking for the first buffer with status == BUSY is an improvement I'll
> > make.  Any way to avoid looking through the list?
Its already there :)

-- 
~Vinod
