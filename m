From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 14 Jan 2016 10:34:30 +0000
Subject: [RFC] arm64: failed when run the command: timedatectl
 set-timezone Asia/Shanghai
In-Reply-To: <5696FE81.8070904@huawei.com>
References: <56946932.70601@huawei.com> <569473B2.3030909@huawei.com>
 <CAPvkgC3HkZ5nP4qxDO+LRCeK5dd29zEpz9ZeK7J_mrCWXrszGA@mail.gmail.com>
 <5695A57B.1060905@huawei.com> <20160113110900.GA23370@leverpostej>
 <5696FE81.8070904@huawei.com>
Message-ID: <20160114103430.GA25670@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 14, 2016 at 09:48:49AM +0800, Xishi Qiu wrote:
> On 2016/1/13 19:09, Mark Rutland wrote:
> 
> > On Wed, Jan 13, 2016 at 09:16:43AM +0800, Xishi Qiu wrote:
> >> On 2016/1/12 18:59, Steve Capper wrote:
> >>> Hi Xishi,
> >>> This looks like a bug in the Mozilla Javascript engine (which is used
> >>> by polkitd). It incorrectly assumes that virtual addresses are at most
> >>> 47 bit and uses the upper bits for pointer tagging.
> >>> When we enable a 48-bit VA on arm64, this then exacerbates the problem
> >>> (your VA of 0x7fff9010c040 should likely be 0xffff9010c040).
> >>>
> >>> I have raised this issue at:
> >>> https://bugzilla.mozilla.org/show_bug.cgi?id=1143022
> >>>
> >>> I'm not sure as to the best way of getting this fixed, I would suggest
> >>> adding to the bug report above as a first step.
> >>>
> >>
> >> Hi Steve,
> >>
> >> I find another issue at:
> >> https://bugzilla.redhat.com/show_bug.cgi?id=1242326
> > 
> > Per your question below, the proposed patch is incorrect.
> > 
> > Userspace can only assume ownership of the upper 8 bits, and only in the
> > cases described in [1]. Userspace MUST NOT assume it can use other bits
> > for its own purposes.
> > 
> > This was a deliberate decision such that the address space can be
> > enlarged in future. For example, ARMv8.2 expands addresses to 52 bits
> > [2], and addresses could grow further in future.
> > 
> >> In your issue, Tom Schuster said it sounds like bug 910845
> >> https://bugzilla.mozilla.org/show_bug.cgi?id=910845
> > 
> 
> Hi Mark,
> 
> Thank you very much. So the patch above only cover Itanium, and there is
> no solution for arm64 now, right? 

Yes, the patch only covers Itanium.

I am not aware of a patch solving the issue for arm64. I have not been
following the development of the Mozilla javasript engine.

The best thing to do is probably to respond to the first ticket
(https://bugzilla.mozilla.org/show_bug.cgi?id=1143022), querying whether
or not anyone is able to take a look at it. 

If you do, please cite this thread, in particular:

http://lists.infradead.org/pipermail/linux-arm-kernel/2016-January/399178.html), 

Which should help to avoid an erroneous solution.

Thanks,
Mark.
