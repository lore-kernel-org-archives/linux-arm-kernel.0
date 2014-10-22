From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 23 Oct 2014 00:20:21 +0100
Subject: [PATCH] RFC: add function for localbus address
In-Reply-To: <54483746.9060104@codeaurora.org>
References: <20140729234522.E9FF1C40738@trevor.secretlab.ca>
 <1409672700-21697-1-git-send-email-svarbanov@mm-sol.com>
 <20140908145204.8ADC2C40AE5@trevor.secretlab.ca>
 <540E1014.8090102@codeaurora.org>
 <20140914044610.913E9C4102A@trevor.secretlab.ca>
 <54483746.9060104@codeaurora.org>
Message-ID: <20141022232021.GF27405@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 22, 2014 at 04:01:26PM -0700, Stephen Boyd wrote:
> Where did this end up? When we talked at Connect I think we settled on
> exploring a driver core specific API like dev_get_localbus_address()
> that calls of_get_localbus_address() for devices with an of_node and in
> the future it could call something like acpi_get_localbus_address() when
> there's an acpi_node. I believe the biggest concern is that we're making
> an API that is OF or platform bus specific when it doesn't need to be.
> Making a driver core specific API avoids this problem by making it bus
> agnostic.

Given how little information there is in the original patch as to exactly
what problem this is addressing, I could be getting the wrong end of the
stick here.

Is this about trying to have a way to obtain the bus local addresses
associated with CPU-view resources?

If so, how about looking towards PCI, which has had this problem for the
last 15+ years, where PCI bus addresses are not necessarily the same as
CPU physical addresses?

There, we don't end up with multiple addresses specified in resources.
We instead have a way to translate between resources and bus-local
addresses, which IMHO is far nicer and less error-prone than having to
specify the same information twice, once with an offset and once without.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
