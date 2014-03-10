From: dwmw2@infradead.org (David Woodhouse)
Date: Mon, 10 Mar 2014 07:52:51 -0700
Subject: [PATCH 06/13] DMAENGINE: driver for the ARM PL080/PL081 PrimeCells
In-Reply-To: <20140310143247.GZ21483@n2100.arm.linux.org.uk>
References: <1276270031-1607-1-git-send-email-linus.walleij@stericsson.com>
 <20101221182037.GA4783@n2100.arm.linux.org.uk>
 <20101222122904.GC14693@n2100.arm.linux.org.uk>
 <AANLkTikpyAggDCPef1pS=_QHnu9-FyLcpddGyVHnGwWx@mail.gmail.com>
 <20110101151545.GC25924@n2100.arm.linux.org.uk>
 <1394459790.2270.39.camel@shinybook.infradead.org>
 <20140310143247.GZ21483@n2100.arm.linux.org.uk>
Message-ID: <1394463171.2270.54.camel@shinybook.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2014-03-10 at 14:32 +0000, Russell King - ARM Linux wrote:
> Okay, so how do you get the DMA address which is to be programmed into
> the DMA controller - bearing in mind that different devices in the
> system may have different bus:physical offsets?

There's no answer to that in the general case. The question of how you
program it into the DMA controller, and where you *get* the information
from, is very board-specific. As is the question of whether it's even
*possible* for the DMA controller to "fake" the source of its
transactions. It works for PCIe in certain cases (especially in SoCs)
but certainly doesn't work everywhere.

But that's OK, because in the general case we'd just do the sensible
thing and the DMA would appear to come from the DMA controller itself.
We're only talking about adding the *possibility* for doing otherwise,
not making it mandatory.

> ACPI may allow you to work this out for each slave device, but now
> try thinking about this same problem without ACPI.

Actually, if it's really true that the *kernel* is supposed to tell the
DMA controller which source-id to use for a given channel, instead of it
being programmed in advance by the BIOS, then ACPI doesn't solve that
for us in this case either. The whole thing seems to be designed such
that the DMA just *does* appear to come from the slave, not the DMA
controller. And we haven't yet worked out how we're supposed to make
that happen. If indeed we *are* supposed to :)

-- 
dwmw2

-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 5745 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140310/e932ebf2/attachment.bin>
