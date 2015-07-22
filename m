From: manabian@gmail.com (Joachim Eastwood)
Date: Wed, 22 Jul 2015 23:26:34 +0200
Subject: next-20150722 build: 2 failures 75 warnings (next-20150722)
In-Reply-To: <20150722184345.GB11162@sirena.org.uk>
References: <E1ZHv2t-0004JI-0H@optimist> <20150722184345.GB11162@sirena.org.uk>
Message-ID: <CAGhQ9VxXdFOCZhEi07X_k-+zV9NpYG+Brnt_fjPT=3mdyeSrgg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 July 2015 at 20:43, Mark Brown <broonie@kernel.org> wrote:
> On Wed, Jul 22, 2015 at 03:30:56PM +0100, Build bot for Mark Brown wrote:
>
> Today's linux-next fails to build an ARM allmodconfig due to:
>
>> ERROR: "of_default_bus_match_table" [drivers/memory/pl172.ko] undefined!
>
> 17c50b700c3b4 (memory: add ARM PL172 MultiPort Memory Controller
> driver).  The symbol of_default_bus_match_table isn't exported by the OF
> core code so can't be referenced from modules.

Sorry about that. Seems like I didn't do a modular build after I
started to use "of_default_bus_match_table".
A quick fix would be to just replace "of_default_bus_match_table" with
NULL, but that means that child nodes that use "simple-bus" wouldn't
work. Since I don't have any nodes with "simple-bus" I'll send this
fix ASAP to Olof.

Grant/Rob: Would you be okay with a patch that exports
"of_default_bus_match_table"?
I think it would be useful for memory controllers to allow child nodes
that use "simple-bus" and "simple-mfd".

Note that "of_default_bus_match_table" is also used by
memory/omap-gpmc.c, but this drivers can only be built-in so it
doesn't face this problem.
memory/ti-aemif.c and memory/mvebu-devbus.c doesn't use
"of_default_bus_match_table", but again that means they can't have
child nodes with "simple-bus".


regards,
Joachim Eastwood
