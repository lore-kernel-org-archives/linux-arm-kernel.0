From: broonie@kernel.org (Mark Brown)
Date: Sat, 24 May 2014 13:48:58 +0100
Subject: [PATCH v2 1/4] devicetree: bindings: Properly document micrel
 ks8851 SPI chips
In-Reply-To: <1400875040-13269-2-git-send-email-sboyd@codeaurora.org>
References: <1400875040-13269-1-git-send-email-sboyd@codeaurora.org>
 <1400875040-13269-2-git-send-email-sboyd@codeaurora.org>
Message-ID: <20140524124858.GR22111@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 23, 2014 at 12:57:17PM -0700, Stephen Boyd wrote:

>  Optional properties:
> -- vdd-supply:	supply for Ethernet mac
> +- vdd-supply: analog 3.3V supply for Ethernet mac
> +- vdd-io-supply: digital 1.8V IO supply for Ethernet mac

So, according to the datasheet I managed to find this device has a
supply VDD_IO (so normally written vdd-io-supply here), some other
supplies which are tied to VDD_IO (so can probably be omitted) and a
supply VDD_A3.3 none of which are optional.  There is an internal
regulator which can be used to drop a higher voltage VDD_IO down for
some of the supplies tied to it but that's essentially a noop from
software as far as I can tell.  None of these supplies are obviously
optional, though I've not read the datasheet in detail so I may have
missed something here.

That said it looks like this is intended to be a supply for an external
PHY rather than the device itself, but even so my original question
about it being able to operate without power still applies.  Looking at
the code it's certainly not doing any of the handling of a missing
supply that I would associate with using _optional().
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140524/6b0d3e8c/attachment-0001.sig>
