From: 21cnbao@gmail.com (Barry Song)
Date: Thu, 25 Aug 2011 16:33:37 +0800
Subject: [PATCH v2 2/4] ARM: CSR: add PM sleep entry for SiRFprimaII
In-Reply-To: <CAGsJ_4y0jukdV+tkp60zfWCt57UcLbormeKjf8R51NkBacg6ng@mail.gmail.com>
References: <1314080152-30503-1-git-send-email-Baohua.Song@csr.com>
	<1314080152-30503-3-git-send-email-Baohua.Song@csr.com>
	<20110825072719.GA17748@S2100-06.ap.freescale.net>
	<CAGsJ_4zA0yaRu3O+cwSKDCORBDr5EVtKSmSGEMxWj90=_+oiNg@mail.gmail.com>
	<20110825082151.GB17748@S2100-06.ap.freescale.net>
	<CAGsJ_4y0jukdV+tkp60zfWCt57UcLbormeKjf8R51NkBacg6ng@mail.gmail.com>
Message-ID: <CAGsJ_4yaypV6VxmHpJVBNUDEZtwLfojuxDvnbGezgdmvFidcpQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>> >> +static int __devinit sirfsoc_memc_probe(struct platform_device *op)
>>> >> +{
>>> >> + ? ? struct device_node *np = op->dev.of_node;
>>> >> +
>>> >> + ? ? sirfsoc_memc_base = of_iomap(np, 0);
>>> >> + ? ? if (!sirfsoc_memc_base)
>>> >> + ? ? ? ? ? ? panic("unable to map memc registers\n");
>>> >> +
>>> >> + ? ? return 0;
>>> >> +}
>>> >> +
>>> >> +static struct platform_driver sirfsoc_memc_driver = {
>>> >> + ? ? .probe ? ? ? ? ?= sirfsoc_memc_probe,
>>> >> + ? ? .driver = {
>>> >> + ? ? ? ? ? ? .name = "sirfsoc-memc",
>>> >> + ? ? ? ? ? ? .owner = THIS_MODULE,
>>> >> + ? ? ? ? ? ? .of_match_table = memc_ids,
>>> >> + ? ? },
>>> >> +};
>>> >> +
>>> >> +static int __init sirfsoc_memc_init(void)
>>> >> +{
>>> >> + ? ? return platform_driver_register(&sirfsoc_memc_driver);
>>> >> +}
>>> >> +postcore_initcall(sirfsoc_memc_init);
>>> >
>>> > Doing the same thing - mapping address, why sirfsoc_pwrc_base uses
>>> > a function, while sirfsoc_memc_base needs a platform_driver? ?You
>>> > will have more stuff about memc to add there?
>>>
>>> memc is in memory space, actually simple_bus, then a platform device
>>> has existed for it.
>>> pwrc is now not compitable with simple_bus. it looks like not worth a
>>> platform for the moment too.
>>>
>> It seems a little complicated to register a platform_driver just for
>> getting an address. ?I'm not sure how hard Arnd is on this position.
>> I'm going to send a patch to test it :)
>
> i think Arnd preferred it to be driver:
>
> "
>> +static void __init sirfsoc_of_memc_map(void)
>> +{
>> + ? ? struct device_node *np;
>> +
>> + ? ? np = of_find_matching_node(NULL, memc_ids);
>> + ? ? if (!np)
>> + ? ? ? ? ? ? panic("unable to find compatible memc node in dtb\n");
>> +
>> + ? ? sirfsoc_memc_base = of_iomap(np, 0);
>> + ? ? if (!np)
>> + ? ? ? ? ? ? panic("unable to map compatible memc node in dtb\n");
>> +
>> + ? ? of_node_put(np);
>> +}
>
> Same as for the other one, I think this should be another device
> driver.
> "

will we have a common wrapper as below if we only need some virtual
address and have no complicated driver?

void __iomem* of_iomap_from_id(struct of_device_id id[], int index)
{
        struct device_node *np;
        void iomem *addr;

        np = of_find_matching_node(NULL, ids);
        if (!np)
                return NULL;

        addr = of_iomap(ids, 0);

        of_node_put(np);

        return addr;
}

-barry
