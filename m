From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Tue, 31 May 2011 13:23:32 -0500
Subject: ep93xx: status/future of the sparsemem support
In-Reply-To: <20110529130644.GI16318@ibawizard.net>
References: <20110529130644.GI16318@ibawizard.net>
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F381FC4934@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, May 29, 2011 6:07 AM, Petr ?tetiar wrote:
> 
> Hi all,
> 
> I would like to ask about the status or plans for the sparsemem support on the
> ep93xx. I'm mainly talking about the ts72xx here as I don't have any other
> boards, but it seems, that sparsemem is the must for the boards with more then
> one memory bank. Or it's not true?
> 
> For example, right now, I'm trying to get the recent kernel working on the
> ts-7300 with the 128MB RAM (two 64MB memory chips, 16 banks, 8MB each,
> first 8 at 0x0000000-0x7000000, second one at 0xe0000000-0e7000000) and as you
> might guess, it's unusable with flatmem (and it looks like the discontig mem
> is now gone for ARM if I'm not mistaken):

[...]

> The question is, what's the problem with the sparsemem patch[1] for ep93xx,
> that it's not yet in the mainline? Nobody needed it yet? :-) If it's that the
> case, I could submit it, no problem. I don't follow this mailing list and
> development on the ep93xx regularly, so I might have missed some important
> detail. Thank you for any pointers.
> 
> 1. http://marc.info/?l=linux-arm&m=122754446724900

I don't think that patch covers all the possible configurations for the ep93xx.

The ep39xx has four chip-selects that decode to these memory addresses:

nSDCS3  0x00000000-0x0fffffff  Boot option ASDO = 1
nSDCS3  0xf0000000-0xffffffff  Boot option ASDO = 0
nSDCS2  0xe0000000-0xefffffff
nSDCS1  0xd0000000-0xdfffffff
nSDCS0  0xc0000000-0xcfffffff

Then because of the way the ep93xx sdram controller uses the address bus, which
is shared with the external memory (flash, etc.), the sdram memory gets broken
up into banks of 2MB, 4MB, 8MB, 16MB, 32MB, or 128MB depending on the type of
sdram used.  To make matters even more confusing, the sdram can operate with
either a 16-bit or 32-bit wide data bus.  See [2] for the details.

The patch above is optimized for the nSDCS3 (ASDO=1) and nSDCS2 configuration
with 8MB banks.  In order for the ep93xx to support sparsemem I think it needs
a bit of work to handle the other configurations.

Regards,
Hartley

2. http://arm.cirrus.com/files/HOWTO/EP93xx%20SDRAM%20Address%20Ranges.pdf
