From: robherring2@gmail.com (Rob Herring)
Date: Sun, 23 Mar 2014 10:09:05 -0500
Subject: [PATCH 0/8] Generic serial earlycon
In-Reply-To: <201403222301.30222.arnd@arndb.de>
References: <1395436128-11244-1-git-send-email-robherring2@gmail.com>
 <201403221054.39799.arnd@arndb.de>
 <CAL_JsqKjGjyYypwneCmNc1qeKe0ZOG9gz3QSJ37-HwHXKu3iRA@mail.gmail.com>
 <201403222301.30222.arnd@arndb.de>
Message-ID: <CAL_Jsq+j4ixVbfue62q_tOHb-HPA2jAxwZtTjtLy6jE9crGvsg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 22, 2014 at 5:01 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Saturday 22 March 2014, Rob Herring wrote:
>> I think this series stands on its own. It is largely refactoring
>> existing code and supporting existing command line options (arm64 just
>> changes from earlyprintk= to earlycon=). There will be cases where
>> changing the kernel command line is the only way to setup the
>> earlycon. Also, I think we would still want the kernel command line to
>> control whether or not we enable the earlycon (i.e. earlycon=dt).
>> There's not a standard way for how bootloaders would decide to set
>> "linux,stdout-path" or not.
>>
>> The DT support won't be all that quick to implement. The challenge
>> with the DT parsing is we have to do it on the flattened DT. I have
>> something functioning, but it doesn't do any address translation which
>> is the hard part.
>
> Ah, I hadn't realized that we call parse_early_param() twice, both
> in start_kernel() and before that in setup_arch(). You are right
> that the first one of these can only look at the flat device tree
> at the moment. I wonder if that's out of necessity or just coincidence
> though.
>
> There is relatively little going on between the first parse_early_param()
> and the call to unflatten_device_tree(), so it may be possible to move
> the former down, or the latter up.
>
>         parse_early_param();
>
>         sort(&meminfo.bank, meminfo.nr_banks, sizeof(meminfo.bank[0]), meminfo_cmp, NULL);
>
>         early_paging_init(mdesc, lookup_processor_type(read_cpuid_id()));
>         setup_dma_zone(mdesc);
>         sanity_check_meminfo();
>         arm_memblock_init(&meminfo, mdesc);
>
>         paging_init(mdesc);
>         request_standard_resources(mdesc);
>
>         if (mdesc->restart)
>                 arm_pm_restart = mdesc->restart;
>
>         unflatten_device_tree();
>
> On powerpc, unflatten_device_tree is called way before paging_init, so I assume
> it has to be possible, but it might end up being harder to do than what you
> have in mind with parsing the flat device tree.

IIRC, the unflattening cannot be done before memblock is up which is
in arm_memblock_init. I believe that will get done earlier similar to
PPC with Laura's meminfo removal series. However, in interest of
getting output enabled as early as possible, the earliest point is
always going to be with a flat tree. So I think we do want to be able
to parse the flat tree for this. There's code in u-boot to do the
address translation on FDT we can steal. Really, i'd like to put that
code in libfdt, but there's a licensing problem with the u-boot code
being GPL and libfdt being BSD.

Rob
