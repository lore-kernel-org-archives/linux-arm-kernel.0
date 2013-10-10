From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 10 Oct 2013 21:28:55 +0530
Subject: [PATCH 1/3] dmaengine: pl330: Set residue in tx_status callback.
In-Reply-To: <CAEUnVG7Xn8+Xhnr2y5-RM6FJTQsjRrJ9g1JWf4o+6B-BtWHbPA@mail.gmail.com>
References: <1378879685-5352-1-git-send-email-padma.v@samsung.com>
 <1378879685-5352-2-git-send-email-padma.v@samsung.com>
 <00b401ceafac$e3a88170$aaf98450$@samsung.com>
 <CAEUnVG72uTzHrQCoVtdT8UmkPcz2ks_qWT8QMbhHjUW-u3WnNQ@mail.gmail.com>
 <026501cec2fe$1387c630$3a975290$@samsung.com>
 <20131007034846.GG2954@intel.com>
 <CAEUnVG7Xn8+Xhnr2y5-RM6FJTQsjRrJ9g1JWf4o+6B-BtWHbPA@mail.gmail.com>
Message-ID: <20131010155855.GA2954@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 09, 2013 at 01:37:56PM -0700, Dylan Reid wrote:
> On Sun, Oct 6, 2013 at 8:48 PM, Vinod Koul <vinod.koul@intel.com> wrote:
> > On Mon, Oct 07, 2013 at 10:39:34AM +0900, Chanho Park wrote:
> >> > > Why didn't you use a cookie value to track the request?
> >> > > The cookie is assigned when each transfer is submitted.
> >> > > If you save the value in the desc, we can find the request easily.
> >> >
> >> > If there are several cyclic desc in the work list, is there a better way
> >> > to find the "current" one?  The chan struct tracks the last completed and
> >> > last submitted cookies, but these will be the first and last
> >> > respectively as long as the cyclic transfer is active.  Is there an
> >> > "active" cookie stored somewhere that I missed?
> >>
> >> Assume there are three cookies. If you want to get the second cookie not
> >> latest cookie, your way can be also correct in such case?
> >> I think tx_status API is to get dma status of the given cookie.
> >> You are only considering a cyclic case.
> > For cyclic case you would have possible same descriptor running till you
> > terminate.
> 
> The cyclic case that makes this interesting is when there are multiple
> cyclic descriptors in the list. The cookie and completed_cookie
> markers don't help to determine which of the descriptors in the list
> is currently active.  dma_cookie_complete isn't called for a cyclic
> desc, the desc is just pushed to the end of the list.
Yes the cyclic is a very different case. I think driver can still return for
cyclic case which was txstate->last and that will give clue to client which is
getting processed now!

> > For non cyclic, if you have 3 descriptors submitted, the cookie value can be, say
> > 7, 8 and 9. If you query the status of any descriptor and pass the last optional
> > txstate arg then you will know the last cookie completed. so if txstate->last is
> > 7, then 7th was completed and 8 should be running and 9 in queue!
> 
> Got it, but the correct desc for cookie 8 will still have to be
> searched for, correct?
Yes

-- 
~Vinod
