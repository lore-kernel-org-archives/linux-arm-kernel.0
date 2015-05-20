From: robert.richter@caviumnetworks.com (Robert Richter)
Date: Wed, 20 May 2015 14:48:27 +0200
Subject: [PATCH 1/4] arm64: gicv3: its: Encode domain number in PCI
 stream id
In-Reply-To: <20150520131138.2c94a32a@why.wild-wind.fr.eu.org>
References: <1430686172-18222-1-git-send-email-rric@kernel.org>
 <1430686172-18222-2-git-send-email-rric@kernel.org>
 <20150520131138.2c94a32a@why.wild-wind.fr.eu.org>
Message-ID: <20150520124827.GF10428@rric.localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark,

thanks for review, also of the other patches of this series.

See below

On 20.05.15 13:11:38, Marc Zyngier wrote:
> > -	dev_alias->dev_id = alias;
> > +	dev_alias->dev_id = (pci_domain_nr(pdev->bus) << 16) | alias;

> This feels very scary. We're now assuming that the domain number will
> always be presented to the doorbell. What guarantee do we have that
> this is always the case, irrespective of the platform?
> 
> Also, domains have no PCI reality, they are a Linux thing. And they can
> be "randomly" assigned, unless you force the domain in DT with a
> linux,pci-domain property. This looks even more wrong, specially
> considering ACPI.

The main problem here is that device ids (32 bits) are system
specific. Since we have more than one PCI root complex we need the
upper 16 bits in the devid for mapping. Using pci_domain_nr for this
fits our needs for now and shouldn't affect systems with a single RC
only as the domain nr is zero then.

The domain number is incremented during initialization beginnig with
zero and the order of it is fixed since it is taken from DT or ACPI
tables. So we have full controll of it. I don't see issues here.

> It really feels like we need a way to describe how the BDF numbering is
> augmented. We also need to guarantee that we get the actual bridge
> number, as opposed to the domain number.

But true, the obove is just intermediate. In the end we need some sort
of handler that is setup during cpu initialization that registers a
callback for the gic to determine the device id of that paricular
system.

-Robert
