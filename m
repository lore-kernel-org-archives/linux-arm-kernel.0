From: balbi@ti.com (Felipe Balbi)
Date: Tue, 4 Aug 2015 12:29:33 -0500
Subject: [PATCH v5 00/46] usb: gadget: rework ep matching and claiming
 mechanism
In-Reply-To: <1438351258-31578-1-git-send-email-r.baldyga@samsung.com>
References: <1438351258-31578-1-git-send-email-r.baldyga@samsung.com>
Message-ID: <20150804172933.GB9623@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jul 31, 2015 at 04:00:12PM +0200, Robert Baldyga wrote:
> Hello,
> 
> This patch series reworks endpoint matching and claiming mechanism in
> epautoconf. From v2 there are couple of new patches adding 'ep_match'
> to usb_gadget_ops and removing chip-specific quirk handling from generic
> code of autoconfig.
> 
> I'm not sure if this patch set isn't too long, as it has 46 patches,
> but I decided to send it as single series to avoid problems with patch
> applying order.
> 
> The aim of whole patchset is to rework epautoconf code to get rid of
> things like name-based endpoint matching and UDC name-based quirks in
> generic code. These needed to do some modifications in framework like
> adding 'endpoint capabilities flags' feature or adding 'match_ep'.
> 
> Following paragraphs contain brief description of what modifications are
> done by particular parts of this patch set:
> 
> Patch (1) introduces new safer endpoint claiming method, basing on new
> 'claimed' flag. It was discussed here [1]. I proposed this solution over
> year ago and it was accepted, but I apparently forgot to send the final
> version of my patch.
> 
> Patches (2-3) add the 'capabilities flags' structure and helper macros.
> This solution is inspired by the 'feature flags' originally proposed
> by Felipe Balbi in 2013 [2], but unfortunately implementation of this
> feature has never been completed.
> 
> Patches (4-36) add' capabilites flags' support to all UDC drivers present
> in the kernel tree. It's needed to be done before replacing old endpoint
> matching mechanism, otherwise UDC drivers which doesn't set 'capabilities
> flags' won't work with new matching function.
> 
> Patch (37) finally replaces old endpoint matching method with the new
> one basing on capabilities flags.
> 
> These changes aims to get rid of code, which guesses endpoint capabilities
> basing on it's name, and introduce new better replacement. In result
> we have better way to describe types and directions supported by each
> endpoint.
> 
> For example the old name-based method didn't allow to have endpoint
> supporing two types of transfers - there were only ability to support
> one or all of endpoint types. The 'capabilities flags' feature supply
> precise, flexible and extensible mechanism of description of endpoint
> hardware limitations, which is desired for proper endpoint matching.
> 
> Patch (38) removes chip-specific quirk from ep_matches() function.
> 
> Patches (39-40) remove code modifying endpoint and descriptor structures
> from ep_matches() function and cleans it up to make it simpler and more
> readable.
> 
> Patch (41) add 'match_ep' callback to usb_gadget_ops and make use of
> it in epautoconf. This callback allows UDC drivers to supply non-standard
> endpoint matching algorithms.
> 
> Patches (42-43) move ep_matches() and find_ep() functions outside
> epautoconf and rename them to usb_gadget_ep_match_desc() and
> gadget_find_ep_by_name(). It's because they may be useful in 'match_ep'
> callbacks in UDC drivers to avoid writing repetitive code.
> 
> Patches (44-46) move chip-specific enpoint matching algorithms from
> generic code of usb_ep_autoconfig_ss() function to UDC controller drivers
> using 'match_ep' callback.
> 
> In the result we have epautoconf source free of chip-specific code, plus
> two new mechanisms allowing to handle non-standard hardware limitations.
> 
> [1] https://lkml.org/lkml/2014/6/16/94
> [2] http://www.spinics.net/lists/linux-usb/msg99662.html

adding these to my testing/next after fixing a few build warnings and
the comment I had on dwc3 patch. Let's hope it just works :-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150804/d563ca16/attachment.sig>
