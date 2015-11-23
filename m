From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 23 Nov 2015 17:40:56 +0100
Subject: [PATCH v3 1/6] PCI: designware: remove wrong io_base assignment
In-Reply-To: <56533D93.5000604@linaro.org>
References: <cover.1448270813.git.stanimir.varbanov@linaro.org>
 <EE11001F9E5DDD47B7634E2F8A612F2E162C6F70@lhreml503-mbs>
 <56533D93.5000604@linaro.org>
Message-ID: <6899049.45pKpnsxmL@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 23 November 2015 18:23:47 Stanimir Varbanov wrote:
> >>
> >> Fixes: 0021d22b73d6 ("PCI: designware: Use of_pci_get_host_bridge_resources()
> >> to parse DT")
> >> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> 
> I think the bug is introduced in:
> 
> cbce7900598c ("PCI: designware: Make driver arch-agnostic")
> 
> cause the io_base is correctly calculated in 0021d22b73d6, do you agree?


I think cbce7900598c just slightly changes the io_base value, but
it's still referring to a bus address, not a cpu address, both before
and after the patch.

0021d22b73d6 hower seems to remove the correct 'pp->io_base = range.cpu_addr;'
and replaces it with 'pp->io_base = pp->io->start;', so it's now in
the wrong address space.

	Arnd
