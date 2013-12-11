From: horms@verge.net.au (Simon Horman)
Date: Wed, 11 Dec 2013 11:17:39 +0900
Subject: [PATCH] sh_eth: add R8A7791 support
In-Reply-To: <52A39C55.2070204@cogentembedded.com>
References: <201311150211.36049.sergei.shtylyov@cogentembedded.com>
 <20131118075433.GA1506@verge.net.au>
 <52A39C55.2070204@cogentembedded.com>
Message-ID: <20131211021736.GM19992@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 08, 2013 at 01:08:21AM +0300, Sergei Shtylyov wrote:
> Hello.
> 
> On 11/18/2013 10:54 AM, Simon Horman wrote:
> 
>    Too bad you haven't spoken out before I went and done this patch
> and its follow-ups, at the point where I only laid out my plan of
> action in a reply to Magnus...
> 
> >>Add support for yet another ARM member of the R-Car family, R-Car M2, also known
> >>as R8A7791 -- it will share the code and data with previously added R8A7790.
> >>Since  the Ether devices in these SoCs are indistinguishable at least from the
> >>driver's point of view,  do not introduce  a new platform device ID but modify
> >>device name "r8a7790-ether" to "r8a779x-ether" throughout the files (and also
> >>'r8a7790_data' to 'r8a779x_data' in the driver), just like the names used for
> >>R8A7778/9 SoCs.
> 
> >I realise that this is the approach that has been taken previously by this
> >driver for some other SoCs but it is inconsistent with the approach that
> >has (recently) emerged for drivers for Renesas IP.
> 
> >The problem with this approach is that although the hardware may appear to
> >be the same in the absence of some kind of version number for the IP we
> >can't be certain it is the same.  Some difference may come to light later
> >and then this system breaks down.
> 
>    I don't think that'll be the case here, but do I understand your
> concern about things breaking down.
>
> >Sure, at that point we can create a more fine-grained compatibility string.
> 
>    Slight correction of terms: we're dealing with platform device ID
> here, not (device tree) compatibility string.

True, thanks for pointing that out.

> >But the approach that has emerged is that in the absence of a clearly
> >documented version number for the hardware the SoC name is used as the
> >version number.
> 
>    I just deviated a little from this scheme by using a wildcard.
> 
> >I am also not entirely happy with the approach taken by this patch for
> >two other reasons:
> 
> >1) It removes rather than deprecating an existing compatibility string.
> >    Albeit one that may not actually be used in the wild.
> 
>    We don't care about out of tree code, do we? At least I don't see
> how we do that with our current platform device registration policy
> (mostly per board).

I was thinking in terms of compatibility strings, where
the dtb might be in the wild. But as you pointed out that is not the
case here.

To answer your question: no, I don't believe that we support out of tree code.

> >2) It changes both drivers/net/ and arch/arm/mach-shmobile/ code.
> >    This kind of cross-subsystem change can lead to conflicts which
> >    make Linus grumpy: this has occurred recently with shmobile code
> >    though not in this driver.
> 
>    OK, let's do it your way, with adding another platform device ID,
> and so doing only drivers/net/ change.

Thanks.

> >That said, I did successfully test this patch in conjunction with
> >companion patches for the r8A7791 SoC and Koelsch board.
> 
>    I try not to post untested patches (except when I trust other
> people to do the testing of their patches. :-)

:)
