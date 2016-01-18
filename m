From: tn@semihalf.com (Tomasz Nowicki)
Date: Mon, 18 Jan 2016 13:41:51 +0100
Subject: [PATCH V3 20/21] pci, acpi: Match PCI config space accessors
 against platfrom specific quirks.
In-Reply-To: <1452785776.28109.22.camel@redhat.com>
References: <1452691267-32240-1-git-send-email-tn@semihalf.com>
 <1452691267-32240-21-git-send-email-tn@semihalf.com>
 <1452785776.28109.22.camel@redhat.com>
Message-ID: <569CDD8F.807@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14.01.2016 16:36, Mark Salter wrote:
>> +extern struct pci_mcfg_fixup __start_acpi_mcfg_fixups[];
>> >+extern struct pci_mcfg_fixup __end_acpi_mcfg_fixups[];
>> >+
>> >+static struct pci_ops *pci_mcfg_check_quirks(struct acpi_pci_root *root)
>> >+{
>> >+	struct pci_mcfg_fixup *f;
>> >+	int bus_num = root->secondary.start;
>> >+	int domain = root->segment;
>> >+
>> >+	/*
>> >+	 * First match against PCI topology <domain:bus> then use DMI or
>> >+	 * custom match handler.
>> >+	 */
>> >+	for (f = __start_acpi_mcfg_fixups; f < __end_acpi_mcfg_fixups; f++) {
>> >+		if ((f->domain == domain || f->domain == PCI_MCFG_DOMAIN_ANY) &&
>> >+		    (f->bus_num == bus_num || f->bus_num == PCI_MCFG_BUS_ANY) &&
>> >+		    (f->system ? dmi_check_system(f->system) : 0 ||
>> >+		     f->match ? f->match(f, root) : 0))
>> >+			return f->ops;
> I think this would be better as:
>
> 		    (f->system ? dmi_check_system(f->system) : 1 &&
> 		     f->match ? f->match(f, root) : 1))
> 			return f->ops;
>
> Otherwise, one has to call dmi_check_system() from f->match() if
> access to root is needed.

Makes a lot of sense to me, I will modify as you suggested.

Tomasz
