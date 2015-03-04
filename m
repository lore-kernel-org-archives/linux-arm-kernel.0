From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 04 Mar 2015 23:58:56 +0100
Subject: [PATCHv1] rtc: bcm-iproc: Add support for Broadcom iproc rtc
In-Reply-To: <54F78CF4.9040108@broadcom.com>
References: <1418757750-3628-1-git-send-email-arun.ramamurthy@broadcom.com>
 <2569223.1gDQjv8f8j@wuerfel> <54F78CF4.9040108@broadcom.com>
Message-ID: <2216310.NqXA88JvvL@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 04 March 2015 14:53:40 Arun Ramamurthy wrote:
> On 15-03-04 02:50 PM, Arnd Bergmann wrote:
> > On Wednesday 04 March 2015 14:40:13 Arun Ramamurthy wrote:
> >> On 15-03-04 02:21 PM, Arnd Bergmann wrote:
> >>> On Thursday 12 February 2015 14:17:41 Arun Ramamurthy wrote:
> >>>> Hi Arnd
> >>>>
> >>>> My apologies for the late reply, I was moved to other work items. I
> >>>> wanted to get more clarification on the syscon issue so that I can
> >>>> submit the next patch set. If I understand correctly, you would like
> >>>> me to move the CRMU logic to a new driver under mfd/ and use the syscon
> >>>> api calls in my rtc driver? Thanks
> >>>
> >>> It depends a lot on what's in there, I can best advise you if you
> >>> have some form of register list.
> >>>
> >>> A common approach would be to not have a driver for the crmu at all,
> >>> but just mark it as syscon, and have the other drivers either reference
> >>> the syscon node through a phandle, or create them as childrem of
> >>> the syscon node. The latter case makes most sense if all uses of
> >>> the crmu have no other MMIO registers.
> >>>
> >>
> >> Thank you Arnd, I am going to follow the approach of adding a child node
> >> to the syscon node. Several other driver use other registers in the CRMU
> >> so I think the child node approach makes the most sense.
> >
> > Just to be sure we have the same understanding: of those other drivers,
> > do you think that they would use only CRMU registers, or could there
> > be drivers that have both CRMU as well as other MMIO registers?
> >
> The other drivers have both CRMU and other MMIO registers. So I thought 
> they could also switch to using the syscon child nodes.
> 

No, in this case, better not use child nodes at all. When other platforms
use child nodes of a syscon, the common case is that they use the 'reg'
property to refer to syscon registers, which are in a different address
space from other MMIO, and you can't easily mix the two.

	Arnd
