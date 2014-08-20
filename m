From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 20 Aug 2014 13:27:57 +0200
Subject: [PATCH] drivers: pci: convert generic host controller to DT host
 bridge creation API
In-Reply-To: <1407861695-25549-1-git-send-email-Liviu.Dudau@arm.com>
References: <1407861695-25549-1-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <201408201327.57376.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 12 August 2014, Liviu Dudau wrote:
> +       return of_create_pci_host_bridge(dev, 0, 0xff, &gen_pci_ops,
> +                                       gen_pci_setup, pci);

I had not noticed it earlier, but the setup callback is actually a feature
of the arm32 PCI code that I had hoped to avoid when moving to the
generic API. Can we do this as a more regular sequence of


	ret = of_create_pci_host_bridge(dev, 0, 0xff, &gen_pci_ops, pci);
	if (ret)
		return ret;

	ret = gen_pci_setup(pci);
	if (ret)
		pci_destroy_host_bridge(dev, pci);
	return ret;

?

	Arnd
