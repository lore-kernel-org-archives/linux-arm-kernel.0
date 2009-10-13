From: alex@digriz.org.uk (Alexander Clouter)
Date: Tue, 13 Oct 2009 15:41:01 +0100
Subject: [PATCH] [ARM] kirkwood: combine support for openrd base/client
	?support
References: <20091009123956.GA6085@chipmunk>
	<200910120836.03584.dk-arm-linux@gmx.de>
	<20091012073122.GH6085@chipmunk>
	<200910120946.01628.dk-arm-linux@gmx.de>
	<ad9478410910120746g2ce82af1t71a84ea02e9eecb7@mail.gmail.com>
Message-ID: <t4geq6-pm4.ln1@chipmunk.wormnet.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Joel Stanley <joel@jms.id.au> wrote:
>
> On Mon, Oct 12, 2009 at 18:16, Dieter Kiermaier <dk-arm-linux@gmx.de> wrote:
>>> If you can point out where I should be looking, I will have a look and
>>> if I can find it I will enable it.
>>
>> I'm sorry, but I haven't an openrd-client board :(
>> Maybe someone else can help us?
> 
> I have tested Alexander's patch on my openrd-client board, applied to
> Linus' tree.  It boots and networking works fine.
> 
> I also added calls to initialise i2c and pcie based on the patch by
> Simon Kagstrom, and both devices appear to work.  The diff I added is
> attached.
> 
Hmmm, seems to now be working for me too, I have updated from 32-rc2 to 
rc4 so that probably fixed something along the way I suppose.

> Author: Joel Stanley <joel@jms.id.au>
> Date:   Tue Oct 13 00:02:04 2009 +1030
> 
>    Add pcie and i2c initalisation
> 
> diff --git a/arch/arm/mach-kirkwood/openrd-setup.c
> b/arch/arm/mach-kirkwood/openrd-setup.c
> index 6bdeeab..d5504e2 100644
> --- a/arch/arm/mach-kirkwood/openrd-setup.c
> +++ b/arch/arm/mach-kirkwood/openrd-setup.c
> @@ -80,6 +80,10 @@ static void __init openrd_init(void)
> #endif
>        kirkwood_sata_init(&openrd_sata_data);
>        kirkwood_sdio_init(&openrd_mvsdio_data);
> +
> +       kirkwood_i2c_init();
> +
> +       kirkwood_pcie_init();
> }
> 
> #ifdef CONFIG_MACH_OPENRD_BASE
>
I think to match the coding style of the other kirkwood boards this 
should go in a seperate pci_init function:
----
static int __init openrd_base_pci_init(void)
{
        kirkwood_pcie_init();

        return 0;
}
subsys_initcall(openrd_base_pci_init);
----

Well, included is my 'new' version with Nico's recommendation to remove 
the unnecessary ifdef's.

Cheers

-- 
Alexander Clouter
.sigmonster says: Pie are not square.  Pie are round.  Cornbread are square.
